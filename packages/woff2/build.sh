NEOTERM_PKG_HOMEPAGE=https://www.w3.org/TR/WOFF2/
NEOTERM_PKG_DESCRIPTION="font compression reference code"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Revdep rebuild may be required with every version bump.
NEOTERM_PKG_VERSION=1.0.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/google/woff2/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=add272bb09e6384a4833ffca4896350fdb16e0ca22df68c0384773c67a175594
# SOVERSION is equal to VERSION. Do not enable auto-update.
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="brotli, libc++"

neoterm_step_post_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin woff2_{compress,decompress,info}
}
