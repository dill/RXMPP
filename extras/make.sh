rm -rf .libs _libs
rm -f wocky-connect wocky-message wocky-register wocky-unregister
rm -f *.o
test -z "" || rm -f 
rm -f *.lo


gcc -std=gnu99 -DHAVE_CONFIG_H -I. -I.. -I../wocky   -I.. -I.. -Wall -Wextra -Wdeclaration-after-statement -Wshadow -Wstrict-prototypes -Wmissing-prototypes -Wsign-compare -Wnested-externs -Wpointer-arith -Wformat-security -Winit-self -Wno-missing-field-initializers -Wno-unused-parameter -Werror -Wno-error=missing-field-initializers -Wno-error=unused-parameter -D_REENTRANT -I/opt/local/include/glib-2.0 -I/opt/local/lib/glib-2.0/include -I/opt/local/include  -g -O2 -MT message.o -MD -MP -MF .deps/message.Tpo -c -o message.o message.c

mv -f .deps/message.Tpo .deps/message.Po

gcc -shared -std=gnu99 -I.. -I.. -Wall -Wextra -Wdeclaration-after-statement -Wshadow -Wstrict-prototypes -Wmissing-prototypes -Wsign-compare -Wnested-externs -Wpointer-arith -Wformat-security -Winit-self -Wno-missing-field-initializers -Wno-unused-parameter -Werror -Wno-error=missing-field-initializers -Wno-error=unused-parameter -D_REENTRANT -I/opt/local/include/glib-2.0 -I/opt/local/lib/glib-2.0/include -I/opt/local/include -g -O2 -o wocky-message message.o  -L/opt/local/lib ../wocky/.libs/libwocky.a /opt/local/lib/libgio-2.0.dylib /opt/local/lib/libgobject-2.0.dylib /opt/local/lib/libgmodule-2.0.dylib /opt/local/lib/libgthread-2.0.dylib /opt/local/lib/libglib-2.0.dylib -lresolv /opt/local/lib/libxml2.dylib -lpthread -lm /opt/local/lib/libsqlite3.dylib /opt/local/lib/libgnutls.dylib /opt/local/lib/libtasn1.dylib -lz /opt/local/lib/libgcrypt.dylib /opt/local/lib/libgpg-error.dylib /opt/local/lib/libintl.dylib /opt/local/lib/libiconv.dylib -lc -framework Carbon
