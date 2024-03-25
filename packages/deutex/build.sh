NEOTERM_PKG_HOMEPAGE=https://github.com/Doom-Utils/deutex/
NEOTERM_PKG_DESCRIPTION="WAD composer for Doom, Heretic, Hexen, and Strife"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.2.2
NEOTERM_PKG_SRCURL=https://github.com/Doom-Utils/deutex/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=767e75eb3615bb732947448b81031410e26f808dfc3a099d64a483931fe0b313
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libpng, zlib"

neoterm_step_pre_configure() {
	./bootstrap
}
