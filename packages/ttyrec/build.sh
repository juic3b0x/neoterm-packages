NEOTERM_PKG_HOMEPAGE=http://0xcc.net/ttyrec/
NEOTERM_PKG_DESCRIPTION="Terminal recorder and player"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.8
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=http://0xcc.net/ttyrec/ttyrec-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -Dset_progname=setprogname $LDFLAGS"
}

neoterm_step_make_install() {
	cp ttyrec ttyplay ttytime $NEOTERM_PREFIX/bin
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	cp ttyrec.1 ttyplay.1 ttytime.1 $NEOTERM_PREFIX/share/man/man1
}
