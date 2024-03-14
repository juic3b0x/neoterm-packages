NEOTERM_PKG_HOMEPAGE=https://github.com/stefanberger/libtpms
NEOTERM_PKG_DESCRIPTION="Provides software emulation of a Trusted Platform Module (TPM 1.2 and TPM 2.0)"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.6
NEOTERM_PKG_SRCURL=https://github.com/stefanberger/libtpms/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2807466f1563ebe45fdd12dd26e501e8a0c4fbb99c7c428fbb508789efd221c0
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
