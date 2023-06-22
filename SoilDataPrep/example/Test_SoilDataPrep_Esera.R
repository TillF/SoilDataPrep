#Test SoilDataPrep example (Esera catchment)

#### installation
#install these packages from CRAN, if you don't have them:
library(devtools)
library(sp)
library(sf)
library(terra)
library(raster)
#install these packages manually, if you don't have them:



# install old version of gwidgets (no longer on CRAN), which is formally required by euptf
install.packages("https://cran.r-project.org/src/contrib/Archive/gWidgets/gWidgets_0.0-54.tar.gz")
# if "gWidgets" cannot be installed try to download it (https://cran.r-project.org/src/contrib/Archive/gWidgets/). 
#and install the latest version "gWidgets_0.0-54.tar.gz" 

#using RStudio. 
#Click Tools → Install Packages.
#Select Package Archive File (.zip, .tar.gz) in the Install from: slot.
#Find the corresponding file on the local machine, and click Open.
#Click Install.





#install euptf, new version by melwey
 install.packages("remotes")
 remotes::install_github("melwey/euptf")


#install euptf the previous version
 
#curl::curl_download(url = "https://esdac.jrc.ec.europa.eu/public_path/shared_folder/themes/euptf.zip", destfile = "euptf.zip")
#unzip(zipfile = "euptf.zip")
#untar("euptf_1.4.tar.gz")
#system("R CMD INSTALL euptf") #install from source
#unlink(c("euptf.zip", "euptf_vignette_1.4.pdf","euptf_1.4.tar.gz","euptf"), recursive = TRUE, force = TRUE) #clean up
library(euptf)

#install soiltexture
  #install_github(repo = "julienmoeys/soiltexture/pkg/soiltexture") #install soiltexture package

#install soilwaterfun  
  #install_github(repo = "julienmoeys/soilwater/pkg/soilwaterfun")

#install soilwaterptf package
  #install_github(repo ="julienmoeys/soilwater/pkg/soilwaterptf") #install soiltexture package
  
#install SoilDataPrep package
  #install_github(repo = "TillF/SoilDataPrep/SoilDataPrep")
  
library(SoilDataPrep)

#---------------------------------------------------------------------------------------

#### get geodata: DTB & SoilGrids####
catch<-readOGR(dsn = "e:/till/uni/gis/esera_2018/basin.shp")
GetDTB(catch) #download depth-to-bedrock grid
GetSG(catch) #download soilgrids - grids

DEM<-raster("e:/till/uni/gis/esera_2018/dem.tiff") # read in DEM

#### apply pedotransfer functions to grids, aggregate, export result files
SoilParams(catch, DEM, resume = FALSE)

#---------------------------------------------------------------------------------------
##### check output tables ####

last_tile<-read.table("last_tile.txt", header=T) #should contain the last tile

soil_sum_collected<-read.table("soil_sum_collected.txt")
summary(soil_sum_collected)

soil_sum_recent<-read.table("soil_sum_recent.txt")
summary(soil_sum_recent)

soil_sum_weighted<-read.table("soil_sum_weighted.txt")
summary(soil_sum_weighted)

soilmap<-raster("MapSoils/soils_catchment.tif")
plot(soilmap)

#WASA-SED input

particle_classes<-read.table("particle_classes.dat", header=T)

r_soil_contains_particles<-read.table("r_soil_contains_particles.dat", header=T)

horizons<-read.table("horizons.dat", fill=T, header=T, sep="\t")

soils<-read.table("soil.dat", header=T)


MapSoils_Results()

