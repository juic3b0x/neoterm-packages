NEOTERM_PKG_HOMEPAGE=https://www.mars.org/home/rob/proj/hfs/
NEOTERM_PKG_DESCRIPTION="Tool for manipulating HFS images"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=ftp://ftp.mars.org/pub/hfs/hfsutils-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840
NEOTERM_PKG_DEPENDS="libandroid-support"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_configure() {
	mkdir -p ${NEOTERM_PREFIX}/share/man/man1
}

