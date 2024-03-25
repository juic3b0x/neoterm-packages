NEOTERM_PKG_HOMEPAGE=https://github.com/hackndev/0verkill
NEOTERM_PKG_DESCRIPTION="Bloody 2D action deathmatch-like game in ASCII-ART"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.16
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/ravener/0verkill/archive/refs/tags/v${NEOTERM_PKG_VERSION:0:4}.tar.gz
NEOTERM_PKG_SHA256=d337e4a7dd91f26c837e96492d960c7fd77c75bc24bcc6ed8d350df39edf8bb8
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	autoreconf -vfi
	CFLAGS+=" -fcommon"
}
