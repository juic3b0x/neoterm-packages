NEOTERM_PKG_HOMEPAGE=https://www.freetype.org
NEOTERM_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.13.2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/freetype/freetype-${NEOTERM_PKG_VERSION}.tar.xz
#NEOTERM_PKG_SRCURL=https://download.savannah.nongnu.org/releases/freetype/freetype-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d
NEOTERM_PKG_DEPENDS="brotli, libbz2, libpng, zlib"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="freetype-dev"
NEOTERM_PKG_REPLACES="freetype-dev"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
# not install these files anymore so install them manually.
neoterm_step_post_make_install() {
	install -Dm700 freetype-config $NEOTERM_PREFIX/bin/freetype-config
	install -Dm600 ../src/docs/freetype-config.1 $NEOTERM_PREFIX/share/man/man1/freetype-config.1
}
