NEOTERM_PKG_HOMEPAGE=http://eigen.tuxfamily.org
NEOTERM_PKG_DESCRIPTION="Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4.0
NEOTERM_PKG_SHA256=8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72
NEOTERM_PKG_SRCURL=https://gitlab.com/libeigen/eigen/-/archive/${NEOTERM_PKG_VERSION}/eigen-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_BREAKS="eigen-dev"
NEOTERM_PKG_REPLACES="eigen-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=Release"
NEOTERM_PKG_GROUPS="science"
