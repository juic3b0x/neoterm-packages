#!/usr/bin/env bash
##
## Download all package sources and install all build tools whether possible,
## so they will be available offline.
##

set -e -u

if [ "$(uname -o)" = "Android" ] || [ "$(uname -m)" != "x86_64" ]; then
	echo "This script supports only x86_64 GNU/Linux systems."
	exit 1
fi

export NEOTERM_SCRIPTDIR="$(dirname "$(readlink -f "$0")")/../"
mkdir -p "$NEOTERM_SCRIPTDIR"/build-tools

. "$NEOTERM_SCRIPTDIR"/scripts/properties.sh
: "${NEOTERM_MAKE_PROCESSES:="$(nproc)"}"
export NEOTERM_MAKE_PROCESSES
export NEOTERM_PACKAGES_OFFLINE=true
export NEOTERM_ARCH=aarch64
export NEOTERM_ON_DEVICE_BUILD=false
export NEOTERM_PKG_TMPDIR="$NEOTERM_SCRIPTDIR/build-tools/_tmp"
export NEOTERM_COMMON_CACHEDIR="$NEOTERM_PKG_TMPDIR"
export NEOTERM_HOST_PLATFORM=aarch64-linux-android
export NEOTERM_ARCH_BITS=64
export NEOTERM_BUILD_TUPLE=x86_64-pc-linux-gnu
export NEOTERM_PKG_API_LEVEL=24
export NEOTERM_TOPDIR="$HOME/.neoterm-build"
export NEOTERM_PYTHON_CROSSENV_PREFIX="$NEOTERM_TOPDIR/python-crossenv-prefix"
export NEOTERM_PYTHON_VERSION=$(. "$NEOTERM_SCRIPTDIR/packages/python/build.sh"; echo "$_MAJOR_VERSION")
export CC=gcc CXX=g++ LD=ld AR=ar STRIP=strip PKG_CONFIG=pkg-config
export CPPFLAGS="" CFLAGS="" CXXFLAGS="" LDFLAGS=""
mkdir -p "$NEOTERM_PKG_TMPDIR"

# Build tools.
. "$NEOTERM_SCRIPTDIR"/scripts/build/neoterm_download.sh
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_cargo_c.sh
	neoterm_setup_cargo_c
)
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_cmake.sh
	neoterm_setup_cmake
)
# GHC fails. Skipping for now.
#(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_ghc.sh
#	neoterm_setup_ghc
#)
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_golang.sh
	neoterm_setup_golang
)
(
	. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_ninja.sh
	. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_meson.sh
	neoterm_setup_meson
)
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_protobuf.sh
	neoterm_setup_protobuf
)
#(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_python_pip.sh
#	neoterm_setup_python_pip
#)
# Offline rust is not supported yet.
#(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_rust.sh
#	neoterm_setup_rust
#)
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_swift.sh
	neoterm_setup_swift
)
(. "$NEOTERM_SCRIPTDIR"/scripts/build/setup/neoterm_setup_zig.sh
	neoterm_setup_zig
)
(test -d "$NEOTERM_SCRIPTDIR"/build-tools/android-sdk && test -d "$NEOTERM_SCRIPTDIR"/build-tools/android-ndk && exit 0
	"$NEOTERM_SCRIPTDIR"/scripts/setup-android-sdk.sh
)
rm -rf "${NEOTERM_PKG_TMPDIR}"

# Package sources.
for repo_path in $(jq --raw-output 'del(.pkg_format) | keys | .[]' $NEOTERM_SCRIPTDIR/repo.json); do
	for p in "$NEOTERM_SCRIPTDIR"/$repo_path/*; do
		(
			. "$NEOTERM_SCRIPTDIR"/scripts/build/get_source/neoterm_step_get_source.sh
			. "$NEOTERM_SCRIPTDIR"/scripts/build/get_source/neoterm_git_clone_src.sh
			. "$NEOTERM_SCRIPTDIR"/scripts/build/get_source/neoterm_download_src_archive.sh
			. "$NEOTERM_SCRIPTDIR"/scripts/build/get_source/neoterm_unpack_src_archive.sh

			# Disable archive extraction in neoterm_step_get_source.sh.
			neoterm_extract_src_archive() {
				:
			}

			NEOTERM_PKG_NAME=$(basename "$p")
			NEOTERM_PKG_BUILDER_DIR="${p}"
			NEOTERM_PKG_CACHEDIR="${p}/cache"
			NEOTERM_PKG_METAPACKAGE=false

			# Set some variables to dummy values to avoid errors.
			NEOTERM_PKG_TMPDIR="${NEOTERM_PKG_CACHEDIR}/.tmp"
			NEOTERM_PKG_SRCDIR="${NEOTERM_PKG_CACHEDIR}/.src"
			NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
			NEOTERM_PKG_HOSTBUILD_DIR="$NEOTERM_PKG_TMPDIR"
			NEOTERM_PKG_GIT_BRANCH=""
			NEOTERM_DEBUG_BUILD=false


			mkdir -p "$NEOTERM_PKG_CACHEDIR" "$NEOTERM_PKG_TMPDIR" "$NEOTERM_PKG_SRCDIR"
			cd "$NEOTERM_PKG_CACHEDIR"

			. "${p}"/build.sh || true
			if ! ${NEOTERM_PKG_METAPACKAGE}; then
				echo "Downloading sources for '$NEOTERM_PKG_NAME'..."
				neoterm_step_get_source

				# Delete dummy src and tmp directories.
				rm -rf "$NEOTERM_PKG_TMPDIR" "$NEOTERM_PKG_SRCDIR"
			fi
		)
	done
done

# Mark to tell build-package.sh to enable offline mode.
touch "$NEOTERM_SCRIPTDIR"/build-tools/.installed
