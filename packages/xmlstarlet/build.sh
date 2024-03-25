NEOTERM_PKG_HOMEPAGE=https://xmlstar.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Command line XML toolkit"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.1
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/xmlstar/xmlstarlet/${NEOTERM_PKG_VERSION}/xmlstarlet-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca
NEOTERM_PKG_DEPENDS="libxslt, libxml2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-libxml-include-prefix=${NEOTERM_PREFIX}/include/libxml2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	ln -sfr $NEOTERM_PREFIX/bin/xml $NEOTERM_PREFIX/bin/xmlstarlet
}
