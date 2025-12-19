\name{GetSG}
\alias{GetSG}
\title{Download soil properties.}

\description{Function to download 8 x 6 + 1 raster files describing different soil characteristics for several depth with a resolution of 250 m for the required catchment/study area.}

\usage{GetSG(catch,
outdir = "SoilGrids"
)
}

\arguments{
  \item{catch}{
	shapefile of the catchment/study area, different projections are accepted. Read the shapefile with \code{sf::st_read()}.
	}
  \item{outdir = "SoilGrids"}{Destination directory where the cropped rasters of soil properties will be stored. Will be created, if missing.
}
}

\value{None.
 Returns 8 x 6 + 1 files in folder  \code{outdir} : 
\item{wrb}{soil class due to WRB}

The following characteristics are available for 6 depths: 0, 5, 15, 30, 60, 100, 200 cm (suffixes "sl1" - "sl7"):
\item{bdod}{Bulk density (fine earth) in kg / cubic-meter}
\item{cec}{Cation exchange capacity of soil in cmolc/kg}
\item{clay}{Clay content (0-2 micrometer) mass fraction in percent}
\item{cfvo}{Coarse fragments volumetric in percent}
\item{silt}{Silt content (2-50 micro meter) mass fraction in percent}
\item{sand}{Sand content (50-2000 micro meter) mass fraction in percent}
\item{phh2o}{Soil pH x 10 in H2O}
\item{soc}{Soil organic carbon content (fine earth fraction) in g per kg}

\item{WWP}{Available soil water capacity (volumetric fraction) until wilting point}
\item{AWCtS}{Saturated water content (volumetric fraction) for tS}

}

\details{"Downloads Soilgrids data from https://maps.isric.org . 


}
\references{
soilgrids.org
}
\author{Sophia Dobkowitz <dobkowit@uni-potsdam.de>}

\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
#Create a spatial polygon and download soil characteristics from SoilGrids for the extent of this polygon:
coords = matrix(c(-44,-10,    -41,-9,
                  -40,-13,    -45,-14), 
                ncol = 2, byrow = TRUE)
p <- Polygon(coords)
catch <- SpatialPolygons(list(Polygons(list(p), ID = "a")))
#plot(catch, axes = TRUE, col="yellow")
GetSG(catch)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~soilgrids }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~properties }% __ONLY ONE__ keyword per line
\keyword{ ~raster }% __ONLY ONE__ keyword per line
