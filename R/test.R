#


con <- socketConnection(host = "talk.google.com", port = 5222, blocking = TRUE)

init<-"<stream:stream  xmlns:stream='http://etherx.jabber.org/streams' xmlns='jabber:server' to='gmail.com' version='1.0'>"
writeLines(init,con)

# check this
init.reply<-readLines(con,warn=FALSE)

# send the TLS stuff...
tls.stuff<-"<starttls xmlns='urn:ietf:params:xml:ns:xmpp-tls'/>"

writeLines(tls.stuff,con)
tls.reply<-readLines(con,warn=FALSE)
