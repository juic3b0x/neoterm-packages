NEOTERM_PKG_HOMEPAGE=http://x3270.bgp.nu/
NEOTERM_PKG_DESCRIPTION="A family of IBM 3270 terminal emulators and related tools"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="include/copyright.h"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.1ga11
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://prdownloads.sourceforge.net/x3270/suite3270-${NEOTERM_PKG_VERSION}-src.tgz
NEOTERM_PKG_SHA256=c36d12fcf211cce48c7488b06d806b0194c71331abdce6da90953099acb1b0bf
NEOTERM_PKG_DEPENDS="less, libexpat, libiconv, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-windows
--disable-x3270
--disable-tcl3270 
ac_cv_path_LESSPATH=$NEOTERM_PREFIX/bin/less
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR"

	find $NEOTERM_PKG_SRCDIR -name '*.c' | xargs -n 1 sed -i \
		-e 's:"\(/bin/sh"\):"'$NEOTERM_PREFIX'\1:g' \
		-e 's:"\(/tmp\):"'$NEOTERM_PREFIX'\1:g'
}

neoterm_step_post_configure() {
	local bin=$NEOTERM_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	pushd $NEOTERM_PKG_SRCDIR/Common
	$CC_FOR_BUILD mkicon.c -o mkicon
	cp mkicon $bin/
	pushd c3270
	$CC_FOR_BUILD mkkeypad.c -o mkkeypad
	cp mkkeypad $bin/
	popd
	popd
	PATH=$bin:$PATH
}
