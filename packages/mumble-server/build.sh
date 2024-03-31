NEOTERM_PKG_HOMEPAGE=https://www.mumble.info/
NEOTERM_PKG_DESCRIPTION="Server module for Mumble, an open source voice-chat software"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.517
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=git+https://github.com/mumble-voip/mumble
NEOTERM_PKG_DEPENDS="libc++, libcap, libprotobuf, openssl, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dclient=OFF
-Dice=OFF
-Doverlay=OFF
-Dwarnings-as-errors=OFF
-Dzeroconf=OFF
"
NEOTERM_PKG_RM_AFTER_INSTALL="
etc/systemd
"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf

	LDFLAGS+=" -lcap"

	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -Dprotobuf_PROTOC_EXE=$(command -v protoc)"
	sed -i 's/COMMAND\sprotobuf::protoc/COMMAND ${protobuf_PROTOC_EXE}/g' $NEOTERM_PREFIX/lib/cmake/protobuf/protobuf-generate.cmake
}

neoterm_step_post_make_install() {
	ln -sfT mumble-server $NEOTERM_PREFIX/bin/murmurd
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/mumble-server/examples \
		$NEOTERM_PKG_SRCDIR/auxiliary_files/mumble-server.ini
	chmod 0700 $NEOTERM_PREFIX/bin/mumble-server-user-wrapper
}

neoterm_step_post_massage() {
	rm -f lib/cmake/protobuf/protobuf-generate.cmake
	find . -type d -empty -delete
}
