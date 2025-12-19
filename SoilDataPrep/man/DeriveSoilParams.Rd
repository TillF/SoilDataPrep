\name{DeriveSoilParams}
\alias{DeriveSoilParams}
\title{Derive soil parameters from grid data using various pedotransfer functions}
\usage{DeriveSoilParams(catch, 
DEM, 
dtb_dir   = "Pelletier_DTB",
soilgrids_dir   = "SoilGrids",
max_cells=1000, 
soil_classes_infile=paste0(soilgrids_dir, "/wrb.tif"),
soil_classes_outfile = "Mapsoils/soils_catchment.tif"
resume=FALSE)}

\arguments{
\item{catch}{Catchment/study area as SpatVector or sf-object, different projections are accepted. Read be read from a shapefile e.g. with \link[sf]{st_read()}.}
\item{DEM}{digital elevation model of the study area (raster), different projections are accepted. Use gcs WGS1984 longlat (EPSG:4326) directly to save time or if you run into memory problems. Read the raster file e.g. with \link[raster]{raster()}.}
\item{dtb_dir   = "Pelletier_DTB"}{Directory containing the files containing depth-to-bedrock produced with \link{GetDTB()}.}
\item{soilgrids_dir   = "SoilGrids"}{Directory containing the SoilGrids file produced with \link{GetSG()}.} 
\item{max_cells}{maximum number of cells in x and y direction for single tiles, default is set to 1000, i.e. 1e6 cells. Decrease this number if you run into memory limitations when processing large areas.}
\item{soil_classes_infile=paste0(soilgrids_dir, "/wrb.tif")}{Raster input file containing a map of soil classes. By default taken from the output of \link{GetSG()}, this raster may also be replaced by more detailed data from other sources.}
\item{soil_classes_outfile = "Mapsoils/soils_catchment.tif"}{Name of raster output file to create containing the soil classes, e.g. for further use in lumpR.}
\item{resume}{resume an (interrupted) previous run, requires the files \code{soil_sum_collected.txt} and \code{last_tile.txt}. Default: \code{FALSE}}
}

\value{None, but numerous files are produced (see below).

The following files are produced:

\item{\code{last_tile.txt}}{Indicates which was the last treated tile to allow continue a not-finished run from this tile with SoilParamsCont}
\item{\code{soil_sum_recent.txt}}{Shows the results of the last calculated tile}
\item{\code{soil_sum_collected.txt}}{Table where the results of all tiles are put together}
\item{\code{soil_sum_weighted.txt}}{The final result of all tiles containing mean values for each soil_id, weighted due to the number of occurrence}
\item{\code{soil_classes_file}}{Raster map with the new soil IDs; 1000 was added to soils within alluvial areas. See Details below. }

Input tables for lumpR (or directly for WASA-SED):
\item{\code{particle_classes.dat}}{Definition of particle classes}
\item{\code{r_soil_contains_particles.dat}}{Fraction of each particle class for each soil_id, only topsoil is considered}
\item{\code{horizons}}{Describes each horizon of each soil_id}
\item{\code{soils}}{Bedrock, alluvium and organic matter content for each soil_id}
}

\description{
Derive soil parameters from grid data derived by \link{GetDTB()} and \link{GetSG()} using various pedotransfer functions, applied over the study area tile by tile (for large areas). 

Soil classes are defined by the input raster \code{soil_classes_infile}. Within these, the respective soil hydraulic properties are averaged.
}


\details{
Slope is derived from the DEM to choose between the two depth-to-bedrock values from the Pelettier-data. The soil characteristics are mainly derived from SoilGrids information. Then, pedotransfer functions are applied to calculate the soil parameters, which are written as ASCII-file in the format of WASA-SED soil files.
\bold{generated soil map}\cr
     The resulting soil map in \code{soil_classes_file} is based on the soil classes given in the \code{soil_classes_infile}, by default the SoilGrids layer TAXNWRB ("most probable soil class").
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
Sophia Dobkowitz, Till Francke, Tobias Pilz
}

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

