GetDTB <- function(
    catch,
    data_dir = "Global_Soil_Regolith_Sediment_1304",
    outdir   = "Pelletier_DTB",
    username=NULL, password=NULL,
    keep_zip = FALSE
) 
{
  library(sf)  
  if (inherits(catch, "SpatVector")) {
    catch_v <- sf::st_as_sf(catch)
  } else if (inherits(catch, "sf")) {
    catch_v <- catch
  } else if (inherits(catch, "Spatial")) {   
    catch_v <- sf::st_as_sf(catch)
  } else {
    stop("`catch` must be a spatial object (SpatVector, sf, or sp::Spatial*).")
  }
  
  
  ## 2. Reproject to WGS84 (EPSG:4326) if needed
  wgs<-"+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
  catch_v = st_transform(catch_v, wgs)
  
  ## 3. Check data dir and output dir
  if (!dir.exists(data_dir)) {
    message("Data directory not found: ", data_dir,
            "\ncreating...")
    dir.create(outdir, showWarnings = FALSE)
  }
  
  download_pelettier_zip = function(password, username)
  {
    library(earthdatalogin)
    
    edl_netrc(username=username, password=password)
    
    href = "https://data.ornldaac.earthdata.nasa.gov/protected/bundle/Global_Soil_Regolith_Sediment_1304.zip"
    edl_download(
      href,
      dest = paste0(c(outdir, "/", basename(href)), collapse=""),
      auth = "netrc",
      method = "httr",
      #username = default("user"),
      #password = default("password"),
      #netrc_path = edl_netrc_path(),
      #cookie_path = edl_cookie_path(),
      quiet = FALSE
    )
  }  
  
  ## 4. Find Pelletier depth5 & depth6 rasters
  f_depth5_name <- "average_soil_and_sedimentary-deposit_thickness.tif"
  f_depth6_name <- "hill-slope_valley-bottom.tif"
  f_mask_name   <- "land_cover_mask.tif"
  
  
  all_tifs <- list.files(data_dir, pattern = "\\.tif$", full.names = TRUE, recursive = TRUE)
  f_depth5 <- all_tifs[grepl("average_soil_and_sedimentary-deposit_thickness", all_tifs)]
  f_depth6 <- all_tifs[grepl("hill-slope_valley-bottom", all_tifs)]
  f_mask   <- all_tifs[grepl("land_cover_mask", all_tifs)]
  
  if ((length(f_depth5) == 0) |
      (length(f_depth6) == 0) |
      (length(f_mask) == 0)
  )
  {
    srczip = paste0(c(data_dir, "/", basename(href)), collapse="")
    print(paste0("Some required grids not found, trying to unzip from '", srczip, "'..."))
    # check existence of Global_Soil_Regolith_Sediment_1304.zip
    if (!file.exists(srczip))
    {
      print(paste0(srczip, "' not found, trying to download with supplied credentials. Approx. 1 GB of storage and respective download time required ..."))
      download_pelettier_zip(password, username)
      print("Download completed.")
    }
    #unzip f_depth5 from srczip
    print(paste0(srczip, "' not found, trying to download with supplied credentials. Approx. 1 GB of storage and respective download time required ..."))
    filelist = unzip(zipfile = srczip, exdir = data_dir, list=TRUE)
    
    print("unzipping files from ZIP, needs another 0.5 GB ...")  
    unzip_these = grepl(x=filelist$Name, pattern= paste(c(f_depth5_name, f_depth6_name, f_mask_name), collapse="|"))
    unzip(zipfile = srczip, exdir = data_dir, files=filelist$Name[unzip_these])
    for (f in filelist$Name[unzip_these])
    {
      file.rename(from = paste0(data_dir,"/",f), to=paste0(data_dir,"/",basename(f)))
    }
    if (!keep_zip)
    {
      print("deleting ZIP to conserve space ...")  
      unlink(srczip)
    }  
  }
  
  f_depth5 <- f_depth5[1]
  f_depth6 <- f_depth6[1]
  f_mask   <- if (length(f_mask) > 0) f_mask[1] else NA_character_
  
  #message("Using depth5 source: ", basename(f_depth5))
  #message("Using depth6 source: ", basename(f_depth6))
  #if (!is.na(f_mask)) message("Using land cover mask: ", basename(f_mask))
  
  ## 5. Load rasters with terra
  r5 <- terra::rast(f_depth5)  # Pelletier depth-5
  r6 <- terra::rast(f_depth6)  # Pelletier depth-6
  
  ## 6. Crop & mask to catchment
  message("Cropping and masking depth5 ...")
  r5c <- terra::crop(r5, catch_v)
  r5c <- terra::mask(r5c, catch_v)
  
  message("Cropping and masking depth6 ...")
  r6c <- terra::crop(r6, catch_v)
  r6c <- terra::mask(r6c, catch_v)
  
  ## 7. Apply land-cover mask (if available, 0 = invalid)
  if (!is.na(f_mask)) {
    m <- terra::rast(f_mask)
    m <- terra::crop(m, catch_v)
    m <- terra::mask(m, catch_v)
    r5c <- terra::mask(r5c, m, maskvalues = 0)
    r6c <- terra::mask(r6c, m, maskvalues = 0)
  }
  
  ## 8. Save as depth_5.tif and depth_6.tif
  out5 <- file.path(outdir, "depth_5.tif")
  out6 <- file.path(outdir, "depth_6.tif")
  
  terra::writeRaster(r5c, out5, overwrite = TRUE)
  terra::writeRaster(r6c, out6, overwrite = TRUE)
  
  message("Created: ", out5)
  message("Created: ", out6)
  
  invisible(list(depth5 = r5c, depth6 = r6c))
}

