FROM rocker/r-ver:4.3.1

# 1. System-Abhängigkeiten (schlank gehalten)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libudunits2-dev libgdal-dev libgeos-dev libproj-dev \
    libssl-dev libcurl4-openssl-dev libxml2-dev \
    libfontconfig1-dev libcairo2-dev libxt-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# 2. Pakete über Posit Package Manager installieren (VIEL SCHNELLER)
# Wir erzwingen den Abbruch des Builds, falls ein Paket fehlschlägt.
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')); \
    install.packages('remotes'); \
    pkgs <- c('shiny', 'shinyWidgets', 'sf', 'dplyr', 'ggplot2', 'ggiraph', 'glue', 'readxl', 'tidyverse', 'giscoR', 'janitor', 'bslib'); \
    install.packages(pkgs); \
    if (!all(pkgs %in% installed.packages()[, 'Package'])) stop('Fehler: Einige Pakete wurden nicht installiert!')"

# 3. Sicherheitscheck: Lässt sich das Tidyverse wirklich laden?
RUN R -e "library(sf); library(tidyverse); library(giscoR)"

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]
