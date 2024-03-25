NEOTERM_PKG_HOMEPAGE=https://oneapi-src.github.io/oneTBB/
NEOTERM_PKG_DESCRIPTION="oneAPI Threading Building Blocks"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2021.11.0"
NEOTERM_PKG_SRCURL=https://github.com/oneapi-src/oneTBB/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=782ce0cab62df9ea125cdea253a50534862b563f1d85d4cda7ad4e77550ac363
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DTBB_STRICT=OFF
-DTBB_TEST=OFF
"

neoterm_step_pre_configure() {
	# Many symbols in the linker version scripts are undefined because link time
	# optimization (-flto=thin) removes them. Suppress errors with lld >= 17 due to
	# these undefined symbols.
	# See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=274337
	LDFLAGS+=" -Wl,--undefined-version"
}
