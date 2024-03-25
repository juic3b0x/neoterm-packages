NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Utility libraries for XC Binding"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.12
NEOTERM_PKG_REVISION=28
NEOTERM_PKG_SRCURL=https://www.freedesktop.org/software/startup-notification/releases/startup-notification-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a
NEOTERM_PKG_DEPENDS="libx11, libxcb, xcb-util"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="lf_cv_sane_realloc=yes"
