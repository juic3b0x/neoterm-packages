NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/motif/
NEOTERM_PKG_DESCRIPTION="Motif widget toolkit"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.8
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/motif/Motif%20${NEOTERM_PKG_VERSION}%20Source%20Code/motif-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libandroid-support, libice, libiconv, libjpeg-turbo, libpng, libsm, libx11, libxext, libxft, libxmu, libxt"
NEOTERM_PKG_BUILD_DEPENDS="flex, xbitmaps, xorgproto"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__usr_X_include_X11_X_h=no
ac_cv_file__usr_X11R6_include_X11_X_h=no
ac_cv_func_setpgrp_void=yes
"
NEOTERM_MAKE_PROCESSES=1
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	rm -f tools/wml/{wmllex,wmluiltok}.c
}

neoterm_step_host_build() {
	"$NEOTERM_PKG_SRCDIR/configure" ${NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}

	make -C config/util makestrs
	make -C lib/Xm
	make -C tools/wml wmluiltok LIBS=-lfl
	make -C tools/wml
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/config/util:$NEOTERM_PKG_HOSTBUILD_DIR/tools/wml:$PATH
}

neoterm_step_post_configure() {
	make -C tools/wml wmluiltok LIBS=-lfl
}
