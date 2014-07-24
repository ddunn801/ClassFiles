outcomeFile <- read.csv("outcome-of-care-measures.csv",stringsAsFactors=FALSE)
outcomeFile[,11] <- as.numeric(outcomeFile[,11])
outcomeFile[,17] <- as.numeric(outcomeFile[,17])
outcomeFile[,23] <- as.numeric(outcomeFile[,23])

rankall <- function(outcome, num="best") {
  states <- unique(outcomeFile$State)
  nstates <- length(states)
  if (!(outcome %in% c("heart attack","heart failure","pneumonia"))) stop("invalid outcome")
  hs <- data.frame(hospital=NA,state=states)
  numOrig <- num
  if (num=="best"|num=="worst") {num <- 1}
  for(i in 1:nstates){
    outcomeFileST <- outcomeFile[outcomeFile$State==states[i],]
    if (outcome=="heart attack") {
      if (numOrig=="worst") {
        bestHospitals <- outcomeFileST[order(-outcomeFileST[,11],outcomeFileST[,2],na.last=NA),]}
      else {bestHospitals <- outcomeFileST[order(outcomeFileST[,11],outcomeFileST[,2],na.last=NA),]}
    } else if (outcome=="heart failure") {
      if (numOrig=="worst") {bestHospitals <- outcomeFileST[order(-outcomeFileST[,17],outcomeFileST[,2],na.last=NA),]}
      else {bestHospitals <- outcomeFileST[order(outcomeFileST[,17],outcomeFileST[,2],na.last=NA),]}
    } else {
      if (numOrig=="worst") {bestHospitals <- outcomeFileST[order(-outcomeFileST[,23],outcomeFileST[,2],na.last=NA),]}
      else {bestHospitals <- outcomeFileST[order(outcomeFileST[,23],outcomeFileST[,2],na.last=NA),]}
    }
    hs[hs$state==states[i],1] <- bestHospitals[num,2]
  }
  hs <- hs[order(hs$state),]
  rownames(hs) <- hs$state
  return(hs)
}


#source("rankall.R")
head(rankall("heart attack", 20), 10)
#hospital state
# AK <NA> AK
# AL D W MCMILLAN MEMORIAL HOSPITAL AL
# AR ARKANSAS METHODIST MEDICAL CENTER AR
# AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
# CA SHERMAN OAKS HOSPITAL CA
# CO SKY RIDGE MEDICAL CENTER CO
# CT MIDSTATE MEDICAL CENTER CT
# DC <NA> DC
# DE <NA> DE
# FL SOUTH FLORIDA BAPTIST HOSPITAL FL

tail(rankall("pneumonia", "worst"), 3)
#hospital state
#WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
#WV PLATEAU MEDICAL CENTER WV
#WY NORTH BIG HORN HOSPITAL DISTRICT WY

tail(rankall("heart failure"), 10)
#hospital state
#TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
#TX FORT DUNCAN MEDICAL CENTER TX
#UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
#VA SENTARA POTOMAC HOSPITAL VA
#VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
#VT SPRINGFIELD HOSPITAL VT
#WA HARBORVIEW MEDICAL CENTER WA
#WI AURORA ST LUKES MEDICAL CENTER WI
#WV FAIRMONT GENERAL HOSPITAL WV
#WY CHEYENNE VA MEDICAL CENTER WY

