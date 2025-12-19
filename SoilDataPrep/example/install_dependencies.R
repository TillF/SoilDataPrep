#Test SoilDataPrep example (tutorial_isabena catchment)

# load dependencies ####
#install these packages from CRAN, if you don't have them:
library(devtools)
library(sp)
library(sf)
library(terra)
library(raster)
library(remotes)
#library(panelaggregation)

#install these packages manually, if you don't have them:

# install dependencies not on CRAN #### 
library(devtools)
# install old version of gwidgets (no longer on CRAN), which is formally required by euptf (alhough not used here)
if (!require(gWidgets))
  try(install.packages(pkgs="https://cran.r-project.org/src/contrib/Archive/gWidgets/gWidgets_0.0-54.tar.gz"))


#packages not on CRAN:
#install euptf, new version by melwey
if (!require(euptf))
 remotes::install_github("melwey/euptf")

  #install euptf the previous version
  #curl::curl_download(url = "https://esdac.jrc.ec.europa.eu/public_path/shared_folder/themes/euptf.zip", destfile = "euptf.zip")
  #unzip(zipfile = "euptf.zip")
  #untar("euptf_1.4.tar.gz")
  #system("R CMD INSTALL euptf") #install from source
  #unlink(c("euptf.zip", "euptf_vignette_1.4.pdf","euptf_1.4.tar.gz","euptf"), recursive = TRUE, force = TRUE) #clean up
library(euptf)

#install soiltexture
if (!require(soiltexture))
  devtools::install_github("julienmoeys/soiltexture/pkg/soiltexture")

#install soilwaterfun  
if (!require(soilwaterfun))
  devtools::install_github("julienmoeys/soilwater/pkg/soilwaterfun")

#install soilwaterptf package
if (!require(soilwaterptf))
  devtools::install_github("julienmoeys/soilwater/pkg/soilwaterptf") #install soiltexture package
  
#install SoilDataPrep package
install_github(repo = "TillF/SoilDataPrep/SoilDataPrep")