NEOTERM_PKG_HOMEPAGE=https://www.spice-space.org/
NEOTERM_PKG_DESCRIPTION="Implements the server side of the SPICE protocol"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.15.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.spice-space.org/download/releases/spice-server/spice-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=ada9af67ab321916bd7eb59e3d619a4a7796c08a28c732edfc7f02fc80b1a37a
NEOTERM_PKG_DEPENDS="glib, gst-plugins-base, gstreamer, libc++, libiconv, libjpeg-turbo, liblz4, libopus, liborc, libpixman, libsasl, libspice-protocol, openssl, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-manual=no
--disable-tests
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_make_install() {
	ln -sf libspice-server.so "${NEOTERM_PREFIX}"/lib/libspice-server.so.1
}
