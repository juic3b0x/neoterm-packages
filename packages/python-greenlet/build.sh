NEOTERM_PKG_HOMEPAGE=https://github.com/python-greenlet/greenlet
NEOTERM_PKG_DESCRIPTION="Lightweight coroutines for in-process concurrent programming"
# Licenses: MIT, PSF-2.0
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE.PSF"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.3"
NEOTERM_PKG_SRCURL=https://github.com/python-greenlet/greenlet/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=279241ddd123a9e3170713d6967f97f3ba8b413f5dd56f09b887bf48ec60a35d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true
