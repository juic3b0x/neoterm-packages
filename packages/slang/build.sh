NEOTERM_PKG_HOMEPAGE=https://www.jedsoft.org/slang/
NEOTERM_PKG_DESCRIPTION="S-Lang is a powerful interpreted language"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.3
NEOTERM_PKG_SRCURL=https://www.jedsoft.org/releases/slang/slang-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=f9145054ae131973c61208ea82486d5dd10e3c5cdad23b7c4a0617743c8f5a18
NEOTERM_PKG_DEPENDS="libiconv, libpng, pcre, oniguruma, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/slsh.rc"

# Supports only make -j1
NEOTERM_MAKE_PROCESSES=1
