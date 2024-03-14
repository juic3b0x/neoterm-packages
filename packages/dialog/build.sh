NEOTERM_PKG_HOMEPAGE=https://invisible-island.net/dialog/
NEOTERM_PKG_DESCRIPTION="Application used in shell scripts which displays text user interface widgets"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_VERSION=1.3-20230209
NEOTERM_PKG_SRCURL=https://invisible-island.net/archives/dialog/dialog-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=0c26282305264be2217f335f3798f48b1dce3cf12c5a076bf231cadf77a6d6a8
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-ncursesw --enable-widec --with-pkg-config"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Put a temporary link for libtinfo.so
	ln -s -f $NEOTERM_PREFIX/lib/libncursesw.so $NEOTERM_PREFIX/lib/libtinfo.so
}

neoterm_step_post_make_install() {
	rm $NEOTERM_PREFIX/lib/libtinfo.so
}
