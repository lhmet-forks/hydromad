% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/intensity.R
\name{intensity}
\alias{intensity}
\alias{intensity.sim}
\alias{absorbScale.hydromad.intensity}
\title{Runoff as rainfall to a power}
\usage{
intensity.sim(DATA, power, maxP = 500, scale = 1, return_state = FALSE)
}
\arguments{
\item{DATA}{time-series-like object with columns \code{P} (precipitation)
and \code{Q} (streamflow).}

\item{power}{power on rainfall used to estimate effective rainfall.}

\item{maxP}{level of rainfall at which full runoff occurs (effective
rainfall == rainfall).}

\item{scale}{constant multiplier of the result, for mass balance.  If this
parameter is set to \code{NA} (as it is by default) in
\code{\link{hydromad}} it will be set by mass balance calculation.}

\item{return_state}{ignored.}
}
\value{
the simulated effective rainfall, a time series of the same length
as the input series.
}
\description{
Runoff as rainfall to a power.  This allows an increasing fraction of runoff
to be generated by increasingly intense/large rainfall events (for
\code{power > 0}).  The fraction increases up to a full runoff level at
\code{maxP}.
}
\examples{

## view default parameter ranges:
str(hydromad.options("intensity"))

data(HydroTestData)
mod0 <- hydromad(HydroTestData, sma = "intensity", routing = "expuh")
mod0

## simulate with some arbitrary parameter values
mod1 <- update(mod0, power = 1, maxP = 200, tau_s = 10)

## plot results with state variables
testQ <- predict(mod1, return_state = TRUE)
xyplot(cbind(HydroTestData[, 1:2], intensity = testQ))

## show effect of increase/decrease in each parameter
parRanges <- list(power = c(0, 2), maxP = c(100, 500), scale = NA)
parsims <- mapply(
  val = parRanges, nm = names(parRanges),
  FUN = function(val, nm) {
    lopar <- min(val)
    hipar <- max(val)
    names(lopar) <- names(hipar) <- nm
    fitted(runlist(
      decrease = update(mod1, newpars = lopar),
      increase = update(mod1, newpars = hipar)
    ))
  }, SIMPLIFY = FALSE
)

xyplot.list(parsims,
  superpose = TRUE, layout = c(1, NA),
  main = "Simple parameter perturbation example"
) +
  latticeExtra::layer(panel.lines(fitted(mod1), col = "grey", lwd = 2))
}
\seealso{
\code{\link{hydromad}(sma = "intensity")} to work with models as
objects (recommended).
}
\author{
Felix Andrews \email{felix@nfrac.org}
}
\keyword{models}
