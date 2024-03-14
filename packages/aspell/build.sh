NEOTERM_PKG_HOMEPAGE=http://aspell.net
NEOTERM_PKG_DESCRIPTION="A free and open source spell checker designed to replace Ispell"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.60.8.1"
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/aspell/aspell-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d6da12b34d42d457fa604e435ad484a74b2effcd120ff40acd6bb3fb2887d21b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
# To use the same compiled dictionaries on every platform:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-32-bit-hash-fun"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
