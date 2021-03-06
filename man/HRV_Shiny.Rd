% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Time Domain HRV Shiny Package.R
\name{HRV_Shiny}
\alias{HRV_Shiny}
\title{Shiny App Function}
\usage{
HRV_Shiny(imported_data, input)
}
\arguments{
\item{imported_data}{Imported csv file containing a single column of MS or RR values.}

\item{input}{Specify if the data imported data contains MS or RR values.}
}
\value{
Shiny
}
\description{
This function uses imported HRV data to generate a shiny app. Within the shiny app, the user can specify
the time segment that they are interested in, and generate time domain HRV statistics based on that time segment.
Within the app, time segments are specified to two decimal spaces (i.e., 3.50).
}
