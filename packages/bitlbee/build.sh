NEOTERM_PKG_HOMEPAGE=https://www.bitlbee.org/
NEOTERM_PKG_DESCRIPTION="An IRC to other chat networks gateway"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.6-1
NEOTERM_PKG_SRCURL=https://github.com/bitlbee/bitlbee/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=81c6357fe08a8941221472e3790e2b351e3a8a41f9af0cf35395fdadbc8ac6cb
NEOTERM_PKG_DEPENDS="ca-certificates, glib, libgcrypt, libgnutls"

neoterm_step_pre_configure() {
	LDFLAGS+=" -lgcrypt"
}

neoterm_step_configure_autotools() {
	sh "$NEOTERM_PKG_SRCDIR/configure" \
		--prefix=$NEOTERM_PREFIX \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}

neoterm_step_post_make_install() {
	make install-etc install-dev
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/lib/bitlbee
	EOF
}
