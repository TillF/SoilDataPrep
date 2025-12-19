#Till: earthdata seems to provide granular access on some collections in COG-format
# unfortunately, Pelettier is only available as zipped TIFs (12/2025), so we need to wornload it completely
eartdata_download=function()
{
stop("'No yet working.")
library(earthdatalogin)
  password="..."
  username="tillf"
  #edl_set_token() #apparently not needed
  edl_netrc(username=username, password=password)
  #with_gdalcubes()
  
  
  library(rstac)
  #original example
  url <- "https://cmr.earthdata.nasa.gov/cloudstac/LPCLOUD"
  #https://www.earthdata.nasa.gov/data/catalog/lpcloud-hlsl30-2.0 #url
  #https://cmr.earthdata.nasa.gov/search/collections.umm_json_v1_18_2?pretty=true&include_granule_counts=true&concept-id[]=C2021957657-LPCLOUD #API
  #HLSL30 #titel in WEbpage
  collection <- "HLSL30.v2.0"
  
  
  url <- "https://cmr.earthdata.nasa.gov/cloudstac/ORNL_CLOUD" #ok
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac" #404
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/SCIOPS" 0
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/CSDA"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/LAADS"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/OB_CLOUD"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/ASF"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/GHRC_DAAC"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/LARC_CLOUD"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/NSIDC_CPRD"
  # url <- "https://cmr.earthdata.nasa.gov/cloudstac/GES_DISC"
  # #url <- "https://cmr.earthdata.nasa.gov/cloudstac/LPCLOUD" #880
  
  
  #my attempts
  #https://www.earthdata.nasa.gov/data/catalog/ornl-cloud-global-soil-regolith-sediment-1304-1 #url
  #https://cmr.earthdata.nasa.gov/search/collections.umm_json_v1_18_2?pretty=true&include_granule_counts=true&concept-id[]=C2216864025-ORNL_CLOUD API
  #   
  #"Global_Soil_Regolith_Sediment_1304" #title in WEbpage
  collection <- "ornl-cloud-global-soil-regolith-sediment-1304-1" #401 matches, nix soil
  collection <- "Global_Soil_Regolith_Sediment_1304" #410 matches, nix soil
  collection <- "soil" #410 matches, nix soil
  collection <- "" #50 matches, nix soil
  #collection <- "*" #50 matches, nix soil
  
  
  #bbox <- c(xmin=-123, ymin=37.25, xmax=-122.0, ymax=38.25) 
  bbox <- as.numeric(st_bbox(catch_v)) #define bounding box based on supplied vector layer
  
  start <- "1900-05-20T00:00:00Z" # NASA requires this format, other STACs accept date-only
  end <- "2022-05-31T00:00:00Z"
  
  # Find all assets from the desired catalog. Can by quite slow.
  items <- stac(url) |> 
    stac_search(collections = collection,
                bbox = bbox,
                datetime = paste(start,end, sep = "/")) |>
    post_request() |>
    items_fetch()
  
  collections = array("", length(items$features))
  for (i in 1:length(items$features)) {
    collections[i] <- items$features[[i]]$collection
  }
  length(items$features)
  ix = grep(x=collections, pattern="soil", ignore.case=TRUE)
  #ix = grep(x=collections, pattern="eco", ignore.case=TRUE)
  collections[ix]
} 