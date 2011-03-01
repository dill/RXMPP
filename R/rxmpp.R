# RXMPP

# get the settings and set up the connection object
shout_settings<-function(username, password=NULL, recipient=NULL, server="talk.google.com", 
                        test.message="This is a test of RXMPP."){

   ## this echoes the password back at the moment -- BAD
   ## if the password is NULL then ask for it
   #if(is.null(password)){
   #   cat("No password supplied.\nPassword:")
   #   password<-readLines(n=1)
   #}

   # create connection object
   conn<-list(username=username,password=password)


   # check that works
   test<-shout(test.message,recipient,conn)

   # return the connection object
   return(conn)

}

# actually connect and send a message
shout<-function(message,recipient,conn){

   # send the message using conn
   dyn.load("wocky-message")
   
   send_obj<-.C("rxmpp_send",
                in_jid=as.character(conn$username),
                in_password=as.character(conn$password),
                in_recipient=as.character(recipient),
                in_message=as.character(message))
   
   dyn.unload("wocky-message")

}
