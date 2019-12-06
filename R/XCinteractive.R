##########################################################
## XCReadouts                                           ##
## A small package for keeping an eye on your           ##
## Thermo Orbitrap instrument temperatures and vacuums  ##
## Kate Wolfer                                          ##
## v 1.0, 05 Dec 2019                                   ##
##########################################################

XCinteractive <- function(getLog, i){

  # time-related column conversions for easier plot reads
  #convertSecs <- getLog[,1]/86400/365
  getTimeStamp <- trimws(sub("^[^  ]*", "", getLog[,2]))
  getDate <- sub(" .*", "", getLog[,2])

  # reconstruct data for clearer plots
  subsetData <- data.frame(getLog[,2],
                           round(as.numeric(getLog[,i]),2))
  findRemovals <- which(subsetData[,1] == "Date")
  if (length(findRemovals) > 0){
    subsetData <- subsetData[-findRemovals,]
    getDateCheck <- getDate[-findRemovals]
  } else {
    getDateCheck <- getDate
  }
  colnames(subsetData) <- c("Date", colnames(getLog)[i])

  # get date as colour
  getDateFactor <- as.factor(getDateCheck)
  subsetData$day <- getDateFactor

  # construct plot
  plotTitle <- paste(colnames(getLog)[i], ", ",
                     min(getDateCheck),' to ', max(getDateCheck),
                     sep = "")

  p <- plot_ly(data = subsetData,
               x = subsetData[,1], y = subsetData[,2],
               type = 'scatter', size = 3,
               color = subsetData$day,
               mode = 'markers') %>%

    layout(title = plotTitle,
           yaxis = list(title = paste(colnames(subsetData)[2])),
           xaxis = list(title = "time/date", tickangle = 270))


  return(p)
}
