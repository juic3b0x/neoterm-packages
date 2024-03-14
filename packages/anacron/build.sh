NEOTERM_PKG_HOMEPAGE=https://anacron.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A periodic command scheduler"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/anacron/anacron-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5ceee6f22cd089bdaf1c0841200dbe5726babaf9e2c432bb17c1fc95da5ca99f
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/obstack.h ./
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	mkdir -p $NEOTERM_PREFIX/var/spool/anacron
	EOF
}
