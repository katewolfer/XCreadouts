##########################################################
## XCReadouts                                           ##
## A small package for keeping an eye on your           ##
## Thermo Orbitrap instrument temperatures and vacuums  ##
## Kate Wolfer                                          ##
## v 1.0, 05 Dec 2019                                   ##
##########################################################

XCstitch <- function(dateRange, temperatureFiles, findDateMatch) {

  # stitch together therequired datafiles
  for (file in temperatureFiles[(findDateMatch+1):length(temperatureFiles)]){

    # if the merged dataset doesn't exist, create it
    if (!exists("dataset")){
      dataset <- read.table(file, header=TRUE, check.names = FALSE, sep="\t")
    }

    # if the merged dataset does exist, append to it
    if (exists("dataset")){
      temp_dataset <-read.table(file, header=TRUE, check.names = FALSE, sep="\t")
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
    }

  }

  dataset <- dataset[order(dataset[,2]),]

  return(dataset)

}

