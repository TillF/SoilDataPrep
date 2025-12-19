\name{GetDTB}
\alias{GetDTB}
\title{Download depth to bedrock.}

\description{Function to download 2 global 1-km grids of "depth to bedrock"" for the required catchment/study area.}

\usage{GetDTB(catch,
data_dir = "Global_Soil_Regolith_Sediment_1304",
outdir   = "Pelletier_DTB",
username=NULL,
password=NULL,
keep_zip=FALSE
)}
\arguments{
  \item{catch}{
	shapefile of the catchment/study area, different projections are accepted. Read the shapefile with \code{sf::st_read()}.
  }
  \item{data_dir = "Global_Soil_Regolith_Sediment_1304"}{Directory where the data files downloaded from https://www.earthdata.nasa.gov reside. Will be created, if missing.
  }
  
  \item{outdir   = "Pelletier_DTB"}{Destination directory where the cropped rasters of soil depth will be stored. Will be created, if missing.
  }
    
  \item{username=NULL}{Password for accessing https://www.earthdata.nasa.gov . Not needed if the required files are found in \code{data_dir}.
  }
  
  \item{password=NULL}{Password for accessing https://www.earthdata.nasa.gov . Not needed if the required files are found in \code{data_dir}.
  }  
  
  \item{keep_zip=FALSE}{Keep full ZIP-file downloaded from https://www.earthdata.nasa.gov (~ 1 GB). Otherwise, only the two depth-to-bedrock rasters required for subsequent calls are kept.
  }  

}



\value{
Returns list of two terra-raster grids, also saved as files in a new folder \code{outdir}: 
\item{depth_5}{upland hill-slope soil thickness in m}
\item{depth_6}{upland valley-bottom and lowland sedimentary deposit thickness}
}

\details{The function acquires grids of estimated soil thickness to bedrock by Pelletier et al., 2016. Unfortunately, these grids are no longer available for download freely.
To automatically download the required files, please register at https://www.earthdata.nasa.gov and set the resulting username and password in the function call.
Sadly, there is no granular file access, so the resulting download is ~ 1 GB. However, use the downloaded files for subsequent call to save traffic.
}

\references{
Pelletier, J.D. et al. (2016): A gridded global data set of soil, immobile regolith, and sedimentary deposit thicknesses for regional and global land surface modeling, Journal of Advances in Modeling Earth Systems, 8.
}

\author{
Sophia Dobkowitz, Till Francke
}

\examples{
#Create a spatial polygon and download depth to bedrock from Pelletier et al. for the extent of this polygon:
coords = matrix(c(-44,-10,
                  -41,-9,
                  -40,-13,
                  -45,-14), 
                ncol = 2, byrow = TRUE)

p <- Polygon(coords)
catch <- SpatialPolygons(list(Polygons(list(P1), ID = "a")))
#plot(sp, axes = TRUE, col="yellow")
GetDTB(catch)
}

\keyword{ ~pelletier }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~depth }% __ONLY ONE__ keyword per line
\keyword{ ~thickness }% __ONLY ONE__ keyword per line
