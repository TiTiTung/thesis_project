
## Not run:
# Basic GARCH(1,1) Spec
data(dmbp)
spec = ugarchspec()
fit = ugarchfit(data = dmbp[,1], spec = spec)
fit
# object fit:
slotNames(fit)
# sublist fit@fit
names(fit@fit)
coef(fit)
infocriteria(fit)
likelihood(fit)
nyblom(fit)
signbias(fit)
head(sigma(fit))
head(residuals(fit))
head(fitted(fit))
gof(fit,c(20,30,40,50))
uncmean(fit)
uncvariance(fit)
#plot(fit,which="all")
# news impact example
spec = ugarchspec(variance.model=list(model="apARCH"))
fit = ugarchfit(data = dmbp[,1], spec = spec)
# note that newsimpact does not require the residuals (z) as it
# will discover the relevant range to plot against by using the min/max
# of the fitted residuals.
ni=newsimpact(z = NULL, fit)
#plot(ni$zx, ni$zy, ylab=ni$yexpr, xlab=ni$xexpr, type="l", main = "News Impact Curve")
## End(Not run)


#install.packages(c("quantmod","rugarch","rmgarch"))   
# only needed in case you have not yet installed these packages
library(quantmod)
library(rugarch)
library(rmgarch)


startDate = as.Date("2007-01-03") #Specify period of time we are interested in
endDate = as.Date("2018-04-30")

getSymbols("IBM", from = startDate, to = endDate)
getSymbols("GOOG", from = startDate, to = endDate)
getSymbols("BP", from = startDate, to = endDate)

rIBM <- dailyReturn(IBM)
rBP <- dailyReturn(BP)
rGOOG <- dailyReturn(GOOG)


# We put all data into a data frame for use in the multivariate model
rX <- data.frame(rIBM, rBP, rGOOG)
names(rX)[1] <- "rIBM"
names(rX)[2] <- "rBP"
names(rX)[3] <- "rGOOG"


ug_spec = ugarchspec()
ug_spec <- ugarchspec(mean.model=list(armaOrder=c(1,0)))

ken <- matrix(c(rBP, rGOOG), ncol = 2, dimnames = list(c("rBP", "rGOOG")))
colnames(ken) <- c("rBP", "rGOOG")
ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(1,1), include.mean=TRUE, external.regressors =ken ),  
                       distribution.model="norm")
#, external.regressors = rX[2:3]
fit = ugarchfit(spec = ug_spec, data = rIBM)
likelihood(fit)
coef(fit)

fit
ug_var <- ugfit@fit$var   # save the estimated conditional variances
ug_res2 <- (ugfit@fit$residuals)^2   # save the estimated squared residuals

plot(ug_res2, type = "l")
lines(ug_var, col = "green")

# DCC (MVN)
uspec.n = multispec(replicate(3, ugarchspec(mean.model = list(armaOrder = c(1,0)))))
multf = multifit(uspec.n, rX)
spec1 = dccspec(uspec = uspec.n, dccOrder = c(1, 1), distribution = 'mvnorm')
fit1 = dccfit(spec1, data = rX, fit.control = list(eval.se = TRUE), fit = multf)

