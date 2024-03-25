NEOTERM_PKG_HOMEPAGE=http://0pointer.de/lennart/projects/libcanberra/
NEOTERM_PKG_DESCRIPTION="libcanberra defines a simple abstract interface for playing event sounds."
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.30
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=http://0pointer.de/lennart/projects/libcanberra/libcanberra-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=c2b671e67e0c288a69fc33dc1b6f1b534d07882c2aceed37004bf48c601afa72
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gstreamer, gtk3, harfbuzz, libcairo, libltdl, libvorbis, libx11, pango, pulseaudio"
NEOTERM_PKG_RECOMMENDS="zenity"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gtk
--disable-tdb
"

neoterm_step_post_get_source() {
	# src/malloc.h prevents system <malloc.h> from being included
	if [ -e "src/malloc-private.h" ]; then
		neoterm_error_exit "src/malloc-private.h already exists."
	fi
	mv src/malloc.h src/malloc-private.h
	find src -name 'Makefile.*' -o -name '*.c' | xargs -n 1 \
		sed -i 's/malloc\.h/malloc-private.h/g'
}
