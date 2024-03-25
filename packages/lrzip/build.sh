NEOTERM_PKG_HOMEPAGE=https://github.com/ckolivas/lrzip
NEOTERM_PKG_DESCRIPTION="A compression utility that excels at compressing large files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.651
NEOTERM_PKG_SRCURL=https://github.com/ckolivas/lrzip/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f4c84de778a059123040681fd47c17565fcc4fec0ccc68fcf32d97fad16cd892
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash, libbz2, libc++, liblz4, liblzo, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-asm=no
"
# Avoid conflicting with lrzsz.
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/lrz
share/man/man1/lrz.1
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
