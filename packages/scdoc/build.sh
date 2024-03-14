NEOTERM_PKG_HOMEPAGE=https://git.sr.ht/~sircmpwn/scdoc
NEOTERM_PKG_DESCRIPTION="Small man page generator"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION=1.11.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://git.sr.ht/~sircmpwn/scdoc/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e9ff9981b5854301789a6778ee64ef1f6d1e5f4829a9dd3e58a9a63eacc2e6f0
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="OUTDIR=$NEOTERM_PKG_SRCDIR HOST_SCDOC=$NEOTERM_PKG_HOSTBUILD_DIR/scdoc"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	cd $NEOTERM_PKG_SRCDIR
	make OUTDIR=$NEOTERM_PKG_HOSTBUILD_DIR
}
