# installs dependencies, runs R CMD check, runs covr::codecov()
do_package_checks(error_on="error")

# if (ci_on_ghactions()) {
#   do_pkgdown()
# }