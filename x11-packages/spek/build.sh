NEOTERM_PKG_HOMEPAGE=http://spek.cc/
NEOTERM_PKG_DESCRIPTION="An acoustic spectrum analyser"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.5
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/alexkay/spek/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9053d2dec452dcde421daa0f5f59a9dee47927540f41d9c0c66800cb6dbf6996
NEOTERM_PKG_DEPENDS="ffmpeg, libc++, wxwidgets"
NEOTERM_PKG_SUGGESTS="libandroid-stub"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_WX_CONFIG_PATH=$NEOTERM_PREFIX/bin/wx-config"

neoterm_step_pre_configure() {
	mkdir -p m4
	cp $NEOTERM_PREFIX/share/aclocal/wxwin.m4 m4/
	NOCONFIGURE=1 sh autogen.sh
}

neoterm_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Note: If you encounter Segmentation Fault, execute the following command:"
	echo "pkg install libandroid-stub"
	EOF
}
