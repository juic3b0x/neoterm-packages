NEOTERM_PKG_HOMEPAGE=https://www.nlnetlabs.nl/projects/ldns/
NEOTERM_PKG_DESCRIPTION="Library for simplifying DNS programming and supporting recent and experimental RFCs"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://www.nlnetlabs.nl/downloads/ldns/ldns-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c3f72dd1036b2907e3a56e6acf9dfb2e551256b3c1bbd9787942deeeb70e7860
NEOTERM_PKG_DEPENDS="openssl, resolv-conf"
NEOTERM_PKG_BREAKS="ldns-dev"
NEOTERM_PKG_REPLACES="ldns-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=$NEOTERM_PREFIX
--disable-gost
--with-drill
"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_make_install() {
	# The ldns build doesn't install its pkg-config:
	mkdir -p $NEOTERM_PREFIX/lib/pkgconfig
	cp packaging/libldns.pc $NEOTERM_PREFIX/lib/pkgconfig/libldns.pc
}
