NEOTERM_PKG_HOMEPAGE=https://github.com/rui314/mold
NEOTERM_PKG_DESCRIPTION="mold: A Modern Linker"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.1"
NEOTERM_PKG_SRCURL=https://github.com/rui314/mold/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c9853d007d6a1b4f3e36b7314346751f4cc91bc43c76e30db51709b53b44dd68
NEOTERM_PKG_DEPENDS="libandroid-spawn, libc++, openssl, zlib"
NEOTERM_PKG_AUTO_UPDATE=true

# dont depend on system libtbb, xxhash
# https://github.com/rui314/mold/commit/add94b86266b40bc66789e26358675da9d603919#commitcomment-80494077
