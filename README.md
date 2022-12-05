
# nppR

## Overview

The package nppR provides a collection of tools for making inference
based on non-probability sample data by integrating information
from auxiliary probability sample data.

## Installation

``` r
# First, install dependencies:
install.packages(pkgs = c("R6","survey","tibble"))

# Install nppR from source of a particular tag; for example, to install from tag v1.13.003:
install.packages(repos = NULL, type = "source", pkgs = "https://github.com/StatCan/nppR/raw/v1.13.003/nppR_1.13.003.tar.gz")

# Or the development version from GitHub:
install.packages(pkgs = c("devtools"))
devtools::install_github("StatCan/nppR")
```

## References

Chu, Kenneth, and Beaumont, Jean-François. 2019.
"The Use Of Classification Trees To Reduce Selection Bias For A Non-Probability
Sample With Help From A Probability Sample"
*Proceedings of Survey Methodology Section of Statistical Society of Canada 2019 Annual Meeting*
<https://ssc.ca/sites/default/files/imce/survey_methods_4_-_the_use_of_classification_trees_to_reduce_selection_bias_for_a_non-probability_sample_with_help_from_a_probability_sample_chu_beaucmont-2019.pdf>
