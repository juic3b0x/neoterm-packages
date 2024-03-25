NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X.org 100dpi fonts"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.4
_FONT_ADOBE_UTOPIA_VERSION=${NEOTERM_PKG_VERSION%.*}.$((${NEOTERM_PKG_VERSION##*.}+1))
NEOTERM_PKG_SRCURL=(https://xorg.freedesktop.org/releases/individual/font/font-adobe-100dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-adobe-utopia-100dpi-${_FONT_ADOBE_UTOPIA_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-100dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-${NEOTERM_PKG_VERSION}.tar.xz
                   https://xorg.freedesktop.org/releases/individual/font/font-bitstream-100dpi-${NEOTERM_PKG_VERSION}.tar.xz)
NEOTERM_PKG_SHA256=(b67aff445e056328d53f9732d39884f55dd8d303fc25af3dbba33a8ba35a9ccf
                   fb84ec297a906973548ca59b7c6daeaad21244bec5d3fb1e7c93df5ef43b024b
                   fd8f5efe8491faabdd2744808d3d4eafdae5c83e617017c7fddd2716d049ab1e
                   76ec09eda4094a29d47b91cf59c3eba229c8f7d1ca6bae2abbb3f925e33de8f2
                   2d1cc682efe4f7ebdf5fbd88961d8ca32b2729968728633dea20a1627690c1a7)
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
			--with-fontdir="${NEOTERM_PREFIX}/share/fonts/100dpi"
		make -j "${NEOTERM_MAKE_PROCESSES}"
		make install
		popd
	done
}

neoterm_step_post_massage() {
	rm -f share/fonts/100dpi/fonts.*
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/COPYING
}
