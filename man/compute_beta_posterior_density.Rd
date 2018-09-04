% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/basic_functions.R
\name{compute_beta_posterior_density}
\alias{compute_beta_posterior_density}
\title{compute_beta_posterior_density}
\usage{
compute_beta_posterior_density(beta_sample, param, progress = FALSE)
}
\arguments{
\item{beta_sample}{a list (given by the compute_beta function).}

\item{param}{(optional), a list containing:
\describe{
\item{grid}{a numerical vector, the observation time points.}
\item{burnin}{an integer, the number of iteration to drop from the Gibbs
      sample. (optional)}
\item{thin}{an integer, used to thin the Gibbs sample to compute an
      approximation of the posterior density of beta(t). (optional)}
 \item{lims_kde}{a numerical vector (yl,yu) XXXXXXXXXXX (optional)}
 \item{N}{an integer related to the precision of the approximation. (optional)}
 \item{new_grid}{a numerical vector.}
}}

\item{progress}{a logical value. If TRUE, the algorithm progress is displayed.
(optional)}
}
\value{
An approximation of the posterior density on a two-dimensional grid.
        (corresponds to the result of the \code{\link[=kde2d]{kde2d}} function)
}
\description{
Compute a graphical representation of the marginal posterior
             distributions of beta(t) for each t.
}
\details{
The sample is thinned in order to reduce the correlation and
          so the time of the computation of the function \code{\link[=kde2d]{kde2d}}.
}
\examples{
\donttest{
library(RColorBrewer)
data(data1)
data(param1)
res_Bliss_mult <- fit_Bliss(data=data1,param=param1)
q <- 1
diff_grid <- diff(param1$grids[[q]])[1]
param1$grids2[[q]] <- c(param1$grids[[q]]-diff_grid/2,
                       tail(param1$grids[[q]],1)+diff_grid/2)
param1$xlim[[q]] <- range(param1$grids2[[q]])
param_density<-list(grid= param1$grids[[q]],
                    iter= param1$iter,
                    p   = param1[["p"]][q],
                    n        = param1[["n"]],
                    thin     = 10,
                    burnin   = param1[["burnin"]],
                    lims_kde = param1$lims_kde[[q]],
                    h1       = param1$h1,
                    new_grid = param1[["new_grid"]],
                    xlim = range(param1$grids[[q]]) + c(-diff_grid,diff_grid),
                    progress = FALSE
)
density_estimate <- density_estimation(res_Bliss_mult$beta_sample[[1]],param_density)
image(density_estimate$res_kde2d,col=rev(heat.colors(100)))
}
}