NEOTERM_PKG_HOMEPAGE=https://github.com/justdan96/tsMuxer
NEOTERM_PKG_DESCRIPTION="A transport stream muxer for remuxing/muxing elementary streams"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update both tsmuxer and tsmuxergui to the same version in one PR.
_VERSION_REAL=nightly-2023-01-30-02-16-12
NEOTERM_PKG_VERSION=$(cut -d- -f2,3,4 <<< "$_VERSION_REAL" | tr '-' '.')
NEOTERM_PKG_SRCURL=https://github.com/justdan96/tsMuxer/archive/refs/tags/${_VERSION_REAL}.tar.gz
NEOTERM_PKG_SHA256=e975d7ab9a73448b1c2c1ded311977a6f0dc77398edb720158dbcf213d9cf4df
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtmultimedia"
NEOTERM_PKG_BUILD_DEPENDS="freetype, qt5-qtbase-cross-tools, qt5-qttools-cross-tools, zlib"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/tsmuxer"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_DATADIR=share -DTSMUXER_GUI=ON"

neoterm_step_post_get_source() {
	# Version guard
	local ver_t=$(. $NEOTERM_SCRIPTDIR/packages/tsmuxer/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	local ver_g=${NEOTERM_PKG_VERSION#*:}
	if [ "${ver_t}" != "${ver_g}" ]; then
		neoterm_error_exit "Version mismatch between tsmuxer and tsmuxergui."
	fi
}

neoterm_step_post_make_install() {
	mv ${NEOTERM_PREFIX}/bin/tsMuxerGUI ${NEOTERM_PREFIX}/bin/tsmuxergui
}
