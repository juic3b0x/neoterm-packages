NEOTERM_PKG_HOMEPAGE=https://git.linuxtv.org/v4l-utils.git
NEOTERM_PKG_DESCRIPTION="Linux libraries to handle media devices"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.24.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://linuxtv.org/downloads/v4l-utils/v4l-utils-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=cbb7fe8a6307f5ce533a05cded70bb93c3ba06395ab9b6d007eb53b75d805f5b
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libandroid-glob, libjpeg-turbo"
NEOTERM_PKG_BUILD_DEPENDS="argp"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-v4l-utils
--disable-qv4l2
"
