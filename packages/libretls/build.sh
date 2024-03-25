NEOTERM_PKG_HOMEPAGE=https://git.causal.agency/libretls/about/
NEOTERM_PKG_DESCRIPTION="libtls for OpenSSL"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@Yonle <yonle@duck.com>"
NEOTERM_PKG_VERSION="3.8.1"
NEOTERM_PKG_SRCURL=https://git.causal.agency/libretls/snapshot/libretls-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4a705c9c079dc70383ccc08432b93fbb61f9ec5873a92883e01e0940b8eaf3de
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_REPLACES="libtls"
NEOTERM_PKG_PROVIDES="libtls"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_install_license() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/LICENSE -t ${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}
}
