#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#include <glib.h>

#include <gio/gio.h>
#include <wocky/wocky-connector.h>
#include <wocky/wocky-xmpp-connection.h>
#include <wocky/wocky.h>
#include <wocky/wocky-porter.h>
#include <wocky/wocky-session.h>

#include <message.h>

GMainLoop *mainloop;
char *recipient;
char *message;

static void
closed_cb (
    GObject *source,
    GAsyncResult *res,
    gpointer user_data)
{
  WockyPorter *porter = WOCKY_PORTER (source);
  GError *error = NULL;

  if (wocky_porter_close_finish (porter, res, &error))
    {
      g_print ("Signed out\n");
    }
  else
    {
      /* Doesn't work! “Another send operation is pending”. */
      g_warning ("Couldn't sign out: %s\n", error->message);
      g_clear_error (&error);
    }

  /* Either way, we're done. */
  g_main_loop_quit (mainloop);
}

static void
message_sent_cb (
    GObject *source,
    GAsyncResult *res,
    gpointer user_data)
{
  WockyPorter *porter = WOCKY_PORTER (source);
  GError *error = NULL;

  if (wocky_porter_send_finish (porter, res, &error))
    {
      g_print ("Sent '%s' to %s\n", message, recipient);
    }
  else
    {
      g_warning ("Couldn't send message: %s\n", error->message);
      g_clear_error (&error);
    }

  /* Sign out. */
  wocky_porter_close_async (porter, NULL, closed_cb, NULL);
}

static void
connected_cb (
    GObject *source,
    GAsyncResult *res,
    gpointer user_data)
{
  WockyConnector *connector = WOCKY_CONNECTOR (source);
  WockyXmppConnection *connection;
  gchar *jid = NULL;
  gchar *sid = NULL;
  GError *error = NULL;

  connection = wocky_connector_connect_finish (connector, res, &jid, &sid,
      &error);

  if (connection == NULL)
    {
      g_warning ("Couldn't connect: %s", error->message);
      g_clear_error (&error);
      g_main_loop_quit (mainloop);
    }
  else
    {
      WockySession *session = wocky_session_new (connection, jid);
      WockyPorter *porter = wocky_session_get_porter (session);
      WockyStanza *stanza = wocky_stanza_build (WOCKY_STANZA_TYPE_MESSAGE,
          WOCKY_STANZA_SUB_TYPE_NONE, NULL, recipient,
          '(', "body",
            '$', message,
          ')', NULL);

      wocky_porter_start (porter);
      wocky_porter_send_async (porter, stanza, NULL, message_sent_cb, NULL);

      g_object_unref (stanza);
      /* We leak the session and porter. */
    }
}

void rxmpp_send(char **in_jid, char **in_password, char **in_recipient, char **in_message)
{
  char *jid, *password;
  WockyConnector *connector;

  g_type_init ();
  wocky_init ();

  message=*in_message;
  recipient=*in_recipient;
  jid=*in_jid;
  password=*in_password;

  mainloop = g_main_loop_new (NULL, FALSE);
  connector = wocky_connector_new (jid, password, NULL, NULL, NULL);
  wocky_connector_connect_async (connector, NULL, connected_cb, NULL);

  g_main_loop_run (mainloop);

  g_object_unref (connector);
  g_main_loop_unref (mainloop);
}
