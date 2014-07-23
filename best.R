outcomeFile <- read.csv("outcome-of-care-measures.csv",stringsAsFactors=FALSE)
outcomeFile[,11] <- as.numeric(outcomeFile[,11])
outcomeFile[,17] <- as.numeric(outcomeFile[,17])
outcomeFile[,23] <- as.numeric(outcomeFile[,23])

best <- function(state, outcome) {
  if (!(state %in% outcomeFile$State)) stop("invalid state")
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) stop("invalid outcome")
  outcomeFileST <- outcomeFile[outcomeFile$State==state,]
  if (outcome=="heart attack") {
    bestHospitals <- outcomeFileST[order(outcomeFileST[,11],outcomeFileST[,2],na.last=TRUE),]
  } else if (outcome=="heart failure") {
    bestHospitals <- outcomeFileST[order(outcomeFileST[,17],outcomeFileST[,2],na.last=TRUE),]
  } else {
    bestHospitals <- outcomeFileST[order(outcomeFileST[,23],outcomeFileST[,2],na.last=TRUE),]
  }
  return(bestHospitals[1,2])
}


#best("TX","heart attack")  #CYPRESS FAIRBANKS MEDICAL CENTER
#best("TX", "heart failure")  #FORT DUNCAN MEDICAL CENTER"
#best("MD", "heart attack")  #JOHNS HOPKINS HOSPITAL, THE
#best("MD", "pneumonia")  #GREATER BALTIMORE MEDICAL CENTER"
#best("BB", "heart attack")  #invalid state
#best("NY", "hert attack")  #invalid outcome

