NEOTERM_PKG_HOMEPAGE=https://github.com/jwilk/pdf2djvu
NEOTERM_PKG_DESCRIPTION="PDF to DjVu converter"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.19
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/jwilk/pdf2djvu/releases/download/${NEOTERM_PKG_VERSION}/pdf2djvu-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=eb45a480131594079f7fe84df30e4a5d0686f7a8049dc7084eebe22acc37aa9a
NEOTERM_PKG_DEPENDS="djvulibre, libc++, libiconv, poppler"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xmp
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
