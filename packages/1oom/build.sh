NEOTERM_PKG_HOMEPAGE=https://gitlab.com/Tapani_/1oom
NEOTERM_PKG_DESCRIPTION="A Master of Orion (1993) game engine recreation"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_SRCURL=https://gitlab.com/Tapani_/1oom/-/archive/v${NEOTERM_PKG_VERSION}/1oom-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=a4273966dde5f3296c08f903ad2e12f522b7d536919bc00e4a0a1d69d457ced0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="readline"
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-uiclassic
--disable-hwsdl1
--disable-hwsdl1audio
--disable-hwsdl1gl
--disable-hwsdl2
--disable-hwsdl2audio
--disable-hwalleg4
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
