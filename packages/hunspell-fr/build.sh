NEOTERM_PKG_HOMEPAGE=https://hunspell.github.io
NEOTERM_PKG_DESCRIPTION="French dictionary for hunspell"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=20221031
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/fr_FR/fr.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/fr_FR/fr.dic
	# In which case we need to bump version and checksum used.
	neoterm_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/fr_FR/fr.aff \
			        $NEOTERM_PREFIX/share/hunspell/fr_FR.aff \
			        4730775ff4488c4a9aa4833393c8b2187126336eed766866300a58a75fe874f0
	neoterm_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/fr_FR/fr.dic \
			        $NEOTERM_PREFIX/share/hunspell/fr_FR.dic \
		            b99447ab2e655c1e4b64509cfd2e6c24821242bff1f971b49eac723e388a2d19
	touch $NEOTERM_PREFIX/share/hunspell/fr_FR.{aff,dic}
}
