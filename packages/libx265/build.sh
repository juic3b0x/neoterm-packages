NEOTERM_PKG_HOMEPAGE=http://x265.org/
NEOTERM_PKG_DESCRIPTION="H.265/HEVC video stream encoder library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=38cf1c379b5af08856bb2fdd65f65a1f99384886
_COMMIT_DATE=20230222
NEOTERM_PKG_VERSION=3.5-p${_COMMIT_DATE}
#NEOTERM_PKG_SRCURL=https://bitbucket.org/multicoreware/x265_git/downloads/x265_$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SRCURL=git+https://bitbucket.org/multicoreware/x265_git
NEOTERM_PKG_SHA256=5a8c54fb41b449538c160d3b48f439fa1c079b77f1c165c7b6967f5cb480ffd7
NEOTERM_PKG_GIT_BRANCH=master
NEOTERM_PKG_DEPENDS="libandroid-posix-semaphore, libc++"
NEOTERM_PKG_BREAKS="libx265-dev"
NEOTERM_PKG_REPLACES="libx265-dev"

neoterm_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local pdate="p$(git log -1 --format=%cs | sed 's/-//g')"
	if [[ "$NEOTERM_PKG_VERSION" != *"${pdate}" ]]; then
		echo -n "ERROR: The version string \"$NEOTERM_PKG_VERSION\" is"
		echo -n " different from what is expected to be; should end"
		echo " with \"${pdate}\"."
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]]; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=207

	local v=$(sed -En 's/^.*set\(X265_BUILD ([0-9]+).*$/\1/p' \
			source/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi

	if [ -d .git ]; then
		local _libx265_base_version="3.5"
		local _libx265_base_commit="f0c1022b6be121a753ff02853fbe33da71988656"
		if [ "${NEOTERM_PKG_VERSION%-*}" != "${_libx265_base_version}" ]; then
			neoterm_error_exit "Base version mismatch; expected to be ${_libx265_base_version}."
		fi
		cat > x265Version.txt <<-EOF
			repositorychangeset: $(git log --pretty=format:%h -n 1)
			releasetagdistance: $(git rev-list ${_libx265_base_commit}.. --count --first-parent)
			releasetag: ${_libx265_base_version}
		EOF

		# To install shared lib
		rm -rf .git
	fi
}

neoterm_step_pre_configure() {
	local _NEOTERM_CLANG_TARGET=

	# Not sure if this is necessary for on-device build
	# Follow neoterm_step_configure_cmake.sh for now
	if [ "$NEOTERM_ON_DEVICE_BUILD" = false ]; then
		_NEOTERM_CLANG_TARGET="--target=${CCNEOTERM_HOST_PLATFORM}"
	fi

	if [ "$NEOTERM_ARCH" = arm ] || [ "$NEOTERM_ARCH" = i686 ]; then
		# Avoid text relocations and/or build failure.
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_ASSEMBLY=OFF"
	fi

	NEOTERM_PKG_SRCDIR="$NEOTERM_PKG_SRCDIR/source"

	sed -i "s/@NEOTERM_CLANG_TARGET_${NEOTERM_ARCH^^}@/${_NEOTERM_CLANG_TARGET}/" \
		${NEOTERM_PKG_SRCDIR}/CMakeLists.txt

	LDFLAGS+=" -landroid-posix-semaphore"
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
