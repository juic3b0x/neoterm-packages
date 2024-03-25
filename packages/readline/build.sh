NEOTERM_PKG_HOMEPAGE="https://tiswww.case.edu/php/chet/readline/rltop.html"
NEOTERM_PKG_DESCRIPTION="Library that allow users to edit command lines as they are typed in"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_BREAKS="bash (<< 5.0), readline-dev"
NEOTERM_PKG_REPLACES="readline-dev"
_MAIN_VERSION=8.2
_PATCH_VERSION=1
NEOTERM_PKG_VERSION=$_MAIN_VERSION.$_PATCH_VERSION
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/readline/readline-${_MAIN_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3feb7171f16a84ee82ca18a36d7b9be109a52c04f492a053331d7d1095007c35
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-curses --enable-multibyte bash_cv_wcwidth_broken=no"
NEOTERM_PKG_EXTRA_MAKE_ARGS="SHLIB_LIBS=-lncursesw"
NEOTERM_PKG_CONFFILES="etc/inputrc"

neoterm_step_pre_configure() {
	declare -A PATCH_CHECKSUMS

	PATCH_CHECKSUMS[001]=bbf97f1ec40a929edab5aa81998c1e2ef435436c597754916e6a5868f273aff7

	for PATCH_NUM in $(seq -f '%03g' ${_PATCH_VERSION}); do
		PATCHFILE=$NEOTERM_PKG_CACHEDIR/readline_patch_${PATCH_NUM}.patch
		neoterm_download \
			"http://mirrors.kernel.org/gnu/readline/readline-$_MAIN_VERSION-patches/readline${_MAIN_VERSION/./}-$PATCH_NUM" \
			$PATCHFILE \
			${PATCH_CHECKSUMS[$PATCH_NUM]}
		patch -p0 -i $PATCHFILE
	done

	CFLAGS+=" -fexceptions"
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/lib/pkgconfig
	cp readline.pc $NEOTERM_PREFIX/lib/pkgconfig/

	mkdir -p $NEOTERM_PREFIX/etc
	cp $NEOTERM_PKG_BUILDER_DIR/inputrc $NEOTERM_PREFIX/etc/
}
