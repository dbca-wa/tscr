% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tsc_msg.R
\name{tsc_msg_success}
\alias{tsc_msg_success}
\title{Print a green success message with a tick symbol}
\usage{
tsc_msg_success(message, verbose = tscr::get_tsc_verbose())
}
\arguments{
\item{message}{(chr) A message to print}

\item{verbose}{Whether to show verbose messages.
Default: \code{\link{get_tsc_verbose}}.}
}
\description{
\lifecycle{stable}
}
\examples{
tsc_msg_success("This is a success message.")
}
\seealso{
Other helpers: 
\code{\link{get_more}()},
\code{\link{tsc_msg_abort}()},
\code{\link{tsc_msg_info}()},
\code{\link{tsc_msg_noop}()},
\code{\link{tsc_msg_warn}()},
\code{\link{tsc_online}()},
\code{\link{tsc_works}()}
}
\concept{helpers}
