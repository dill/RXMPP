\name{shout_settings}
\alias{shout_settings}
\title{Set the options for sending a message over XMPP}
\description{Sets all the options needed and created an object to give to \code{shout}.}
\usage{shout_settings(username, password=NULL, recipient=NULL, server=NULL,test.message="This is a test of RXMPP.")}
\arguments{
   \item{username}{Username to send the message from.}
   \item{password}{Password of the sending account, if not supplied will prompt (see details below).}
   \item{test.message}{Message sent to test the connection during setup. If NULL no message is send, defaults to \code{"This is a test of RXMPP."}}
   \item{recipient}{Address to send the message to, defaults to username.}
   \item{server}{Currently unused.}
}
\details{User is expected to supply at least \code{username} which should be a valid JID. In this case messages are send back to \code{username}.

If no \code{password} is supplied then the user is prompted for one (Mac and Linux only).

\code{test.message} is sent to make sure that the options are correct.}
\value{A \code{list} of all the above information.}
\references{XMPP standards foundation \url{http://xmpp.org/}.}
\author{David Lawrence Miller}
\note{Special thanks to Will Thompson and the wocky team.}
\seealso{\code{\link{shout}}}
\examples{
### Not run
conn_settings<-shout_settings("me@example.com")}
