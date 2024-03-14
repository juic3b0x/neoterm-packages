NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X.org font encoding files"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.7
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/font/encodings-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3a39a9f43b16521cdbd9f810090952af4f109b44fa7a865cd555f8febcea70a4
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-fontrootdir=$NEOTERM_PREFIX/share/fonts"

neoterm_step_pre_configure() {
	## Checking only for mkfontdir which is a part of xfonts-utils that provides
	## tool mkfontscale used in further steps.
	if [ -z "$(command -v mkfontdir)" ]; then
		echo
		echo "Command 'mkfontdir' is not found."
		echo "Install it by running 'sudo apt install xfonts-utils'."
		echo
		exit 1
	fi
}

neoterm_step_post_make_install() {
	cd "${NEOTERM_PREFIX}"/share/fonts/encodings/large
	mkfontscale -b -s -l -n -r -p "${NEOTERM_PREFIX}"/share/fonts/encodings/large -e . .

	cd "${NEOTERM_PREFIX}"/share/fonts/encodings/
	mkfontscale -b -s -l -n -r -p "${NEOTERM_PREFIX}"/share/fonts/encodings -e . -e large .
}
