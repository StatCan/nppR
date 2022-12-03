% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nppCART.R
\docType{class}
\name{nppCART}
\alias{nppCART}
\title{nppCART}
\format{
\code{\link{R6Class}} object
}
\usage{
nppCART(
  np.data = NULL,
  p.data = NULL,
  sampling.weight = NULL,
  bootstrap.weights = NULL,
  predictors = base::setdiff(base::colnames(p.data), c(sampling.weight,
    bootstrap.weights)),
  impurity = "entropy",
  min.cell.size.np = 10,
  min.cell.size.p = 10,
  min.impurity = 0.095,
  n.levels.approx.threshold = 10
)
}
\arguments{
\item{np.data}{(required) non-empty data frame containing data of the non-probability sample.}

\item{p.data}{(required) non-empty data frame containing data of the probability sample.}

\item{sampling.weight}{(required) character vector of length 1. Column name of 'p.data' corresponding to sampling weights. Must have positive values throughout.}

\item{bootstrap.weights}{(optional) character vector of length at least 1. Column name(s) in 'p.data' corresponding to the bootstrap weights.}

\item{predictors}{(optional) character vector of length at least 1. Column name(s) common to both 'np.data' and 'p.data' corresponding to predictor variables. If not specified, all column of 'p.data' except 'sampling.weight' and 'bootstrap.weights' are taken as predictors.}

\item{impurity}{(optional) character vector of length 1 specifying which impurity function to use. Must be one of 'gini' or 'entropy'. Default is 'entropy'.}

\item{min.cell.size.np}{(optional) numeric vector of length 1 specifying the minimum number of non-probability samnple units in a node for partitioning to continue for that node. Must be a positive integer. If not specified, default value of 10 is used.}

\item{min.cell.size.p}{(optional) numeric vector of length 1 specifying the minimum number of probability samnple units in a node for partitioning to continue for that node. Must be a positive integer. If not specified, default value of 10 is used.}

\item{min.impurity}{(optional) numeric vector of length 1 specifying the minimum impurity value below which node partitioning will stop. Must be a positive number. If not specified, default value of 0.095 is used.}

\item{n.levels.approx.threshold}{(optional) numeric vector of length 1. For each node and for each categorical (i.e. non-ordered factor) predictor variable, if the number of levels of the given categorical predictor variable is less than or equal to n.levels.approx.threshold, then all possible splits by the given categorical variable are considered; otherwse (i.e. if the number of levels of the given categorical predictor variable in the given node strictly exceeds n.levels.approx.threshold), then an approximate procedure is used. The input must be an integer greater than or equal to zero. If not specified, default value of 10 is used.}
}
\value{
The nppCART function returns an instance of a R6 class instantiated with the input parameters.
}
\description{
The nppCART algorithm, developed by Kenneth Chu and Jean-François Beaumont,
is intended for estimating the self-selection propensity of each unit
in a non-probability sample, via a variant of the CART algorithm,
by incorporating auxiliary information from an appropriate and compatible
probability sample.
For more information about the algorithm and underlying methodology,
please consult the vignette 'nppCART-article'
by executing the command: \code{vignette("nppCART-article")}.
}
\section{Fields}{

\describe{
\item{\code{predictors_factor}}{This field contains the inputted predictors that are unordered factors. It is used for internal calcuations.}

\item{\code{predictors_ordered_factor}}{This field contains the inputted predictors that are ordered factors. It is used for internal calcuations.}

\item{\code{predictors_numeric}}{This field contains the inputted predictors that are numeric. It is used for internal calcuations.}

\item{\code{nodes}}{This field contains the nodes of the tree generated by the grow method. It is used for internal calcuations.}

\item{\code{np.syntheticID}}{This field contains synthetic unique identifiers for the data in the non-probability sample. It is used for internal calcuations.}

\item{\code{p.syntheticID}}{This field contains synthetic unique identifiers for the data in the probability sample. It is used for internal calcuations.}

\item{\code{estimatedPopulationSize}}{This field contains the sum of all weights in the probablity sample. It is used for internal calcuations.}
}}

\section{Methods}{

\describe{
\item{\code{initialize(predictors, np.data, p.data, sampling.weight, bootstrap.weights, min.cell.size.np, min.cell.size.p, min.impurity)}}{This method is called when the R6 class is created (i.e. when nppCART is called). The arguments passed into nppCART are passed into initialize. This method contains input integrity checks to ensure that the arguments meet the required specifications. In addition, the method does some preprocessing of the input data.}
\item{\code{get_instantiation_data()}}{This method is used to retrieve the instantiation data.}
\item{\code{grow()}}{This method is used to grow a classification tree through recursive binary partitioning of the predictors. It operates in the R6 class internally, and does not have parameters or a return value. This method should be called after the initialization of the class.}
\item{\code{get_npdata_with_propensity(nodes)}}{This method returns a dataframe that contains the non-probability sample, with the tree-calculated values. The tree-calculated values include: the unique identifier for each node (called nodeID); the self-selection propensity for each member in the non-probability sample (called propensity); the number of members in the non-probability sample, which belong to each node (called np.count); the sum of the members’ sampling weights in the probability sample, which belong to each node (called p.weight); and the tree impurity of each node (called impurity). There is one parameter, nodes, which is passed in a value internally by default, and should not be modified. This method should be used after calling grow.}
\item{\code{get_pdata_with_nodeID(nodes)}}{This method returns a dataframe that contains the probability sample, with the tree-calculated values. The tree-calculated values include: the unique identifier (called nodeID) of the terminal node containing the probabiliy sample unit; the estimated self-selection propensity for non-probability sample units in the terminal node; the number of members in the non-probability sample, which belong to each node (called np.count); the sum of the members’ sampling weights in the probability sample, which belong to each node (called p.weight); and the tree impurity of each node (called impurity). There is one parameter, nodes, which is passed in a value internally by default, and should not be modified. This method should be used after calling grow.}
\item{\code{print()}}{This method is used to print the classification tree in a readable format (each node is on a separate line and indented appropriately). There is one parameter, FUN.format, which is a function that customizes the output format. This method should be used after calling grow.}
\item{\code{get_subtree_hierarchy()}}{If 'bootstrap.weights' are supplied, this method returns a list containing the data of the pruning sub-tree hierarchy.}
\item{\code{get_impurities_alphas_AICs()}}{If 'bootstrap.weights' are supplied, this method returns a data frame containing the alpha and AIC values of the sub-trees in the pruning sub-tree hierarchy.}
}
}

\examples{
# See the vignette 'nppCART-usage' for more details, by executing the command: vignette("nppCART-usage")

### Generate data frame for synthetic population
population.size <- 10000;

temp.centres <- c(0.5,1.5,2.5);
c1 <- sample(x = temp.centres, size = population.size, replace = TRUE);
c2 <- sample(x = temp.centres, size = population.size, replace = TRUE);

true.propensity <- rnorm(n = population.size, mean = 0.25, sd = 0.025);
is.high.propensity <- (c2 - c1 == 1 | c2 - c1 == -1);
true.propensity[is.high.propensity] <- rnorm(n = sum(is.high.propensity), mean = 0.75, sd = 0.025);

sigma <- 0.20;
x1 <- c1 + rnorm(n = population.size, mean = 0, sd = sigma);
x2 <- c2 + rnorm(n = population.size, mean = 0, sd = sigma);

y0 <- rep(x = 30, times = population.size);
y0[is.high.propensity] <- 110;

epsilon <- rnorm(n = population.size, mean = 0, sd = 1.0)
y <- y0 + epsilon^2;

DF.population <- data.frame(
    unit.ID         = seq(1,population.size),
    y               = y,
    x1.numeric      = x1,
    x2.numeric      = x2,
    true.propensity = true.propensity
    );

for ( colname.numeric in c("x1.numeric","x2.numeric") ) {

    temp.quantiles <- quantile(
        x     = DF.population[,colname.numeric],
        probs = c(1,2,3)/3
        );

    is.small  <- ifelse(DF.population[,colname.numeric] <  temp.quantiles[1],TRUE,FALSE);
    is.medium <- ifelse(DF.population[,colname.numeric] >= temp.quantiles[1] & DF.population[,colname.numeric] < temp.quantiles[2],TRUE,FALSE);
    is.large  <- ifelse(DF.population[,colname.numeric] >= temp.quantiles[2],TRUE,FALSE);

    colname.factor <- gsub(x = colname.numeric, pattern = "\\\\.numeric", replacement = "");
    DF.population[,colname.factor] <- character(nrow(DF.population));

    if ( "x1.numeric" == colname.numeric ) {
        DF.population[is.small, colname.factor] <- "small";
        DF.population[is.medium,colname.factor] <- "medium";
        DF.population[is.large, colname.factor] <- "large";
        temp.levels <- c("small","medium","large");
    } else {
        DF.population[is.small, colname.factor] <- "petit";
        DF.population[is.medium,colname.factor] <- "moyen";
        DF.population[is.large, colname.factor] <- "grand";
        temp.levels <- c("petit","moyen","grand");
        }

    DF.population[,colname.factor] <- factor(
        x       = DF.population[,colname.factor],
        levels  = temp.levels,
        ordered = TRUE
        );

    colname.jitter <- gsub(x = colname.numeric, pattern = "numeric", replacement = "jitter");
    DF.population[,colname.jitter] <- (-0.5) + as.numeric(DF.population[,colname.factor]) + runif(n = nrow(DF.population), min = -0.3, max = 0.3);

    DF.population <- DF.population[,setdiff(colnames(DF.population),colname.numeric)];

    }

### Generate data frame for non-probability sample
DF.non.probability <- DF.population;
DF.non.probability[,"self.selected"] <- sapply(
    X   = DF.non.probability[,"true.propensity"],
    FUN = function(x) { sample(x = c(FALSE,TRUE), size = 1, prob = c(1-x,x)) }
    );
DF.non.probability <- DF.non.probability[DF.non.probability[,"self.selected"],c("unit.ID","y","x1","x2","x1.jitter","x2.jitter")];

### Generate data frame for probability sample
prob.selection <- 0.1;
is.selected <- sample(
    x       = c(TRUE,FALSE),
    size    = nrow(DF.population),
    replace = TRUE,
    prob    = c(prob.selection, 1 - prob.selection)
    );
DF.probability <- DF.population[is.selected,c("unit.ID","x1","x2")];
DF.probability[,"design.weight"] <- 1 / prob.selection;

### Instantiate nppCART object
my.nppCART <- nppR::nppCART(
    np.data         = DF.non.probability,
    p.data          = DF.probability,
    predictors      = c("x1","x2"),
    sampling.weight = "design.weight"
    );

### Grow the classification tree
my.nppCART$grow();

### Inspect the fully grown tree
my.nppCART$print( FUN.format = function(x) {return(round(x,digits=3))} );

### Extract the nppCART-estimated propensities
DF.npdata.estimated.propensity <- my.nppCART$get_npdata_with_propensity();

}