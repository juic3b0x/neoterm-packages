NEOTERM_PKG_HOMEPAGE=https://mp3gain.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Analyzes and adjusts mp3 files so that they have the same volume"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/mp3gain/mp3gain-${NEOTERM_PKG_VERSION//./_}-src.zip
NEOTERM_PKG_SHA256=5cc04732ef32850d5878b28fbd8b85798d979a025990654aceeaa379bcc9596d
NEOTERM_PKG_DEPENDS="mpg123"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_extract_src_archive() {
	rm -Rf mp3gain
	mkdir mp3gain
	pushd mp3gain
	unzip -q "$NEOTERM_PKG_CACHEDIR/$(basename "${NEOTERM_PKG_SRCURL}")"
	popd
	mv mp3gain "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin mp3gain
}
