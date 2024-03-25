NEOTERM_PKG_HOMEPAGE=https://optipng.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="PNG optimizer that recompresses image files to a smaller size, without losing any information"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.8"
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-${NEOTERM_PKG_VERSION}/optipng-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=25a3bd68481f21502ccaa0f4c13f84dcf6b20338e4c4e8c51f2cefbd8513398c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libpng, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-system-zlib --with-system-libpng --mandir=$NEOTERM_PREFIX/share/man"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LD=$CC
}
