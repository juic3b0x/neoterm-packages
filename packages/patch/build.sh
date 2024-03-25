NEOTERM_PKG_HOMEPAGE=https://savannah.gnu.org/projects/patch/
NEOTERM_PKG_DESCRIPTION="GNU patch which applies diff files to create patched files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.6
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/patch/patch-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ac610bda97abe0d9f6b7c963255a11dcb196c25e337c61f94e4778d632f1d8fd
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-xattr ac_cv_path_ED=$NEOTERM_PREFIX/bin/ed"
NEOTERM_PKG_GROUPS="base-devel"
