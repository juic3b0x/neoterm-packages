NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="A library that exposes a event API on top of Linux futexes"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libxshmfence-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=870df257bc40b126d91b5a8f1da6ca8a524555268c50b59c0acd1a27f361606f
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-futex"
