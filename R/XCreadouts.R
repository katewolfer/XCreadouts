##########################################################
## XCReadouts                                           ##
## A small package for keeping an eye on your           ##
## Thermo Orbitrap instrument temperatures and vacuums  ##
## Kate Wolfer                                          ##
## v 1.0, 05 Dec 2019                                   ##
##########################################################

#' Generate ggplot2 and (interactive) plotly figures for Thermo Orbitrap
#' readouts, usually stored in log folder under Xcalibur
#'
#' @return \code{html} of measurements user-selected readback. Variables 'DATE'
#' or NA are not plotted.


XCreadouts <- function(){

  # find the logfile directory and set to work out of here
  logDir <- "C:/Xcalibur/system/Exactive/log"
  if (file.exists(logDir)){
    cat("Exactive log folder found!")
  } else {
    cat("No Exactive log folder exists - please check the folder location!")
    userDir <- readline(prompt="Enter the address of the log file location, using the format e.g. C:/Xcalibur/system/Exactive/log")
    logDir = userDir
  }

  setwd(logDir)

  # create the directory for readback plots in the log folder
  if (file.exists("C:/Xcalibur/system/Exactive/log/Readback plots")){
  } else {
    dir.create("C:/Xcalibur/system/Exactive/log/Readback plots")
  }

  # set directory for plot saving
  plotSaveDir <- "C:/Xcalibur/system/Exactive/log/Readback plots"

  # input the required maximum date for data retrieval
  userDate <- readline(prompt="Enter required date as year-month-day, e.g. 2019-11-11: ")
  dateRequired = as.Date(userDate)

  # list the files in the directory that have temperature in the filename
  # currently hard coded - may need to be adjusted for other instrument types
  temperatureFiles <- list.files(path = getwd(),
                                 pattern = "InstrumentTemperature")

  # trim the date stamp off
  adjustTempFiles <- trimws(sub("^[^20]*", "", temperatureFiles))
  fullDateList <- as.Date(sub(".log", "", adjustTempFiles))

  # match the date range and ensure user input reflects available data
  findDateMatch <- findInterval(dateRequired, fullDateList)
  if (findDateMatch > 0){
  } else {
    while (findDateMatch == 0) {
      cat("Date is out of instrument log date range! :")
      userDate <- readline(prompt = "Please re-enter required date as year-month-day, e.g. 2019-11-11: ")
      dateRequired = as.Date(userDate)
      findDateMatch <- findInterval(dateRequired, fullDateList)
    }
  }

  # parse all instrument data
  getLog <- XCstitch(dateRequired, temperatureFiles, findDateMatch)

  # get column list
  columnSelector <- print(colnames(getLog))

  # select column to plot
  userSelect <- readline(prompt="Enter required column: ")
  userSelect <- as.numeric(userSelect)

  # make static (ggplot2) figure
  makeGG <- XCplot(getLog, userSelect)

  # make interactive (plotly) figure and export as HTML file with datestamp
  makePlotly <- XCinteractive(getLog, userSelect)
  newsystime <- format(Sys.time(),"%Y-%m-%d %H.%M.%S")
  setwd(plotSaveDir)
  htmlwidgets::saveWidget(makePlotly,
                          paste(colnames(getLog)[userSelect]," ",
                                newsystime," .html",sep = ""))

}

## Adding plots together

# # pull out the text-based column names for easier manipulation later
# getColNames <- colnames(getLog)
# timeReads <- (1:3)
# vacuumReads <- (4:7)
# turboReads <- (8:28)
# ambientReads <- (29:30)
# instrumentReads <- (31:47)
#
#
# # vacuum reads
# p4 <- XCplot(getLog, 4)
# pt4 <- XCinteractive(getLog,getDate, 4)
# pt4
#
# p5 <- XCplot(getLog, 5)
# pt5 <- XCinteractive(getLog,getDate, 5)
# pt5
#
# p6 <- XCplot(getLog, 6)
# pt6 <- XCinteractive(getLog,getDate, 6)
# pt6
#
# vacuumPlot <- grid.arrange(p4,p5,p6,ncol = 1, nrow = 3)
# newsystime <- format(Sys.time(),"%Y-%m-%d %H.%M.%S")
#
# ## save plot as png file
# ggsave(paste("Vacuum reads plot",newsystime ,".png", sep = " "),
#        plot = vacuumPlot,
#        device = NULL, path = NULL,
#        scale = 1, width = 60, height = 60, dpi = 300,
#        units = c("cm"))
#
# dev.off()





