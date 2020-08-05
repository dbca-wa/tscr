
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `tscr`: An R client for the Threatened Species and Communities DB (TSC) <img src="man/figures/tscr_logo.png" align="right" alt="tscr logo" width="120" />

<!-- badges: start -->

![CI](https://github.com/dbca-wa/tscr/workflows/tic/badge.svg) [![Test
coverage](https://codecov.io/gh/dbca-wa/tscr/branch/master/graph/badge.svg)](https://codecov.io/gh/dbca-wa/tscr?branch=master)
[![Last-changedate](https://img.shields.io/github/last-commit/dbca-wa/tscr.svg)](https://github.com/dbca-wa/tscr/commits/master)
[![GitHub
issues](https://img.shields.io/github/issues/dbca-wa/tscr.svg?style=popout)](https://github.com/dbca-wa/tscr/issues)
<!-- badges: end -->

The goal of `tscr` is to provide access to TSC data, and to provide
working examples of analysis and visualisation of TSC data to answer QA,
ecological, and management questions.

## Installation and Setup

You can install `tscr` from [GitHub](https://github.com/dbca-wa/tscr/)
with:

``` r
# install.packages("devtools")
remotes::install_github("dbca-wa/tscr")
```

To set up `tscr`, run `usethis::edit_r_environ()`, add your TSC API
Token, then restart your R session.

``` r
TSC_API_TOKEN="Token xxx"
```

Read `vignette("setup", package = "tscr")` (online
[here](https://dbca-wa.github.io/tscr/articles/setup.html)) to learn
more about the configuration of `tscr`.

## Working examples

Here we’ll list vignettes demonstrating working examples of answering
questions with TSC data.

## Contribute

Found a bug in `tscr`, need a new `tscr` feature, or need a working
example to generate a data product from TSC? Let us know
[here](https://github.com/dbca-wa/tscr/issues/new/choose)\!

Want to chat about TSC? Join the [“TSC” group on DBCA’s
Teams](https://teams.microsoft.com/_#/conversations/General?threadId=19:20412eea61c949e59460ece939a128cd@thread.tacv2&ctx=channel)\!
(You’ll need a DBCA account to access this group.)
