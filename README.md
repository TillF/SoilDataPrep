# SoilDataPrep

Prepare soil parameterisation (e.g. for meso-scale hydrological modelling with [WASA-SED](https://github.com/TillF/WASA-SED) in conjunction with [lumpR](https://github.com/tpilz/lumpR) ), using the global datasets [SoilGrids](https://soilgrids.org/) and Pelletier et al. (2016). 
Pedotransfer functions from other packages ```(soilwaterptf::ptf.rawls(), euptf::predict.ptf())``` are applied to calculate soil characteristics.

Pelletier, J.D. et al. 2016, A gridded global data set of soil, immobile regolith, and sedimentary deposit thicknesses for regional and global land surface modeling, Journal of Advances in Modeling Earth Systems, 8.

## Installation
```
see details in [```SoilDataPrep/example/install_dependencies.R```](SoilDataPrep/example/install_dependencies.R)

library(SoilDataPrep)

```

## Input
DEM and shapefile of the catchment

## Example
An example workflow can be found in [SoilDataPrep/example/Example_isabena_tutorial.R](SoilDataPrep/example/Example_isabena_tutorial.R)

