##########################################################
## XCReadouts                                           ##
## A small package for keeping an eye on your           ##
## Thermo Orbitrap instrument temperatures and vacuums  ##
## Kate Wolfer                                          ##
## v 1.0, 05 Dec 2019                                   ##
##########################################################

XCplot <- function(getLog, i){

  # time-related column conversions for easier plot reads
  #convertSecs <- getLog[,1]/86400/365
  getTimeStamp <- trimws(sub("^[^  ]*", "", getLog[,2]))
  getDate <- sub(" .*", "", getLog[,2])
  getDateCheck <- getDate[-which(getDate == "Date")]

  # colour palette for random sampling
  getCols <- c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072",
               "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5")
  selectCol <- sample(getCols,1)

  # create plot
  constrPlot <- ggplot2::ggplot(data = getLog, aes(x=getLog[,2],y=getLog[,i]))
  constrPlot <- constrPlot + ggplot2::geom_point(size = 3,
                                        colour = selectCol,
                                        alpha=0.7)

  constrPlot <- constrPlot + xlab('time/date') + ylab(colnames(getLog)[i])

  constrPlot <- constrPlot + theme(axis.text.x = element_text(angle = 90))

  constrPlot <- constrPlot + ggplot2::ggtitle(paste(colnames(getLog)[i], ", ",
                                           min(getDateCheck),' to ', max(getDateCheck),
                                           sep = ""))

  constrPlot <- constrPlot + theme(plot.title = element_text(hjust = 0.5,
                                                             size = 18))

  constrPlot <- constrPlot + theme(axis.line = element_line(colour = "black"),
                                   panel.grid.minor = element_line(colour="light grey", size=0.01),
                                   panel.border = element_blank(),
                                   panel.grid.major = element_line(colour="light grey", size=0.01),
                                   panel.background = element_blank())

  # if(dim(getLog)[1] > 100){
  #   reduceXaxis <-  seq(min(getLog[,1]),max(getLog[,1]),by = 86400)
  #   findIndices <- match(reduceXaxis,getLog[,1])
  #   constrPlot <- constrPlot + scale_x_discrete(breaks = getLog[findIndices,2])
  # }

  return(constrPlot)

}
