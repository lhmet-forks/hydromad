% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tryModelOrders.R
\name{tryModelOrders}
\alias{tryModelOrders}
\alias{summary.tryModelOrders}
\title{Compare calibrations with different transfer function (ARMA) orders for
routing.}
\usage{
tryModelOrders(
  expr,
  n = 0:3,
  m = 0:2,
  delay = hydromad.getOption("delay"),
  verbose = hydromad.getOption("trace")
)
}
\arguments{
\item{expr}{an expression to calibrate a hydromad model.}

\item{n}{the set of values of \var{n} to try (order of the auto-regressive
component).}

\item{m}{the set of values of \var{m} to try (order of the moving-average
component).}

\item{delay}{the set of delays to try.}

\item{verbose}{show detailed tracing output.}
}
\value{
a list of model objects, of class \code{hydromad.\link{runlist}}.
}
\description{
Compare calibrations with different transfer function (ARMA) orders for
routing.
}
\references{
P C Young?
}
\seealso{
\code{\link{armax}}, \code{\link{armax.sriv.fit}}
}
\author{
Felix Andrews \email{felix@nfrac.org}
}
\keyword{optimize}
