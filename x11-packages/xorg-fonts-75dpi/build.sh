NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X.org 75dpi fonts"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.4
_FONT_ADOBE_UTOPIA_VERSION=${NEOTERM_PKG_VERSION%.*}.$((${NEOTERM_PKG_VERSION##*.}+1))
NEOTERM_PKG_SRCURL=(https://xorg.freedesktop.org/releases/individual/font/font-adobe-75dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-75dpi-${_FONT_ADOBE_UTOPIA_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-75dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bitstream-75dpi-${NEOTERM_PKG_VERSION}.tar.xz)
NEOTERM_PKG_SHA256=(1281a62dbeded169e495cae1a5b487e1f336f2b4d971d92911c59c103999b911
                   a726245932d0724fa0c538c992811d63d597e5f53928f4048e9caf5623797760
                   6026d8c073563dd3cbb4878d0076eed970debabd21423b3b61dd90441b9e7cda
                   864e2c39ac61f04f693fc2c8aaaed24b298c2cd40283cec12eee459c5635e8f5
                   aaeb34d87424a9c2b0cf0e8590704c90cb5b42c6a3b6a0ef9e4676ef773bf826)
NEOTERM_PKG_DEPENDS="fontconfig-utils, xorg-font-util, xorg-fonts-alias, xorg-fonts-encodings, xorg-mkfontscale"
NEOTERM_PKG_CONFLICTS="xorg-fonts-lite"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_get_source() {
	mkdir -p "$NEOTERM_PKG_SRCDIR"
	local i
	for i in {0..4}; do
		neoterm_download "${NEOTERM_PKG_SRCURL[i]}" "$(basename "${NEOTERM_PKG_SRCURL[i]}")" "${NEOTERM_PKG_SHA256[i]}"
		tar xf "$(basename "${NEOTERM_PKG_SRCURL[i]}")" -C "${NEOTERM_PKG_SRCDIR}"
	done
}

neoterm_step_make_install() {
	local i
	for i in {0..4}; do
		local file=$(basename "${NEOTERM_PKG_SRCURL[i]}")
		local dir="${NEOTERM_PKG_SRCDIR}/${file%%.tar.*}"

		pushd "${dir}"
		./configure \
			--prefix="${NEOTERM_PREFIX}" \
			--host="${NEOTERM_HOST_PLATFORM}" \
			--with-fontdir="${NEOTERM_PREFIX}/share/fonts/75dpi"
		make -j "${NEOTERM_MAKE_PROCESSES}"
		make install
		popd
	done
}

neoterm_step_post_massage() {
	rm -f share/fonts/75dpi/fonts.*
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/COPYING
}
