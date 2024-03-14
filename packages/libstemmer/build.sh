NEOTERM_PKG_HOMEPAGE=https://snowballstem.org/
NEOTERM_PKG_DESCRIPTION="Snowball compiler and stemming algorithms"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/snowballstem/snowball/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=425cdb5fba13a01db59a1713780f0662e984204f402d3dae1525bda9e6d30f1a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin stemwords
	install -Dm600 -t $NEOTERM_PREFIX/include include/libstemmer.h
	install -Dm600 -t $NEOTERM_PREFIX/lib libstemmer.a

	local f
	for f in libstemmer.so*; do
		if test -L "${f}"; then
			ln -sf "$(readlink "${f}")" $NEOTERM_PREFIX/lib/"${f}"
		else
			install -Dm600 -t $NEOTERM_PREFIX/lib "${f}"
		fi
	done
}
