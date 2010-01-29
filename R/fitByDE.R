## hydromad: Hydrological Modelling and Analysis of Data
##
## Copyright (c) Felix Andrews <felix@nfrac.org>
##


fitByDE <-
    function(MODEL, ...,
             objective = hydromad.getOption("objective"),
             control = DEoptim.control())
{
    library(DEoptim)
    start_time <- proc.time()
    parlist <- as.list(coef(MODEL, warn = FALSE))
    ## remove any missing parameters
    isok <- sapply(parlist, function(x) !any(is.na(x)))
    parlist <- parlist[isok]
    ## check which parameters are uniquely specified
    isfixed <- (sapply(parlist, length) == 1)
    if (all(isfixed)) {
        warning("all parameters are fixed, so can not fit")
        return(MODEL)
    }
    ## remove any fixed parameters
    parlist <- parlist[!isfixed]
    if (!isTRUE(hydromad.getOption("trace")))
            control$trace <- FALSE
    lower <- sapply(parlist, min)
    upper <- sapply(parlist, max)
    bestModel <- MODEL
    bestFunVal <- Inf
    do_de <- function(pars) {
        thisMod <- do.call("update", c(quote(MODEL), as.list(pars)))
        if (!isValidModel(thisMod))
            return(1e8)
        thisVal <- objFunVal(thisMod, objective = objective)
        if (thisVal < bestFunVal) {
            bestModel <<- thisMod
            bestFunVal <<- thisVal
        }
        thisVal
    }
    ans <- DEoptim(do_de, lower = lower, upper = upper,
                    control = control)
    #if (ans$convergence != 0) {
    #    if (!isTRUE(hydromad.getOption("quiet"))) {
    #        warning(ans$message)
    #    }
    #    bestModel$msg <- ans$message
    #}
    bestModel$funevals <- ans$nfeval
    bestModel$timing <- proc.time() - start_time
    return(bestModel)
}