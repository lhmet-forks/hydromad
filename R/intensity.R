## hydromad: Hydrological Modelling and Analysis of Data
##
## Copyright (c) Felix Andrews <felix@nfrac.org>
##

#' Runoff as rainfall to a power
#'
#' Runoff as rainfall to a power.  This allows an increasing fraction of runoff
#' to be generated by increasingly intense/large rainfall events (for
#' \code{power > 0}).  The fraction increases up to a full runoff level at
#' \code{maxP}.
#'
#'
#' @name intensity
#' @aliases intensity.sim absorbScale.hydromad.intensity
#' @param DATA time-series-like object with columns \code{P} (precipitation)
#' and \code{Q} (streamflow).
#' @param power power on rainfall used to estimate effective rainfall.
#' @param maxP level of rainfall at which full runoff occurs (effective
#' rainfall == rainfall).
#' @param scale constant multiplier of the result, for mass balance.  If this
#' parameter is set to \code{NA} (as it is by default) in
#' \code{\link{hydromad}} it will be set by mass balance calculation.
#' @param return_state ignored.
#' @return the simulated effective rainfall, a time series of the same length
#' as the input series.
#' @author Felix Andrews \email{felix@@nfrac.org}
#' @seealso \code{\link{hydromad}(sma = "intensity")} to work with models as
#' objects (recommended).
#' @keywords models
#' @examples
#'
#' ## view default parameter ranges:
#' str(hydromad.options("intensity"))
#'
#' data(HydroTestData)
#' mod0 <- hydromad(HydroTestData, sma = "intensity", routing = "expuh")
#' mod0
#'
#' ## simulate with some arbitrary parameter values
#' mod1 <- update(mod0, power = 1, maxP = 200, tau_s = 10)
#'
#' ## plot results with state variables
#' testQ <- predict(mod1, return_state = TRUE)
#' xyplot(cbind(HydroTestData[, 1:2], intensity = testQ))
#'
#' ## show effect of increase/decrease in each parameter
#' parRanges <- list(power = c(0, 2), maxP = c(100, 500), scale = NA)
#' parsims <- mapply(
#'   val = parRanges, nm = names(parRanges),
#'   FUN = function(val, nm) {
#'     lopar <- min(val)
#'     hipar <- max(val)
#'     names(lopar) <- names(hipar) <- nm
#'     fitted(runlist(
#'       decrease = update(mod1, newpars = lopar),
#'       increase = update(mod1, newpars = hipar)
#'     ))
#'   }, SIMPLIFY = FALSE
#' )
#'
#' xyplot.list(parsims,
#'   superpose = TRUE, layout = c(1, NA),
#'   main = "Simple parameter perturbation example"
#' ) +
#'   latticeExtra::layer(panel.lines(fitted(mod1), col = "grey", lwd = 2))
#' @export
intensity.sim <-
  function(DATA, power, maxP = 500, scale = 1, return_state = FALSE) {
    if (NCOL(DATA) > 1) stopifnot("P" %in% colnames(DATA))
    P <- if (NCOL(DATA) > 1) DATA[, "P"] else DATA
    ## special value scale = NA used for initial run for scaling
    if (is.na(scale)) {
      scale <- 1
    }
    ## check values
    stopifnot(power >= 0)
    stopifnot(maxP > 0)
    stopifnot(scale >= 0)
    ## compute effective rainfall U
    scale * P * pmin((P^power) / (maxP^power), 1)
  }



intensity.ranges <- function() {
  list(
    power = c(0, 2),
    maxP = c(100, 1000),
    scale = NA_real_
  )
}


#' @export
absorbScale.hydromad.intensity <- function(object, gain, ...) {
  absorbScale.hydromad.scalar(object, gain, parname = "scale")
}
