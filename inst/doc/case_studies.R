## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(fastTS)
library(magrittr) # for pipe

## ----lakehuron----------------------------------------------------------------
data("LakeHuron")

fit_LH <- fastTS(LakeHuron)

fit_LH
coef(fit_LH)

## ----stocks-------------------------------------------------------------------
data("EuStockMarkets")
X <- as.numeric(time(EuStockMarkets))
X_sp <- splines::bs(X-min(X), df = 9)

fit_stock <- fastTS(log(EuStockMarkets[,1]), n_lags_max = 400, X = X_sp, w_exo = "unpenalized")
tail(coef(fit_stock), 11)

# insert plot? 

## ----nottem-------------------------------------------------------------------
data("nottem")
fit_nt <- fastTS(nottem, n_lags_max = 24)
coef(fit_nt)


## ----UKDriverDeaths-----------------------------------------------------------
data("UKDriverDeaths")
fit_ukdd <- fastTS(UKDriverDeaths, n_lags_max = 24)
coef(fit_ukdd)


## ----sunspot------------------------------------------------------------------

data("sunspot.month")
fit_ssm <- fastTS(sunspot.month)
fit_ssm

## ----sunspot2-----------------------------------------------------------------
summary(fit_ssm)

