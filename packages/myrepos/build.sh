NEOTERM_PKG_HOMEPAGE=https://myrepos.branchable.com/
NEOTERM_PKG_DESCRIPTION="Tool to manage all your version control repos"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.20180726
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/m/myrepos/myrepos_$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=9e9e4c114aae22e0aac51ecbc8d84ae617a5e5dfa979fab0d3bc42945f603f1e
NEOTERM_PKG_DEPENDS="git, perl"
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
