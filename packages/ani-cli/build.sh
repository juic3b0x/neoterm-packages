NEOTERM_PKG_HOMEPAGE=https://github.com/pystardust/ani-cli
NEOTERM_PKG_DESCRIPTION="A cli to browse and watch anime"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.8"
NEOTERM_PKG_SRCURL=https://github.com/pystardust/ani-cli/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9857bf88a1cbef4580dea52da349d3b23d2288b67a03fdd7b6c5c1b35d08351d
NEOTERM_PKG_DEPENDS="aria2, ffmpeg, fzf, grep, sed, wget"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="aria2, ffmpeg, fzf, grep, sed, wget"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin ani-cli

	local mpv_android=$NEOTERM_PREFIX/opt/ani-cli/bin/mpv
	mkdir -p $(dirname $mpv_android)
	rm -rf $mpv_android
	sed 's|@NEOTERM_PREFIX@|'"$NEOTERM_PREFIX"'|g' \
		$NEOTERM_PKG_BUILDER_DIR/mpv.in > $mpv_android
	chmod 0700 $mpv_android
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${NEOTERM_PREFIX}/bin/sh
	echo
	echo Note that you need to have the mpv android app installed.
	echo
	EOF
}
