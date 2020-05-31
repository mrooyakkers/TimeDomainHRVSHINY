#' Time Domain HRV Shiny Package
#'
#' Time-Domain Heart Rate Variability Analysis is one way to analyze and interpret
#' heart rate data. Time domain indicies quantify the amount of variance in the
#' inter-beat-intervals (IBI). It is frequently used across different domains of
#' research, such as medicine, human kinetcs, and psychology. Benefits of this method
#' is that the cost of collecting this type of data is relatively low compared to other
#' methods and statistical outputs can be compared across individuals.
#'
#' This package contains a single function to generate a shiny application, so that the
#' user can easily interface and analyze their data. This application is based on the
#' TimeDomainHRV package, which can be accessed using:
#'
#' install_github("mrooyakkers/TimeDomainHRV", force = TRUE)
#'
#' Complete time domain HRV analysis can be done using either the TimeDomainHRV or the TimeDomainHRVSHINY package.
#' However, the shiny application may be more suitable for individuals looking to take multiple values based on time
#' points from their data, as the shiny application allows the user to quickly specify a new time frame, and generate
#' statistics based on that time frame.
#'
#' @section HRV Shiny
#' This function generates a shiny application based on the imported data.
#'
#' @details
#' Shaffer, F., & Ginsberg, J. P. (2017). An overview of heart rate variability metrics and norms. Frontiers in public health, 5, 258.
