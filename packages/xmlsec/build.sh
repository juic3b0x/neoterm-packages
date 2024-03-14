NEOTERM_PKG_HOMEPAGE=https://www.aleksey.com/xmlsec/
NEOTERM_PKG_DESCRIPTION="XML Security Library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="Copyright"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.3"
NEOTERM_PKG_SRCURL=https://www.aleksey.com/xmlsec/download/xmlsec1-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ab5b9a9ffd6960f46f7466d9d91f174ec37e8c31989237ba6b9eacdd816464f2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libgcrypt, libxml2, libxslt, openssl"
NEOTERM_PKG_BREAKS="xmlsec-dev"
NEOTERM_PKG_REPLACES="xmlsec-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-crypto-dl
--without-gnutls
--without-pedantic
"

neoterm_step_post_get_source() {
	echo >> src/openssl/symkeys.c
}
