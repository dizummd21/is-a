# 1. Basis-Image
FROM rocker/r-ver:4.3.1

# 2. System-Abhängigkeiten für räumliche Daten und Web-Apps
# 'libsqlite3-dev' ist entscheidend für das 's2' Paket.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libcairo2-dev \
    libxt-dev \
    libsqlite3-dev \
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Arbeitsverzeichnis setzen
WORKDIR /app

# 4. App-Dateien kopieren
COPY . /app

# 5. R-Pakete installieren (Nutzt Binaries für extreme Zeitersparnis)
# Wir installieren s2 und sf explizit vorab, um Abhängigkeiten zu sichern.
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
    install.packages('remotes'); \
    install.packages('s2'); \
    install.packages('sf'); \
    pkgs <- c('shiny', 'shinyWidgets', 'dplyr', 'ggplot2', 'ggiraph', 'glue', 'readxl', 'tidyverse', 'giscoR', 'janitor', 'bslib'); \
    install.packages(pkgs); \
    # Validierung: Abbruch, falls etwas fehlt \
    installed <- installed.packages()[, 'Package']; \
    required <- c('sf', 's2', pkgs); \
    missing <- required[!(required %in% installed)]; \
    if (length(missing) > 0) stop(paste('Installation fehlgeschlagen für:', paste(missing, collapse=', ')))"

# 6. Finaler Test-Check während des Builds
RUN R -e "library(sf); library(tidyverse); library(shiny)"

# 7. Port freigeben
EXPOSE 3838

# 8. App starten
CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]
