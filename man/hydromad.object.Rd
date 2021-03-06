% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hydromad.R
\name{hydromad.object}
\alias{hydromad.object}
\alias{fitted.hydromad}
\alias{update.hydromad}
\alias{observed.hydromad}
\alias{residuals.hydromad}
\alias{coef.hydromad}
\alias{vcov.hydromad}
\alias{isValidModel}
\alias{print.hydromad}
\alias{logLik.hydromad}
\alias{deviance.hydromad}
\alias{str.hydromad.runlist}
\alias{isValidModel.default}
\alias{isValidModel.hydromad}
\title{Standard methods for Hydromad model objects}
\usage{
\method{fitted}{hydromad}(
  object,
  ...,
  U = FALSE,
  all = FALSE,
  feasible.bounds = FALSE,
  incl.other.vars = FALSE
)

\method{residuals}{hydromad}(object, ..., all = FALSE, boxcox = FALSE, start = NULL)

\method{observed}{hydromad}(object, ..., select = "Q", all = FALSE)

\method{vcov}{hydromad}(object, ...)

\method{logLik}{hydromad}(object, loglik = hydromad.getOption("loglik"), ...)

\method{deviance}{hydromad}(object, ...)

\method{print}{hydromad}(x, digits = max(3, getOption("digits") - 3), ...)

\method{str}{hydromad.runlist}(object, ...)

isValidModel(object, ...)

\method{isValidModel}{default}(object, ...)

\method{isValidModel}{hydromad}(object, ...)
}
\arguments{
\item{object}{an object of class \code{hydromad}.}

\item{\dots}{In the \code{update} method, parameter values or ranges for the
SMA and/or routing simulation functions can be given, as with the
\code{hydromad()} function.
default).}

\item{U}{to return modelled effective rainfall (the output from SMA) rather
than streamflow.}

\item{all}{if \code{TRUE}, return the entire time series for which data
exists. Otherwise, the warmup period (specified as an argument to
\code{\link{hydromad}} or \code{update}) is stripped off.}

\item{feasible.bounds}{if \code{TRUE}, then ensemble simulation bounds are
extracted and returned. This only works if a \emph{feasible set} has been
specified using \code{\link{defineFeasibleSet}} or the \code{update} method.
Note that the meaning depends on what value of \code{glue.quantiles} was
specified to those methods: it might be the overall simulation bounds, or
some GLUE-like quantile values. This will be indicated by the returned
column names.}

\item{incl.other.vars}{if \code{TRUE} and model returns a multivariate
object (e.g. because of \code{return_components} or \code{return_state}),
then return time series for all variables. Otherwise, return only the column
named \code{X} or \code{U} (if \code{U=TRUE}). Raises an error if the column
is missing.}

\item{boxcox}{Placeholder}

\item{start}{Placeholder}

\item{select}{data series to extract (from the original \code{DATA}
argument). Use \code{TRUE} to extract all columns.}

\item{loglik}{Placeholder}

\item{x}{Placeholder}

\item{digits}{Placeholder}
}
\value{
\code{update} returns a new \code{hydromad} object.

\code{fitted}, \code{observed} and \code{residuals} returns time series.

\code{coef} returns a named numeric vector, or a named \code{list} if one or
more parameters are not fully specified.

\code{getFreeParsRanges} returns a named list of parameter ranges, for each
parameter that has a range defined. Note that this excludes fixed parameters
and parameters defines as a set of discrete values, for which
\code{coef(object,warn=FALSE)} should be used instead.
}
\description{
A \code{hydromad} object represents a model, which may be fully specified
(calibrated) or be defined only by parameter ranges.  The model
specification and parameter values are stored along with the observed input
and output time-series data.
}
\details{
Several standard methods are available for \code{hydromad} objects:

(note: these are links to the generic functions only)

\code{\link{update}}, \code{\link{predict}}, \code{\link{fitted}},
\code{\link{observed}}, \code{\link{residuals}}, \code{\link{coef}},
\code{\link{vcov}}, etc.

The \code{\link[=summary.hydromad]{summary}} and
\code{\link[=predict.hydromad]{predict}} methods are documented on different
pages.

The main plot methods are \code{\link{xyplot.hydromad}} and
\code{\link{qqmath.hydromad}}.

\code{isValidModel()} returns \code{TRUE} only if the supplied
\code{hydromad} object is fully specified and has a calculated output
series.

To help sample parameters, \code{getFreeParsRanges} returns the list of
ranges of parameters that do not have fixed parameter values. In particular,
it is used in conjunction with \code{\link{evalPars}} to perform sensitivity
analyses.
}
\seealso{
\code{\link{hydromad}}, \code{\link{summary.hydromad}},
\code{\link{predict.hydromad}}, \code{\link{xyplot.hydromad}},
\code{\link{runlist}}, \code{\link{evalPars}}
}
\author{
Felix Andrews \email{felix@nfrac.org}
}
\keyword{methods}
