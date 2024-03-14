NEOTERM_PKG_HOMEPAGE="https://github.com/dartsim/dart"
NEOTERM_PKG_DESCRIPTION="Dynamic Animation and Robotics Toolkit"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Pooya Moradi <pvonmoradi@gmail.com>"
NEOTERM_PKG_VERSION="6.13.1"
NEOTERM_PKG_SRCURL="https://github.com/dartsim/dart/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=d3792b61bc2a7ae6682b6d87e09b5d45e325cb08c55038a01e58288ddc3d58d8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"
# FIXME add ipopt, nlopt, snopt  after a proper FORTRAN compiler is
# added (hence LAPACK)
# FIXME why pagmo is not detected by build system?
# FIXME add urdfdom
NEOTERM_PKG_DEPENDS="libc++, eigen, assimp, libccd, libfcl, fmt, libspdlog, libbullet, libode, libpagmo, octomap-static, libtinyxml2"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DDART_VERBOSE=ON
-DBUILD_SHARED_LIBS=ON
-DDART_ENABLE_SIMD=OFF
-DDART_BUILD_GUI_OSG=OFF
-DDART_BUILD_DARTPY=OFF
-DDART_CODECOV=OFF
-DDART_FAST_DEBUG=OFF
-DDART_FORCE_COLORED_OUTPUT=OFF
-DDART_DOWNLOAD_DEPENDENT_PACKAGES=OFF
-DDART_TREAT_WARNINGS_AS_ERRORS=OFF
"

