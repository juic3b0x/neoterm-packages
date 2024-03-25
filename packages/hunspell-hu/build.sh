NEOTERM_PKG_HOMEPAGE=https://magyarispell.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Hungarian dictionary for hunspell"
NEOTERM_PKG_LICENSE="MPL-2.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2023.07.08
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_post_get_source() {
	neoterm_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/README_hu_HU.txt \
			$NEOTERM_PKG_SRCDIR/README_hu_HU.txt \
			d0a4e7c3651e2a05ec91dd5b58b3d8ea9a7018a993445d18bdd508b18a4aa74f
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/hu_HU/hu_HU.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/hu_HU/hu_HU.dic
	# In which case we need to bump version and checksum used.
	neoterm_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/hu_HU.aff \
			$NEOTERM_PREFIX/share/hunspell/hu_HU.aff \
			0de3872251cd546fe9d15a49e6d065760168ff8ccbd0fca697ca85481fbaa1ad
	neoterm_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/hu_HU.dic \
			$NEOTERM_PREFIX/share/hunspell/hu_HU.dic \
			36e12a1274a0a3fcd0528c23091c5bcada097c2851bd0435fb81249a6c2367c2
	touch $NEOTERM_PREFIX/share/hunspell/hu_HU.{aff,dic}

	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_SRCDIR/README_hu_HU.txt
}
