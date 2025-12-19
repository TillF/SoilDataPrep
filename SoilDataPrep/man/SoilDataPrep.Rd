\name{SoilDataPrep-package}
\alias{SoilDataPrep-package}
\alias{SoilDataPrep}
\docType{package}
\title{
\packageTitle{SoilDataPrep}
}
\description{
\packageDescription{SoilDataPrep}
}

\details{
\packageDESCRIPTION{SoilDataPrep}
\packageIndices{
GetDTB(catch)
GetDTB(catch)
SoilParams(catch, DEM, c=1000)
}}

\author{
\packageAuthor{SoilDataPrep}
\packageMaintainer{SoilDataPrep}
}

\references{
~~ Literature or other references for background information ~~
}
\keyword{ package }
\seealso{
~~ Optional links to other man pages, e.g. ~~
~~ \code{\link[<pkg>:<pkg>-package]{<pkg>}} ~~
}
\examples{
For a complete workflow, please check the example script examples/Example_isabena_tutorial.R

# #Create a spatial polygon
# library(sf)
# 
# catch = st_as_sfc(st_bbox(c(xmin=-44, ymin=-10, xmax=-43, ymax=-9)) ) #generate some map extent
# st_crs(catch) = st_crs(4326)
# 
# #Download soil characteristics from SoilGrids for the extent of this polygon:
# GetSG(catch)
# 
# #Download depth to bedrock from Pelletier et al. for the extent of this polygon:
# GetDTB(catch)
# 
# #Apply pedotransfer functions to the downloaded soil characteristics and prepare soil input tables for WASA-SED:
# #create a random DEM
# res <- 250 / 111320  # Convert meters to degrees
# bbox <- st_bbox(catch)
# 
# # Define number of columns and rows based on resolution and extent
# ncol <- ceiling((bbox$xmax - bbox$xmin) / res)
# nrow <- ceiling((bbox$ymax - bbox$ymin) / res)
# 
# # Create the empty raster
# DEM <- raster(ncols = ncol, nrows = nrow,
#               xmn = bbox$xmin, xmx = bbox$xmax,
#               ymn = bbox$ymin, ymx = bbox$ymax,
#               crs = st_crs(catch)$proj4string)
# # Fill the raster with random values (between 0 and 1)
# set.seed(42)  # For reproducibility
# values(DEM) <- runif(ncell(DEM))
# 
# DeriveSoilParams(catch, DEM)
}
