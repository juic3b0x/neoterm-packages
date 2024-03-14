NEOTERM_PKG_HOMEPAGE=https://rada.re
NEOTERM_PKG_DESCRIPTION="Advanced Hexadecimal Editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.8.8"
NEOTERM_PKG_SRCURL=https://github.com/radare/radare2/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4f88c33e4391f492c7d0073df9bffcc666cc1e2ca0a95d6e1035decdaa227b26
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libuv"
NEOTERM_PKG_BREAKS="radare2-dev"
NEOTERM_PKG_REPLACES="radare2-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-compiler=neoterm-host"

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Unset CPPFLAGS to avoid -I$NEOTERM_PREFIX/include. This is because
	# radare2 build will put its own -I flags after ours, which causes
	# problems due to name clashes (binutils header files).
	unset CPPFLAGS

	# If this variable is not set, then build will fail on linking with 'pthread'
	export ANDROID=1

	export OBJCOPY=$NEOTERM_HOST_PLATFORM-objcopy

	# Remove old libs which may mess with new build:
	rm -f $NEOTERM_PREFIX/lib/libr_*
}
