NEOTERM_PKG_HOMEPAGE=https://www.bunkus.org/videotools/mkvtoolnix/
NEOTERM_PKG_DESCRIPTION="Set of tools to create, edit and inspect Matroska files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="81.0"
NEOTERM_PKG_SRCURL=git+https://gitlab.com/mbunkus/mkvtoolnix
NEOTERM_PKG_GIT_BRANCH=release-$NEOTERM_PKG_VERSION
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+"
NEOTERM_PKG_DEPENDS="boost, file, libc++, libebml, libflac, libiconv, libmatroska, libogg, libvorbis, pcre2, zlib, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fmt=no
enable_gui=no
--disable-static
--with-boost-filesystem=boost_filesystem
--with-boost-system=boost_system
--with-boost-date-time=boost_date_time
--with-qmake=${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake
"

neoterm_step_pre_configure() {
	export PKG_CONFIG_LIBDIR="$NEOTERM_PKG_CONFIG_LIBDIR"
	./autogen.sh
}

neoterm_step_make() {
	rake
}

neoterm_step_make_install() {
	rake install
}
