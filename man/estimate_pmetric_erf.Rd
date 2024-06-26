% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_pmetric_erf.R
\name{estimate_pmetric_erf}
\alias{estimate_pmetric_erf}
\title{Estimate Parametric Exposure Response Function}
\usage{
estimate_pmetric_erf(formula, family, data, ...)
}
\arguments{
\item{formula}{a vector of outcome variable in matched set.}

\item{family}{a description of the error distribution (see ?gnm)}

\item{data}{dataset that formula is build upon (Note that there should be a
\code{counter_weight} column in this data.)}

\item{...}{Additional parameters for further fine tuning the gnm model.}
}
\value{
returns an object of class gnm
}
\description{
Estimate a constant effect size for matched and weighted data set using
parametric models
}
\details{
This method uses generalized nonlinear model (gnm) from gnm package.
}
\keyword{internal}
