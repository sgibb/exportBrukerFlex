library("MALDIquant")
library("MALDIquantForeign")

source("exportBrukerFlex-methods.R")

## import example spectrum
s <- importBrukerFlex("data")[[1]]
exportBrukerFlex(s, file="notmodified", force=TRUE)

## do some preprocessing
m <- transformIntensity(s, savitzkyGolay)
exportBrukerFlex(m, file="modified", force=TRUE)

## maybe you have to click on "Process/Undo All Processing" in FlexAnalysis to
## see the raw data (we don't overwrite pdata/1/1r and pdata/1/procs but we
## could not simply remove this files)
