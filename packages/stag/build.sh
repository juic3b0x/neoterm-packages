NEOTERM_PKG_HOMEPAGE=https://github.com/seenaburns/stag
NEOTERM_PKG_DESCRIPTION="Streaming bar graphs. For stats and stuff."
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_SRCURL=https://github.com/seenaburns/stag/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=391574e6aa12856d5a598a374e3a40a38cbab6ef9d769c0d59af8411b4fbecb6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" $LDFLAGS"
}
