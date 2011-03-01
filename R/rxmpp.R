# RXMPP

# get the settings and set up the connection object
shout_settings<-function(username, password=NULL, test.message="This is a test of RXMPP.",
                        recipient=NULL, server="talk.google.com"){

   # if the password is NULL then ask for it
   if(is.null(password) & .Platform$OS.type!="windows"){
      cat("No password supplied.\n")
      password<-get_password()
   }else if(.Platform$OS.type=="windows"){
      cat("No password supplied AND you're running Windows\n")
      cat("Supply your password as an argument to shout_settings()\n")
      cat("(This wouldn't be a problem if you had a Mac or Linux box...)\n")
   }

   # create connection object
   conn<-list(username=username,password=password)


   # check that this works
   if(!is.null(test.message)){
      # assume we're sending messages to ourself if recipient is NULL
      if(is.null(recipient)){
         recipient<-username
      }
      test<-shout(test.message,recipient,conn)
   }

   # return the connection object
   return(conn)

}

# actually connect and send a message
shout<-function(message,conn,recipient){

   # assume we're sending messages to ourself if recipient is NULL
   if(is.null(recipient)){
      recipient<-conn$username
   }

   # load the library
   library.dynam("wocky-message",package=c("RXMPP"))
   
   # send the message using conn
   send_obj<-.C("rxmpp_send",
                in_jid=as.character(conn$username),
                in_password=as.character(conn$password),
                in_recipient=as.character(recipient),
                in_message=as.character(message))
   
   # unload the library
   library.dynam.unload("wocky-message",paste(.libPaths()[1],"/RXMPP",sep=""))

}

# with thanks to Noah at StackOverflow
# http://stackoverflow.com/questions/5154335/reading-user-input-without-echoing-it-r
get_password <- function() {
   cat("Password: ")
   system("stty -echo")
   a <- readline()
   system("stty echo")
   cat("\n")
   return(a)
}

