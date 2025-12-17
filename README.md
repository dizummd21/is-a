```markdown
# ISMG_landkreis_karte

**DE:** Interaktive R-Shiny-Anwendung zur Visualisierung von Daten auf Ebene der deutschen *Landkreise*.  
**EN:** Interactive R Shiny application for visualizing data at the level of German *Landkreise* (districts).

---

## 🇩🇪 Deutsch

### Überblick

Dieses Repository enthält eine R-Shiny-App zur Darstellung geografischer und statistischer Daten für deutsche Landkreise. Die Anwendung ist modular aufgebaut und ermöglicht eine interaktive Kartenvisualisierung.

### Funktionen

- Interaktive Karte aller deutschen Landkreise  
- Visualisierung verschiedener Indikatoren  
- Modulare Shiny-Struktur (UI & Server)  
- Nutzung von Geo- und Tabellendaten  

### Projektstruktur

```
ISMG_landkreis_karte/
├── app/                     # Shiny app components
├── data/                    # Spatial and statistical data
├── modules/                 # Shiny modules
├── rsconnect/               # Deployment configuration
├── www/                     # Static web assets
├── app.R                    # App entry point
├── global.R                 # Global definitions & data loading
├── .Rproj                   # RStudio project file
├── README.md                # Documentation
```

### Voraussetzungen

```r
install.packages(c(
  "shiny",
  "leaflet",
  "sf",
  "dplyr",
  "tidyr",
  "readr"
))
````

### Anwendung starten

```r
shiny::runApp("pfad/zum/ISMG_landkreis_karte")
```

Oder `app.R` in RStudio öffnen und **Run App** klicken.

### Daten

Der Ordner `data/` enthält:

* Geodaten (z. B. Shapefiles oder GeoJSON) für Landkreise
* Tabellarische Daten zur thematischen Auswertung

Für Datenverknüpfungen sollten eindeutige Schlüssel (z. B. AGS) verwendet werden.

### Deployment

Die App kann über **shinyapps.io** veröffentlicht werden:

```r
rsconnect::deployApp()
```

### Lizenz

Hier die verwendete Lizenz angeben (z. B. MIT, GPL-3).

---

## 🇬🇧 English

### Overview

This repository contains an R Shiny application for visualizing geographic and statistical data at the level of German districts (*Landkreise*). The app is modular and provides an interactive map-based interface.

### Features

* Interactive map of all German districts
* Visualization of selectable indicators
* Modular Shiny architecture (UI & server)
* Integration of spatial and tabular data

### Project Structure

```
ISMG_landkreis_karte/
├── app/                     # Shiny app components
├── data/                    # Spatial and statistical data
├── modules/                 # Shiny modules
├── rsconnect/               # Deployment configuration
├── www/                     # Static web assets
├── app.R                    # App entry point
├── global.R                 # Global definitions & data loading
├── .Rproj                   # RStudio project file
├── README.md                # Documentation
```

### Requirements

```r
install.packages(c(
  "shiny",
  "leaflet",
  "sf",
  "dplyr",
  "tidyr",
  "readr"
))
```

### Run the App

```r
shiny::runApp("path/to/ISMG_landkreis_karte")
```

Or open `app.R` in RStudio and click **Run App**.

### Data

The `data/` directory contains:

* Spatial boundary data (e.g. Shapefile or GeoJSON)
* Tabular datasets for thematic indicators

Consistent identifiers (e.g. AGS codes) should be used for data joins.

### Deployment

The app can be deployed via **shinyapps.io**:

```r
rsconnect::deployApp()
```

### License

MIT, GPL-3

---

```
