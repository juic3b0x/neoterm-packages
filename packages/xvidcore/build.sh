NEOTERM_PKG_HOMEPAGE=https://www.xvid.com/
NEOTERM_PKG_DESCRIPTION="High performance and high quality MPEG-4 library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.7
NEOTERM_PKG_SRCURL=https://downloads.xvid.com/downloads/xvidcore-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=abbdcbd39555691dd1c9b4d08f0a031376a3b211652c0d8b3b8aa9be1303ce2d
NEOTERM_PKG_BREAKS="xvidcore-dev"
NEOTERM_PKG_REPLACES="xvidcore-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	rm -f $NEOTERM_PREFIX/lib/libxvid*
	export NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_BUILDDIR/build/generic
	export NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_BUILDDIR

	if [ $NEOTERM_ARCH = i686 ]; then
		# Avoid text relocations:
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-assembly"
	fi
}

