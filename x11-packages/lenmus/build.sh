NEOTERM_PKG_HOMEPAGE=http://www.lenmus.org/
NEOTERM_PKG_DESCRIPTION="A free program to help you in the study of music theory and ear training"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0.1
NEOTERM_PKG_SRCURL=https://github.com/lenmus/lenmus/archive/refs/tags/Release_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1fa5b8edc468c800598845aa809b4a4e93058ed13af40bfacd037c44d1c4bc1d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="fluidsynth, fontconfig, freetype, libc++, libpng, libsqlite, portmidi, wxwidgets, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DFLUIDR3_PATH=$NEOTERM_PREFIX/share/soundfonts
-DLENMUS_COMPILER_GCC=0
-DLENMUS_COMPILER_MSVC=0
-DMAN_INSTALL_DIR=$NEOTERM_PREFIX/share/man
"

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/sh" > postinst
	echo "if [ ! -e $NEOTERM_PREFIX/share/soundfonts/FluidR3_GM.sf2 ]; then" >> postinst
	echo "  echo" >> postinst
	echo "  echo You may need to get \\\`FluidR3_GM.sf2\\' from somewhere and put it into:" >> postinst
	echo "  echo" >> postinst
	echo "  echo '    '$NEOTERM_PREFIX/share/soundfonts/" >> postinst
	echo "  echo" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
