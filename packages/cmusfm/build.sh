NEOTERM_PKG_HOMEPAGE=https://github.com/Arkq/cmusfm
NEOTERM_PKG_DESCRIPTION="Last.fm standalone scrobbler for the cmus music player"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.0
NEOTERM_PKG_SRCURL=https://github.com/Arkq/cmusfm/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=17aae8fc805e79b367053ad170854edceee5f4c51a9880200d193db9862d8363
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-spawn, libcurl, openssl"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn"
	autoreconf --force --install
}
