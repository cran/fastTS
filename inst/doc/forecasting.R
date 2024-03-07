## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(fastTS)
library(tibble)
set.seed(123)

## ----sunspot------------------------------------------------------------------

data("LakeHuron")
years <- time(LakeHuron)
fit <- fastTS(LakeHuron, n_lags_max = 3)
fit

## ----predict------------------------------------------------------------------
p1 <- predict(fit, n_ahead = 1)
p7 <- predict(fit, n_ahead = 7)
predictions <- tibble(years, LakeHuron, p1, p7)
head(predictions, 10)
tail(predictions)

## ----forecasting--------------------------------------------------------------
p1 <- predict(fit, n_ahead = 1, forecast_ahead = TRUE) 
predictions <- tibble(time = c(1973), p1)


# For 7-step ahead forecasts
p7 <- predict(fit, n_ahead = 7, forecast_ahead = TRUE)
predictions <- tibble(time = c(1973:1979), p7)
predictions

## -----------------------------------------------------------------------------
p1_p7 <- predict(fit, n_ahead = 7, return_intermediate = TRUE)

predictions <- tibble(years, LakeHuron, p1_p7)
tail(predictions)

