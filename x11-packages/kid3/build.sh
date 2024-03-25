NEOTERM_PKG_HOMEPAGE=https://kid3.kde.org/
NEOTERM_PKG_DESCRIPTION="Efficient ID3 tag editor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.9.5"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/kid3/kid3-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d68f6e1d7b794b991b57bf976edb8e22d3457911db654ad1fb9b124cc62057f9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="chromaprint, ffmpeg, id3lib, libc++, libflac, libogg, libvorbis, qt5-qtbase, qt5-qtdeclarative, qt5-qtmultimedia, readline, taglib"
NEOTERM_PKG_BUILD_DEPENDS="docbook-xsl, qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_NEOTERM=OFF
-DWITH_APPS=Qt;CLI
-DWITH_FFMPEG=ON
"

neoterm_step_post_get_source() {
	# I don't want to make a patch for this:
	find . -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_NEOTERM\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_NEOTERM/g'
}

neoterm_step_pre_configure() {
	local DOCBOOK_XSL_VER=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/docbook-xsl/build.sh; echo \$NEOTERM_PKG_VERSION")
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DWITH_DOCBOOKDIR=$NEOTERM_PREFIX/share/xml/docbook/xsl-stylesheets-${DOCBOOK_XSL_VER}"

	LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib/kid3"
}
