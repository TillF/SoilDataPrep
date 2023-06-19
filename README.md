# SoilDataPrep

Prepare soil parameterisation (e.g. for meso-scale hydrological modelling with WASA-SED), using the global datasets SoilGrids and Pelletier et al. (2016). Pedotransfer functions from other packages ```(ptf.rawls{soilwaterptf}, euptf{euptf})``` are applied to calculate soil characteristics.

Pelletier, J.D. et al. 2016, A gridded global data set of soil, immobile regolith, and sedimentary deposit thicknesses for regional and global land surface modeling, Journal of Advances in Modeling Earth Systems, 8.

## Installation
```

#install these libraries from CRAN, if you don't have them
library(sp)
library(raster)
library(rgdal)
library(rpart)
library(gWidgets)
library(gWidgetstcltk)
library(curl)
library(data.table)
library(panelaggregation)
library(devtools)
library("remotes")

#other libraries not on CRAN (for installation, see details in ```SoilDataPrep/example```)
library("euptf")
library("soiltexture")
library("soilwaterfun")
library("soilwaterptf")

#install SoilDataPrep package
  install_github(repo = "tillf/SoilDataPrep/SoilDataPrep")
  
library(SoilDataPrep)

```

## Input
DEM and shapefile of the catchment

## Example
An example workflow can be found in ```SoilDataPrep/example```
