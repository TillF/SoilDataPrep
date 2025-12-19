#Test SoilDataPrep example (tutorial_isabena catchment)
# for installing dependencies, see install_dependencies.R

# get geodata: DTB & SoilGrids ####
library(SoilDataPrep)

catch = st_read("sub_isabena.shp") #read shape file denoting extent of study area (can be generated with lumpR::calc_cubbas())

GetDTB(catch) #download depth-to-bedrock grid (Pelettier-dataset)
GetSG(catch) #download soil properties - grids (Soilgrids data)

DEM = raster("dem_isabena.tif") # read DEM

# apply pedotransfer functions to grids, aggregate over soil classes, export result files ####
DeriveSoilParams(catch, DEM, resume = FALSE)


# check output tables ####

# last_tile<-read.table("last_tile.txt", header=T) #should contain the last tile
# soil_sum_collected<-read.table("soil_sum_collected.txt")
# summary(soil_sum_collected)
# 
# soil_sum_recent<-read.table("soil_sum_recent.txt")
# summary(soil_sum_recent)
# 
# soil_sum_weighted<-read.table("soil_sum_weighted.txt")
# summary(soil_sum_weighted)

# display output map
soilmap<-raster("MapSoils/soils_catchment.tif")
#table(soilmap[])
soilmap_spat = as(soilmap, "SpatRaster")
plot(soilmap_spat, main = "Categorical Soil Map with Distinct Colors")



  # ExportSoilpropsGrids() #optional: export all gripds of soil properties to ./euptf_attributes and ./euptf_rasters

