NEOTERM_PKG_HOMEPAGE=https://github.com/theworkjoy/neoterm-auth
NEOTERM_PKG_DESCRIPTION="Password authentication library and utility for NeoTerm"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/theworkjoy/neoterm-auth/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6397c2642e614513f173e49ab5510d0304ed74fa6821fafb8a37b3b77e395643
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_BREAKS="neoterm-auth-dev"
NEOTERM_PKG_REPLACES="neoterm-auth-dev"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNEOTERM_HOME=\\\"${NEOTERM_ANDROID_HOME}\\\" -DNEOTERM_PREFIX=\\\"${NEOTERM_PREFIX}\\\""
}
