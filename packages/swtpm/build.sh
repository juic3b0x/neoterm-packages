NEOTERM_PKG_HOMEPAGE=https://github.com/stefanberger/swtpm
NEOTERM_PKG_DESCRIPTION="Software TPM Emulator"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.1"
NEOTERM_PKG_SRCURL=https://github.com/stefanberger/swtpm/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7bba52aa41090f75087034fac5fe8daed10c3e7e7234df7c9558849318927f41
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, json-glib, libseccomp, libtpms, openssl"
NEOTERM_PKG_BUILD_DEPENDS="libtasn1"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--without-gnutls
"

neoterm_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -Dindex=strchr"
}
