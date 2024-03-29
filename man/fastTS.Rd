% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fastTS.R
\name{fastTS}
\alias{fastTS}
\alias{plot.fastTS}
\alias{coef.fastTS}
\alias{print.fastTS}
\alias{summary.fastTS}
\title{Fast time series modeling with ranked sparsity}
\usage{
fastTS(
  y,
  X = NULL,
  n_lags_max,
  gamma = c(0, 2^(-2:4)),
  ptrain = 0.8,
  pf_eps = 0.01,
  w_endo,
  w_exo,
  weight_type = c("pacf", "parametric"),
  m = NULL,
  r = c(rep(0.1, length(m)), 0.01),
  plot = FALSE,
  ncvreg_args = list(penalty = "lasso", returnX = FALSE, lambda.min = 0.001)
)

\method{plot}{fastTS}(x, log.l = TRUE, ...)

\method{coef}{fastTS}(object, choose = c("AICc", "BIC"), ...)

\method{print}{fastTS}(x, ...)

\method{summary}{fastTS}(object, choose = c("AICc", "BIC"), ...)
}
\arguments{
\item{y}{univariate time series outcome}

\item{X}{matrix of predictors (no intercept)}

\item{n_lags_max}{maximum number of lags to consider}

\item{gamma}{vector of exponent for weights}

\item{ptrain}{prop. to leave out for test data}

\item{pf_eps}{penalty factors below this will be set to zero}

\item{w_endo}{optional pre-specified weights for endogenous terms}

\item{w_exo}{optional pre-specified weights for exogenous terms (details)}

\item{weight_type}{type of weights to use for endogenous terms}

\item{m}{mode(s) for seasonal lags (used if weight_type = "parametric")}

\item{r}{penalty factors for seasonal + local scaling functions (used if
weight_type = "parametric")}

\item{plot}{logical; whether to plot the penalty functions}

\item{ncvreg_args}{additional args to pass through to ncvreg}

\item{x}{a fastTS object}

\item{log.l}{Should the x-axis (lambda) be logged?}

\item{...}{passed to downstream functions}

\item{object}{a fastTS object}

\item{choose}{which criterion to use for lambda selection (AICc or BIC)}
}
\value{
A list of class \code{fastTS} with elements

  \item{fits}{a list of lasso fits} \item{ncvreg_args}{arguments passed to
  ncvreg}
  \item{gamma}{the (negative) exponent on the penalty weights, one
  for each fit}
  \item{n_lags_max}{the maximum number of lags} \item{y}{the time series}
  \item{X}{the utilized matrix of exogenous features}
  \item{oos_results}{results on test data using best of fits}
  \item{train_idx}{index of observations used in training data}
  \item{weight_type}{the type of weights used for endogenous terms}
  \item{m}{the mode(s) for seasonal lags (used if weight_type =
  "parametric")} \item{r}{penalty factors for seasonal + local scaling
  functions}
  \item{ptrain}{the proportion used to train the model}

x invisibly

a vector of model coefficients

x (invisibly)

the summary object produced by ncvreg
  evaluated at the best tuning parameter combination
  (best AICc).
}
\description{
Uses penalized regression to quickly fit time series models with
potentially complex seasonal patterns and exogenous variables.
Based on methods described in Peterson & Cavanaugh (2024).
}
\details{
The default weights for exogenous features will be chosen based on a
  similar approach to the adaptive lasso (using bivariate OLS estimates). For
  lower dimensional X, it's advised to set \code{w_exo="unpenalized"},
  because this allows for statistical inference on exogenous variable
  coefficients via the \code{summary} function.

  By default, a seasonal frequency \code{m} must not be specified and the
  PACF is used to estimate the weights for endogenous terms. A parametric
  version is also available, which allows for a penalty scaling function that
  penalizes seasonal and recent lags less according to the penalty scaling
  functions described in Peterson & Cavanaugh (2024). See the
  \code{penalty_scaler} function for more details, and to plot the penalty
  function for various values of \code{m} and \code{r}.
}
\examples{
data("LakeHuron")
fit_LH <- fastTS(LakeHuron)
fit_LH
coef(fit_LH)
plot(fit_LH)

}
\references{
Breheny, P. and Huang, J. (2011) Coordinate descent algorithms
  for nonconvex penalized regression, with applications to biological feature
  selection. Ann. Appl. Statist., 5: 232-253.

  Peterson, R.A., Cavanaugh, J.E. (2022) Ranked sparsity: a cogent
  regularization framework for selecting and estimating feature interactions
  and polynomials. AStA Adv Stat Anal.
  https://doi.org/10.1007/s10182-021-00431-7

  Peterson, R.A., Cavanaugh, J.E. (2024). Fast, effective, and coherent time
  series modeling using the sparsity-ranked lasso. Statistical Modelling
  (accepted). DOI: https://doi.org/10.48550/arXiv.2211.01492
}
\seealso{
predict.fastTS
}
