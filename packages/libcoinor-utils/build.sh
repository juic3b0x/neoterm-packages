NEOTERM_PKG_HOMEPAGE=https://github.com/coin-or/CoinUtils
NEOTERM_PKG_DESCRIPTION="An open-source collection of classes and helper functions for COIN-OR projects"
NEOTERM_PKG_LICENSE="EPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2.11.9
NEOTERM_PKG_SRCURL=https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=15d572ace4cd3b7c8ce117081b65a2bd5b5a4ebaba54fadc99c7a244160f88b8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
