NEOTERM_PKG_HOMEPAGE=http://miniupnp.free.fr/libnatpmp.html
NEOTERM_PKG_DESCRIPTION="Portable and fully compliant implementation of NAT-PMP"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20230423
NEOTERM_PKG_SRCURL=http://miniupnp.free.fr/files/libnatpmp-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=0684ed2c8406437e7519a1bd20ea83780db871b3a3a5d752311ba3e889dbfc70
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="INSTALLPREFIX=$NEOTERM_PREFIX"

neoterm_step_post_get_source() {
	mv setup.py{,.unused}
}

neoterm_step_configure() {
	:
}
