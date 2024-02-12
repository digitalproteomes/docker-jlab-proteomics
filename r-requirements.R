options(repos="https://cran.rstudio.com" )

                                        # Latest foreign version is not compatible with R 3.6.3
require(devtools)
install_version("foreign", version="0.8-70")

# Add BioConductor dependencies here
bioc_deps <- c("MSstats", "proBatch", "SWATH2stats","OmnipathR")

# Add CRAN dependencies here
cran_deps <- c("ggdendro", "ggpubr", "aLFQ", "ggthemes", "grImport", "roxygen2")
                              
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(bioc_deps) 
install.packages(cran_deps)



