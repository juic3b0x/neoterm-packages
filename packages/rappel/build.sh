NEOTERM_PKG_HOMEPAGE=https://github.com/yrp604/rappel
NEOTERM_PKG_DESCRIPTION="Rappel is a pretty janky assembly REPL"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=b848fce5e3759f3cbeda55e3cd8dcd7321525a44
NEOTERM_PKG_VERSION=2022.11.07
NEOTERM_PKG_SRCURL=git+https://github.com/yrp604/rappel
NEOTERM_PKG_SHA256=e3dfe84e88b7711918555e40cb88f723ee99f197795193cd5620367b29f4a56e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="binutils-is-llvm | binutils, libedit"
NEOTERM_PKG_BUILD_IN_SRC=true

# Need nasm.
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$NEOTERM_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$NEOTERM_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_make() {
	local _ARCH

	if [ "$NEOTERM_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$NEOTERM_ARCH" = "x86_64" ]; then
		_ARCH="amd64"
	elif [ "$NEOTERM_ARCH" = "arm" ]; then
		_ARCH="armv7"
	elif [ "$NEOTERM_ARCH" = "aarch64" ]; then
		_ARCH="armv8"
	else
		_ARCH=$NEOTERM_ARCH
	fi

	make ARCH=$_ARCH CC="$CC $CPPFLAGS $CFLAGS" LDFLAGS="$LDFLAGS" -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_make_install() {
	cd bin
	install -Dm755 -t "$NEOTERM_PREFIX/bin" rappel
}
