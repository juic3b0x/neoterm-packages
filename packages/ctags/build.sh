NEOTERM_PKG_HOMEPAGE=https://ctags.io/
NEOTERM_PKG_DESCRIPTION="Universal ctags: Source code index builder"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2:6.1.0"
NEOTERM_PKG_SRCURL=https://github.com/universal-ctags/ctags/archive/refs/tags/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=1eb6d46d4c4cace62d230e7700033b8db9ad3d654f2d4564e87f517d4b652a53
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libiconv, libjansson, libxml2, libyaml"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-tmpdir=$NEOTERM_PREFIX/tmp --disable-static"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	export regcomp_works=yes
	./autogen.sh
}

neoterm_step_pre_configure() {
	./autogen.sh
	cp $NEOTERM_PKG_HOSTBUILD_DIR/packcc $NEOTERM_PKG_BUILDDIR/
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/packcc
}
