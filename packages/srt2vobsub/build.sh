NEOTERM_PKG_HOMEPAGE=https://srt2vobsub.sourceforge.io/
NEOTERM_PKG_DESCRIPTION="A command-line tool that generates a pair of .idx/.sub subtitle files from a textual subtitles file"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/srt2vobsub/srt2vobsub-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5f59319b300dc8629adf6debf94529f3f71ad8cc34bad5ead53a3cfc8d613c12
NEOTERM_PKG_DEPENDS="bdsup2sub, ffmpeg, fontconfig-utils, imagemagick, mediainfo, python, python-pip"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_TARGET_DEPS="chardet, srt, wand"

neoterm_step_make_install() {
	install -Dm700 -T srt2vobsub.py $NEOTERM_PREFIX/bin/srt2vobsub
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 srt2vobsub.1.gz
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		README defaults.conf langcodes.txt srt2vobsub.html
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
