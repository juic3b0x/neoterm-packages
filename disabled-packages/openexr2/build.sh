NEOTERM_PKG_HOMEPAGE=https://www.openexr.com/
NEOTERM_PKG_DESCRIPTION="Provides the specification and reference implementation of the EXR file format"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.5.8
NEOTERM_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=db261a7fcc046ec6634e4c5696a2fc2ce8b55f50aac6abe034308f54c8495f55
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
-DPYILMBASE_ENABLE=OFF
"

neoterm_step_pre_configure() {
	case "$NEOTERM_PKG_VERSION" in
		2.*|*:2.* ) ;;
		* ) neoterm_error_exit "Invalid version '$NEOTERM_PKG_VERSION' for package '$NEOTERM_PKG_NAME'." ;;
	esac
}
