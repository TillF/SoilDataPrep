GetSG<-
  function(catch,
           outdir   = "SoilGrids"){
  
    library(sf)
    dir.create(outdir, showWarnings = FALSE)
    
    data("sysdata", package="SoilDataPrep")
    
    
    if (inherits(catch_v, "SpatVector")) {
      catch_v <- sf::st_as_sf(catch)
    } else if (inherits(catch_v, "sf")) {
      catch_v <- catch
    } else if (inherits(catch_v, "Spatial")) {   
      catch_v <- sf::st_as_sf(catch)
    } else {
      stop("`catch` must be a spatial object (SpatVector, sf, or sp::Spatial*).")
    }

    ## 2. Reproject to WGS84 (EPSG:4326) if needed
    wgs<-"+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
    catch_v = st_transform(catch_v, wgs)
    
    
    # Define new suffixes for file names
    new_suffixes <- c("sd1", "sd2", "sd3", "sd4", "sd5", "sd6")
    # Define old suffixes to be replaced
    old_suffixes <- c("0-5cm_mean", "5-15cm_mean", "15-30cm_mean", "30-60cm_mean", "60-100cm_mean", "100-200cm_mean")
    
    # Loop through all soilgrids layers download data for each
    for (sg_layer in SG_layers) {
      
      family_name <- strsplit(sg_layer, "_")[[1]][1]
      
      # Construct URL for current soil type
      url <- paste0("https://maps.isric.org/mapserv?map=/map/", paste0(family_name, ".map"), "&",
                    "SERVICE=WCS&VERSION=2.0.1&REQUEST=GetCoverage&",
                    "COVERAGEID=", sg_layer, "&FORMAT=image/tiff&",
                    "SUBSET=long(", st_bbox(catch_v)[1], ",", st_bbox(catch_v)[3], ")&",
                    "SUBSET=lat(", st_bbox(catch_v)[2], ",", st_bbox(catch_v)[4], ")&",
                    "SUBSETTINGCRS=http://www.opengis.net/def/crs/EPSG/0/4326&",
                    "OUTPUTCRS=http://www.opengis.net/def/crs/EPSG/0/4326")
      
      # Extract soil type name from URL
      old_filename <- gsub(".*COVERAGEID=|&.*", "", url)
      
      new_filename = old_filename
      for (i in seq_along(old_suffixes)) 
        new_filename <- gsub(pattern=old_suffixes[i], replacement=new_suffixes[i], x=new_filename)
      
      # Download file and save to disk
      destfile = paste0(outdir, "/", new_filename, ".tif")
      download.file(url, destfile = destfile, mode = "wb")
        
      # Print confirmation message
      cat("Downloaded", new_filename, "to", outdir, "\n")
    }
    
    
    url <- paste0("https://maps.isric.org/mapserv?map=/map/wrb.map&SERVICE=WCS&VERSION=2.0.1&REQUEST=GetCoverage&",
                  "COVERAGEID=MostProbable&FORMAT=image/tiff&",
                  "SUBSET=long(", st_bbox(catch_v)[1], ",", st_bbox(catch_v)[3], ")&",
                  "SUBSET=lat(", st_bbox(catch_v)[2], ",", st_bbox(catch_v)[4], ")&",
                  "SUBSETTINGCRS=http://www.opengis.net/def/crs/EPSG/0/4326&",
                  "OUTPUTCRS=http://www.opengis.net/def/crs/EPSG/0/4326")
    
    # Extract soil taxonomy from URL
    filename1 <- 'wrb'
    
    # Download file and save to disk
    download.file(url, destfile = paste0(outdir, "/", filename1, ".tif"), mode = "wb")
    
    # Print confirmation message
    cat("Downloaded", filename1, "to", outdir, "\n")

  }


