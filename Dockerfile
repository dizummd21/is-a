# Use the official R-base image
FROM rocker/r-ver:4.3.1

# 1. System dependencies mit zusätzlichen Fixes für sf/giscoR
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
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# 2. R-Pakete einzeln oder mit strikter Fehlerprüfung installieren
# Wir installieren 'sf' zuerst separat, um sicherzugehen, dass es klappt.
RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org')" && \
    R -e "install.packages('sf', repos='https://cloud.r-project.org', dependencies=TRUE)" && \
    R -e "install.packages(c('shiny', 'shinyWidgets', 'dplyr', 'ggplot2', 'ggiraph', 'glue', 'readxl', 'tidyverse', 'giscoR', 'janitor', 'bslib'), repos='https://cloud.r-project.org')"

# Prüfen, ob sf wirklich geladen werden kann (Build schlägt fehl, wenn nicht)
RUN R -e "library(sf)"

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=3838)"]
