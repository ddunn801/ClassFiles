outcomeFile <- read.csv("outcome-of-care-measures.csv",stringsAsFactors=FALSE)
outcomeFile[,11] <- as.numeric(outcomeFile[,11])
outcomeFile[,17] <- as.numeric(outcomeFile[,17])
outcomeFile[,23] <- as.numeric(outcomeFile[,23])

rankhospital <- function(state, outcome, num="best") {
  if (!(state %in% outcomeFile$State)) stop("invalid state")
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) stop("invalid outcome")
  outcomeFileST <- outcomeFile[outcomeFile$State==state,]
  if (num=="best") {num <- 1}
  if (outcome=="heart attack") {
    outcomeFileST <- outcomeFileST[!is.na(outcomeFileST[,11]),]
    if (num=="worst") {num <- nrow(outcomeFileST)}
    bestHospitals <- outcomeFileST[order(outcomeFileST[,11],outcomeFileST[,2],na.last=TRUE),]
  } else if (outcome=="heart failure") {
    outcomeFileST <- outcomeFileST[!is.na(outcomeFileST[,17]),]
    if (num=="worst") {num <- nrow(outcomeFileST)}
    bestHospitals <- outcomeFileST[order(outcomeFileST[,17],outcomeFileST[,2],na.last=TRUE),]
  } else {
    outcomeFileST <- outcomeFileST[!is.na(outcomeFileST[,23]),]
    if (num=="worst") {num <- nrow(outcomeFileST)}
    bestHospitals <- outcomeFileST[order(outcomeFileST[,23],outcomeFileST[,2],na.last=TRUE),]
  }
  return(bestHospitals[num,2])
}


#source("rankhospital.R")
#rankhospital("TX", "heart failure", 4)  #DETAR HOSPITAL NAVARRO
#rankhospital("MD", "heart attack", "worst")  #HARFORD MEMORIAL HOSPITAL
#rankhospital("MN", "heart attack", 5000)  #NA
