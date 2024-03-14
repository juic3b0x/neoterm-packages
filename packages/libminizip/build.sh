NEOTERM_PKG_HOMEPAGE=https://www.winimage.com/zLibDll/minizip.html
NEOTERM_PKG_DESCRIPTION="Mini zip and unzip based on zlib"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="MiniZip64_info.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.1
NEOTERM_PKG_SRCURL=https://github.com/madler/zlib/releases/download/v${NEOTERM_PKG_VERSION}/zlib-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="zlib"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/contrib/minizip"
	cd $NEOTERM_PKG_SRCDIR
	autoreconf -fi
}
