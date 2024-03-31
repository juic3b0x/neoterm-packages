NEOTERM_PKG_HOMEPAGE=https://poppler.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Poppler Qt wrapper"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Please align the version with `poppler` package.
NEOTERM_PKG_VERSION="23.10.0"
# Do not forget to bump revision of reverse dependencies and rebuild them
# when SOVERSION is changed.
_POPPLER_SOVERSION=132
NEOTERM_PKG_SRCURL=https://poppler.freedesktop.org/poppler-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=31a3dfdea79f4922402d313737415a44d44dc14d6b317f959a77c5bba0647dd9
# The package must be updated at the same time as poppler, auto updater script does not support that.
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libc++, poppler (>= ${NEOTERM_PKG_VERSION}), qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
#texlive needs the xpdf headers
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GLIB=ON
-DENABLE_GOBJECT_INTROSPECTION=OFF
-DENABLE_UNSTABLE_API_ABI_HEADERS=ON
-DENABLE_QT5=ON
-DENABLE_QT6=OFF
-DFONT_CONFIGURATION=fontconfig
"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	if ! test "${_POPPLER_SOVERSION}"; then
		neoterm_error_exit "Please set _POPPLER_SOVERSION variable."
	fi
	local sover_main=$(. $NEOTERM_SCRIPTDIR/packages/poppler/build.sh; echo $_POPPLER_SOVERSION)
	if [ "${sover_main}" != "${_POPPLER_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION mismatch with \"poppler\" package."
	fi
	local sover_cmake=$(sed -En 's/^set\(POPPLER_SOVERSION_NUMBER "([0-9]+)"\)$/\1/p' CMakeLists.txt)
	if [ "${sover_cmake}" != "${_POPPLER_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed (CMakeLists.txt: \"${sover_cmake}\")."
	fi

	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD"
}

neoterm_step_post_massage() {
	find . ! -type d \
		! -wholename "./include/poppler/qt5/*" \
		! -wholename "./lib/libpoppler-qt5.so" \
		! -wholename "./lib/pkgconfig/poppler-qt5.pc" \
		! -wholename "./share/doc/$NEOTERM_PKG_NAME/*" \
		-exec rm -f '{}' \;
	find . -type d -empty -delete
}
