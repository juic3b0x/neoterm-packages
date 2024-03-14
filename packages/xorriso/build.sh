NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/xorriso
NEOTERM_PKG_DESCRIPTION="Tool for creating ISO files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:1.5.7"
NEOTERM_PKG_SRCURL=https://www.gnu.org/software/xorriso/xorriso-${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=867577c387f6b4a9a3224eb441ded8fb1638df6cbc060f8d1a1e5d00f318f502
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libiconv, libandroid-support, readline, libbz2, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-jtethreads"

neoterm_step_pre_configure() {
	./bootstrap
}
