NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-auth
NEOTERM_PKG_DESCRIPTION="Password authentication library and utility for NeoTerm"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-auth/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=539bc4f8271878d3402e8f54030441e345cfb8d0d635fa59c541f51d21e939d0
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BREAKS="neoterm-auth-dev"
NEOTERM_PKG_REPLACES="neoterm-auth-dev"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNEOTERM_HOME=\\\"${NEOTERM_ANDROID_HOME}\\\" -DNEOTERM_PREFIX=\\\"${NEOTERM_PREFIX}\\\""
}
