if (is.null(getGeneric("exportBrukerFlex"))) {
  setGeneric("exportBrukerFlex", function(x, ...) {
    standardGeneric("exportBrukerFlex")
  })
}

setMethod(f="exportBrukerFlex",
          signature=signature(x="MassSpectrum"),
          definition=function(x, file, force=FALSE, ...) {
  ## test arguments
  if (file.exists(file) && !force) {
    stop("File already exists! Use ", sQuote("force=TRUE"), " to overwrite it.")
  }

  if (basename(x@metaData$file) != "fid") {
    stop("Spectrum seems to be no Bruker fid file.")
  }

  ## source directory (needed for acqus and other files)
  src <- dirname(x@metaData$file)

  ## remove fid from path
  path <- sub(pattern="fid$", replacement="", x=file)
  fid <- file.path(path, basename(dirname(x@metaData$file)), "fid")

  ## create destination
  if (!file.exists(path) && force) {
    dir.create(path, showWarnings=FALSE, recursive=TRUE)
  }

  ## copy source directory to new destination
  ## (very stupid approach but I don't know which information in acqus and
  ## pdata/1/procs is needed)
  file.copy(from=src, to=path, recursive=TRUE)

  ## overwrite fid file
  con <- file(fid, "wb")
  ## please note: fid files can only store integers
  writeBin(as.integer(x@intensity), con, size=4, endian="little")
  close(con)
})

