NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/minidlna/
NEOTERM_PKG_DESCRIPTION="A server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
NEOTERM_PKG_LICENSE="GPL-2.0, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING, LICENCE.miniupnpd"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://git.code.sf.net/p/minidlna/git
NEOTERM_PKG_GIT_BRANCH=v${NEOTERM_PKG_VERSION//./_}
NEOTERM_PKG_DEPENDS="ffmpeg, libexif, libflac, libiconv, libid3tag, libjpeg-turbo, libogg, libsqlite, libvorbis"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFFILES="etc/minidlna.conf"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--with-log-path=$NEOTERM_PREFIX/var/log
--with-db-path=$NEOTERM_PREFIX/var/cache/minidlna
"

neoterm_step_pre_configure() {
	./autogen.sh
}

neoterm_step_post_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/etc minidlna.conf
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/cache/minidlna
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "$NEOTERM_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	exit 0
	fi
	rm -rf $NEOTERM_PREFIX/var/cache/minidlna
	EOF
}
