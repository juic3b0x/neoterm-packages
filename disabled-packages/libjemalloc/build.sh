NEOTERM_PKG_HOMEPAGE=http://www.canonware.com/jemalloc/
NEOTERM_PKG_DESCRIPTION="General-purpose scalable concurrent malloc(3) implementation"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.0.0
NEOTERM_PKG_SRCURL=https://github.com/jemalloc/jemalloc/releases/download/${NEOTERM_PKG_VERSION}/jemalloc-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256="214dbc74c3669b34219b0c5a55cb96f07cb12f44c834ed9ee64d1185ee6c3ef2"
NEOTERM_PKG_BUILD_IN_SRC=true

CPPFLAGS+=" -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4=1"
