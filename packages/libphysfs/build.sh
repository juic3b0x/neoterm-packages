NEOTERM_PKG_HOMEPAGE=https://icculus.org/physfs/
NEOTERM_PKG_DESCRIPTION="A portable, flexible file i/o abstraction"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/icculus/physfs/archive/refs/tags/release-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1991500eaeb8d5325e3a8361847ff3bf8e03ec89252b7915e1f25b3f8ab5d560
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DPHYSFS_BUILD_STATIC=OFF
-DPHYSFS_BUILD_TEST=OFF
"
