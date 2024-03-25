NEOTERM_PKG_HOMEPAGE=https://github.com/Martchus/cpp-utilities
NEOTERM_PKG_DESCRIPTION="Useful C++ classes and routines such as argument parser, IO and conversion utilities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.24.7"
NEOTERM_PKG_SRCURL=https://github.com/Martchus/cpp-utilities/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c3aa125933aaf9724eacca045f5d8278d524a4cef95ce54b89e88e1ac15684c2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="boost, libc++, libiconv"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
