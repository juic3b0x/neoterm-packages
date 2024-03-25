NEOTERM_PKG_HOMEPAGE=https://dejavu-fonts.github.io/
NEOTERM_PKG_DESCRIPTION="Font family based on the Bitstream Vera Fonts with a wider range of characters"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.37
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/dejavu/dejavu/${NEOTERM_PKG_VERSION}/dejavu-fonts-ttf-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=fa9ca4d13871dd122f61258a80d01751d603b4d3ee14095d65453b4e846e17d7
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_CONFFILES="
etc/fonts/conf.d/20-unhint-small-dejavu-sans-mono.conf
etc/fonts/conf.d/20-unhint-small-dejavu-sans.conf
etc/fonts/conf.d/20-unhint-small-dejavu-serif.conf
etc/fonts/conf.d/57-dejavu-sans-mono.conf
etc/fonts/conf.d/57-dejavu-sans.conf
etc/fonts/conf.d/57-dejavu-serif.conf
"

neoterm_step_make_install() {
	## Install fonts.
	mkdir -p "${NEOTERM_PREFIX}/share/fonts/TTF"
	cp -f ttf/*.ttf "${NEOTERM_PREFIX}/share/fonts/TTF/"

	## Install config files used by 'fontconfig' package.
	mkdir -p "${NEOTERM_PREFIX}/etc/fonts/conf.d"
	cp -f fontconfig/*.conf "${NEOTERM_PREFIX}/etc/fonts/conf.d/"
}
