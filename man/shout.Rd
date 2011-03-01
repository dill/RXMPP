\name{shout}
\alias{shout}
\title{Send a message via XMPP.}
\description{Sends \code{message} to \code{recipient} using account details specified in \code{conn}.}
\usage{}
\arguments{
   \item{message}{Character string of a message to send.}
   \item{conn}{List with username and password to send the message from, probably created by \code{shout_settings}.}
   \item{recipient}{Who the message is to be send to. (Defaults as \code{conn$username}.)}
}
\details{Sends \code{message} to \code{recipient} using the connection options specified in \code{conn}. If \code{recipient} is not specified then it sends a message to the user given in \code{conn}.}
\value{None. Errors are handled internally by wocky.}
\references{XMPP standards foundation \url{http://xmpp.org/}.}
\author{David Lawrence Miller}
\note{Special thanks to Will Thompson and the wocky team.}
\seealso{\code{\link{shout_settings}}}
\examples{
### Not run
conn_settings<-shout_settings("me@example.com")
shout("this is a message",conn_settings)
}
