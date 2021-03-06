\name{SSS}
\alias{SSS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Shotgun stochastic search algorithm (SSS)
}
\description{
The Shotgun Stochastic Search (SSS) was proposed by Hans et al. (2007), which is a stochastic search algorithm for Bayesian variable selection.
}
\usage{
SSS(X,y,ind_fun,model,tuning,N=1000,C0=1,verbose=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{
the covariate matrix (a standardization is recommneded for nonlocal priors).
}
  \item{y}{
the response variable. 
}
  \item{ind_fun}{
  the log-marginal likelihood function of models, which is resulted from a pred-specified priors on the regression coefficients. The default is piMoM
}
  \item{model}{
the model prior; Uniform or Bernoulli_Uniform. The default is Bernoulli_Uniform
}
  \item{tuning}{
the tuning parameter for the objective function (tau for piMoM and peMoM priors; g for the g-prior).
}
  \item{N}{
 the number of iterations of the SSS; default is 1000.
}
  \item{C0}{
the number of repetition of  the S5 algorithm C0 times,default is 1. When the total number of variables is huge and real data sets are considered, using a large number of C0 is recommended, e.g., C0=10.  
}
 \item{verbose}{
 	if TRUE, the function prints the currnet status of the S5 in each temperature; the default is TRUE.
}
 }
 
\details{
Using the S5 (Shin et al., 2016+), you will get all the models searched by S5 algorithm, and their corresponding log (unnormalized) posterior probabilities, and also this function can receive searched model for g-prior,piMoM,and peMoM. 

After obtaining the object of the S5 function, by using the 'result' function, you can obtain the posterior probabilities of the searched models including the MAP model and  the marginal inclusion probabilities of each variable.

By using the procedure of Nikooienejad et al. (2016), the 'hyper_par' function chooses the tuning parameter for nonlocal priors (piMoM or peMoM priors).
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
\item{GAM}{ the binary vaiables of searched models by S5}
\item{OBJ}{ the corresponding log (unnormalized) posterior probability}
%% ...
}

\references{
Hans, C., Dobra, A., and West, M. (2007). Shotgun stochastic search for large p regression. Journal of the American Statistical Association, 102, 507-516.
}

\author{
Shin Minsuk and Ruoxuan Tian
}

\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
	\code{\link{result}}, \code{\link{S5_parallel}}, \code{\link{S5}}   
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
p=50
# p = 5000
n = 200

indx.beta = 1:5
xd0 = rep(0,p);xd0[indx.beta]=1
bt0 = rep(0,p); 
bt0[1:5]=c(1,1.25,1.5,1.75,2)*sample(c(1,-1),5,replace=TRUE)
xd=xd0
bt=bt0
X = matrix(rnorm(n*p),n,p)
y = crossprod(t(X),bt0) + rnorm(n)*sqrt(1.5)
X = scale(X)
y = y-mean(y)
y = as.vector(y)

### default setting
fit_de_SSS = SSS(X,y)

res_de_SSS = result(fit_de_SSS)
print(res_de_SSS$hppm) # the MAP model 
print(res_de_SSS$hppm.prob) # the posterior probability of the hppm 
plot(res_de_SSS$marg.prob,ylim=c(0,1),ylab="marginal inclusion probability") # the marginal inclusion probability 
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{Simplified Shotgun Stochastic Search with Screening}% use one of  RShowDoc("KEYWORDS")
\keyword{Shotgun Stochastic Search}% use one of  RShowDoc("KEYWORDS")
\keyword{Bayesian variable selection}% __ONLY ONE__ keyword per line
\keyword{g-prior}
\keyword{nonlocal prior}
\keyword{piMoM}
\keyword{peMoM}
