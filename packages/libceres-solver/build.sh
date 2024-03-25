NEOTERM_PKG_HOMEPAGE="http://ceres-solver.org"
NEOTERM_PKG_DESCRIPTION="C++ library for modeling and solving large, complicated optimization problems"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.2.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="http://ceres-solver.org/ceres-solver-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=48b2302a7986ece172898477c3bcd6deb8fb5cf19b3327bc49969aad4cede82d
NEOTERM_PKG_DEPENDS="libc++, eigen, google-glog, gflags"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DMINIGLOG=ON
"

