NEOTERM_PKG_HOMEPAGE=https://github.com/KittyKatt/screenFetch
NEOTERM_PKG_DESCRIPTION="Bash Screenshot Information Tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.9.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/KittyKatt/screenFetch/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=aa97dcd2a8576ae18de6c16c19744aae1573a3da7541af4b98a91930a30a3178
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install screenfetch-dev ${NEOTERM_PREFIX}/bin/screenfetch
	install screenfetch.1 ${NEOTERM_PREFIX}/share/man/man1/
}
