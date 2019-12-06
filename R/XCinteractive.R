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


  # colour palette for random sampling
  # getCols <- c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072",
  #              "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5")
  # selectCol <- sample(getCols,1)

  # construct plot
  plotTitle <- paste(colnames(getLog)[i], ", ",
                     min(getDateCheck),' to ', max(getDateCheck),
                     sep = "")

  p <- plot_ly(data = subsetData,
               x = subsetData[,1], y = subsetData[,2],
               type = 'scatter', size = 3,
               color = subsetData$day,
               mode = 'markers') %>%
               #colorscale='Viridis')

    layout(title = plotTitle,
           yaxis = list(title = paste(colnames(subsetData)[2])),
           xaxis = list(title = "time/date", tickangle = 270))

  # Create a shareable link to your chart
  # Set up API credentials: https://plot.ly/r/getting-started
  #chart_link = api_create(p, filename="test_vacuum_plot")
  #chart_link

  return(p)
}
