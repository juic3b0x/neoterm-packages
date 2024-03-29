NEOTERM_PKG_HOMEPAGE=https://github.com/dylanaraps/neofetch
NEOTERM_PKG_DESCRIPTION="Simple system information script"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.1.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/dylanaraps/neofetch/archive/${NEOTERM_PKG_VERSION}/neofetch-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=58a95e6b714e41efc804eca389a223309169b2def35e57fa934482a6b47c27e7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash"
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX SYSCONFDIR=$NEOTERM_PREFIX/etc"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
