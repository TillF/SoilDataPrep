\name{SoilParams}
\alias{SoilParams}
\title{Extract soil parameters using pedotransfer functions}

\description{
Function to treat the study area tile by tile. Slope is derived from the DEM to choose between the two depth to bedrock values. The other soil characteristics are from SoilGrids. Then, pedotransfer functions are applied to calculate the soil parameters and prepare the input tables for WASA-SED.}

\usage{SoilParams(catch, DEM, c=1000, resume=FALSE)}

\arguments{
\item{catch}{shapefile of the catchment/study area, different projections are accepted. Read the shapefile with \code{readOGR()}.}
\item{DEM}{digital elevation model of the study area (raster), different projections are accepted. Use gcs WGS1984 longlat directly to save time or if you run into memory problems. Read the raster file with \code{raster()}.}
\item{c}{maximum number of cells in x and y direction for single tiles, default is set to 1000, i.e. 1e6 cells. Decrease this number if you run into memory limitations.}
\item{resume}{resume a previous run, requires the files soil_sum_collected.txt and last_tile.txt. Default: FALSE}
}

\value{
The following files are produced:


\item{last_tile}{Indicates which was the last treated tile to allow continue a not-finished run from this tile with SoilParamsCont}
\item{soil_sum_recent}{Shows the results of the last calculated tile}
\item{soil_sum_collected}{Table where the results of all tiles are put together}
\item{soil_sum_weighted}{The final result of all tiles containing mean values for each soil_id, weighted due to the number of occurrence}
\item{Mapsoils/soils_catchment.tif}{Map with the new soil IDs; 1000 was added to soils within alluvial areas. See Details below. }

Input tables for WASA-SED:
\item{particle_classes}{Definition of particle classes}
\item{r_soil_contains_particles}{Fraction of each particle class for each soil_id, only topsoil is considered}
\item{horizons}{Describes each horizon of each soil_id}
\item{soils}{Bedrock, alluvium and organic matter content for each soil_id}
}

\details{
\bold{generated soil map}\cr
     The resulting soil map in Mapsoils/soils_catchment.tif is based on the soil classes given in the SoilGrids layer TAXNWRB ("most probable soil class").
	 Soils identified as especially deep have been tagged as "alluvial" and their respective ID increased by 1000.

    Codes and names: ftp://ftp.soilgrids.org/legends/TAXNWRB.qml 

    Legend & short characteristic of soil types: ftp://ftp.soilgrids.org/data/recent/SoilGrids250m_TAXNWRB_legend_June_2016.pdf

    Index of all SoilGrids legends: ftp://ftp.soilgrids.org/legends/
} 

\references{
Explanation & paper on SoilGrids:

        General explanation SoilGrids: https://www.isric.org/explore/soilgrids/

        SoilGrids250m: Global gridded soil information based on machine learning: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0169748#pone.0169748.ref015

FAO legend & explanation of soil types:

    World reference base for soil resources 2014: http://www.fao.org/3/i3794en/I3794en.pdf

}
\author{
Sophia Dobkowitz <dobkowitz@uni-potsdam.de>

Till Francke <francke@uni-potsdam.de>

Tobias Pilz <tpilz@uni-potsdam.de>}

\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
ptf.rawls, euptf
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function () 
}

