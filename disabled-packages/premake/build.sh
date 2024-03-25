NEOTERM_PKG_HOMEPAGE=https://premake.github.io/
NEOTERM_PKG_DESCRIPTION="Build script generator"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.0.0-beta1
NEOTERM_PKG_SRCURL=https://github.com/premake/premake-core/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=97fa4cef9fb6459c39da4e70756c0e13ae7b090fffe9442306c768b8b62e1589
# NEOTERM_PKG_DEPENDS="pcre, openssl, libuuid"
# NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl"


neoterm_step_pre_configure() {
	NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_SRCDIR/build/gmake.unix
}
