#!/bin/bash
# shellcheck disable=SC1117

# Setting the TMPDIR variable
: "${TMPDIR:=/tmp}"
export TMPDIR

# Set the build-package.sh call depth
# If its the root call, then create a file to store the list of packages and their dependencies
# that have been compiled at any instant by recursive calls to build-package.sh
if [[ ! "$NEOTERM_BUILD_PACKAGE_CALL_DEPTH" =~ ^[0-9]+$ ]]; then
	export NEOTERM_BUILD_PACKAGE_CALL_DEPTH=0
	export NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH="${TMPDIR}/build-package-call-built-packages-list-$(date +"%Y-%m-%d-%H.%M.%S.")$((RANDOM%1000))"
	export NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH="${TMPDIR}/build-package-call-building-packages-list-$(date +"%Y-%m-%d-%H.%M.%S.")$((RANDOM%1000))"
	echo -n " " > "$NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH"
	touch "$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
else
	export NEOTERM_BUILD_PACKAGE_CALL_DEPTH=$((NEOTERM_BUILD_PACKAGE_CALL_DEPTH+1))
fi

set -e -o pipefail -u

cd "$(realpath "$(dirname "$0")")"
NEOTERM_SCRIPTDIR=$(pwd)
export NEOTERM_SCRIPTDIR

# Store pid of current process in a file for docker__run_docker_exec_trap
source "$NEOTERM_SCRIPTDIR/scripts/utils/docker/docker.sh"; docker__create_docker_exec_pid_file

# Functions for working with packages
source "$NEOTERM_SCRIPTDIR/scripts/utils/package/package.sh"

SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct 2>/dev/null || date "+%s")
export SOURCE_DATE_EPOCH

if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	if [ "$(id -u)" = "0" ]; then
		echo "On-device execution of this script as root is disabled."
		exit 1
	fi

	# This variable tells all parts of build system that build
	# is performed on device.
	export NEOTERM_ON_DEVICE_BUILD=true
else
	export NEOTERM_ON_DEVICE_BUILD=false
fi

# Automatically enable offline set of sources and build tools.
# Offline neoterm-packages bundle can be created by executing
# script ./scripts/setup-offline-bundle.sh.
if [ -f "${NEOTERM_SCRIPTDIR}/build-tools/.installed" ]; then
	export NEOTERM_PACKAGES_OFFLINE=true
fi

# Lock file to prevent parallel running in the same environment.
NEOTERM_BUILD_LOCK_FILE="${TMPDIR}/.neoterm-build.lck"
if [ ! -e "$NEOTERM_BUILD_LOCK_FILE" ]; then
	touch "$NEOTERM_BUILD_LOCK_FILE"
fi

export NEOTERM_PACKAGES_DIRECTORIES=$(jq --raw-output 'del(.pkg_format) | keys | .[]' ${NEOTERM_SCRIPTDIR}/repo.json)
export NEOTERM_REPO_PKG_FORMAT=$(jq --raw-output '.pkg_format // "debian"' ${NEOTERM_SCRIPTDIR}/repo.json)

# Special variable for internal use. It forces script to ignore
# lock file.
: "${NEOTERM_BUILD_IGNORE_LOCK:=false}"

# Utility function to log an error message and exit with an error code.
# shellcheck source=scripts/build/neoterm_error_exit.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_error_exit.sh"

# Utility function to download a resource with an expected checksum.
# shellcheck source=scripts/build/neoterm_download.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_download.sh"

# Installing packages if necessary for the full operation of CGCT.
# shellcheck source=scripts/build/neoterm_step_setup_cgct_environment.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_setup_cgct_environment.sh"

# Utility function for setting up Cargo C-ABI helpers.
# shellcheck source=scripts/build/setup/neoterm_setup_cargo_c.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_cargo_c.sh"

# Utility function for setting up Crystal toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_crystal.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_crystal.sh"

# Utility function for setting up Flang toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_flang.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_flang.sh"

# Utility function for setting up GHC toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_ghc.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_ghc.sh"

# Utility function to setup a GHC cross-compiler toolchain targeting Android.
# shellcheck source=scripts/build/setup/neoterm_setup_ghc_cross_compiler.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_ghc_cross_compiler.sh"

# Utility function to setup cabal-install (may be used by ghc toolchain).
# shellcheck source=scripts/build/setup/neoterm_setup_cabal.sh.
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_cabal.sh"

# Utility function to setup jailbreak-cabal. It is used to remove version constraints
# from Cabal packages.
# shellcheck source=scripts/build/setup/neoterm_setup_jailbreak_cabal.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_jailbreak_cabal.sh"

# Utility function for setting up GObject Introspection cross environment.
# shellcheck source=scripts/build/setup/neoterm_setup_gir.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_gir.sh"

# Utility function for setting up GN toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_gn.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_gn.sh"

# Utility function for golang-using packages to setup a go toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_golang.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_golang.sh"

# Utility function for setting up no-integrated (GNU Binutils) as.
# shellcheck source=scripts/build/setup/neoterm_setup_no_integrated_as.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_no_integrated_as.sh"

# Utility function for python packages to setup a python.
# shellcheck source=scripts/build/setup/neoterm_setup_python_pip.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_python_pip.sh"

# Utility function for rust-using packages to setup a rust toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_rust.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_rust.sh"

# Utility function for swift-using packages to setup a swift toolchain
# shellcheck source=scripts/build/setup/neoterm_setup_swift.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_swift.sh"

# Utility function to setup a current xmake build system.
# shellcheck source=scripts/build/setup/neoterm_setup_xmake.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_xmake.sh"

# Utility function for zig-using packages to setup a zig toolchain.
# shellcheck source=scripts/build/setup/neoterm_setup_zig.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_zig.sh"

# Utility function to setup a current ninja build system.
# shellcheck source=scripts/build/setup/neoterm_setup_ninja.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_ninja.sh"

# Utility function to setup Node.js JavaScript Runtime
# shellcheck source=scripts/build/setup/neoterm_setup_nodejs.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_nodejs.sh"

# Utility function to setup a current meson build system.
# shellcheck source=scripts/build/setup/neoterm_setup_meson.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_meson.sh"

# Utility function to setup a current cmake build system
# shellcheck source=scripts/build/setup/neoterm_setup_cmake.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_cmake.sh"

# Utility function to setup protobuf:
# shellcheck source=scripts/build/setup/neoterm_setup_protobuf.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/setup/neoterm_setup_protobuf.sh"

# Setup variables used by the build. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_setup_variables.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_setup_variables.sh"

# Save away and restore build setups which may change between builds.
# shellcheck source=scripts/build/neoterm_step_handle_buildarch.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_handle_buildarch.sh"

# Function to get NEOTERM_PKG_VERSION from build.sh
# shellcheck source=scripts/build/neoterm_extract_dep_info.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_extract_dep_info.sh"

# Function that downloads a .deb (using the neoterm_download function)
# shellcheck source=scripts/build/neoterm_download_deb_pac.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_download_deb_pac.sh"

# Script to download InRelease, verify it's signature and then download Packages.xz by hash
# shellcheck source=scripts/build/neoterm_get_repo_files.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_get_repo_files.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_get_dependencies.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_get_dependencies.sh"

# Download python dependency modules for compilation.
# shellcheck source=scripts/build/neoterm_step_get_dependencies_python.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_get_dependencies_python.sh"

# Handle config scripts that needs to be run during build. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_override_config_scripts.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_override_config_scripts.sh"

# Remove old src and build folders and create new ones
# shellcheck source=scripts/build/neoterm_step_setup_build_folders.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_setup_build_folders.sh"

# Source the package build script and start building. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_start_build.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_start_build.sh"

# Download or build dependencies. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_create_timestamp_file.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_timestamp_file.sh"

# Run just after sourcing $NEOTERM_PKG_BUILDER_SCRIPT. Can be overridden by packages.
# shellcheck source=scripts/build/get_source/neoterm_step_get_source.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/get_source/neoterm_step_get_source.sh"

# Run from neoterm_step_get_source if NEOTERM_PKG_SRCURL begins with "git+".
# shellcheck source=scripts/build/get_source/neoterm_step_get_source.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/get_source/neoterm_git_clone_src.sh"

# Run from neoterm_step_get_source if NEOTERM_PKG_SRCURL does not begin with "git+".
# shellcheck source=scripts/build/get_source/neoterm_download_src_archive.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/get_source/neoterm_download_src_archive.sh"

# Run from neoterm_step_get_source after neoterm_download_src_archive.
# shellcheck source=scripts/build/get_source/neoterm_unpack_src_archive.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/get_source/neoterm_unpack_src_archive.sh"

# Hook for packages to act just after the package sources have been obtained.
# Invoked from $NEOTERM_PKG_SRCDIR.
neoterm_step_post_get_source() {
	return
}

# Optional host build. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_handle_hostbuild.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_handle_hostbuild.sh"

# Perform a host build. Will be called in $NEOTERM_PKG_HOSTBUILD_DIR.
# After neoterm_step_post_get_source() and before neoterm_step_patch_package()
# shellcheck source=scripts/build/neoterm_step_host_build.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_host_build.sh"

# Setup a standalone Android NDK toolchain. Called from neoterm_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/neoterm_setup_toolchain_26b.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/toolchain/neoterm_setup_toolchain_26b.sh"

# Setup a standalone Android NDK 23c toolchain. Called from neoterm_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/neoterm_setup_toolchain_23c.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/toolchain/neoterm_setup_toolchain_23c.sh"

# Setup a standalone Glibc GNU toolchain. Called from neoterm_step_setup_toolchain.
# shellcheck source=scripts/build/toolchain/neoterm_setup_toolchain_gnu.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/toolchain/neoterm_setup_toolchain_gnu.sh"

# Runs neoterm_step_setup_toolchain_${NEOTERM_NDK_VERSION}. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_setup_toolchain.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_setup_toolchain.sh"

# Apply all *.patch files for the package. Not to be overridden by packages.
# shellcheck source=scripts/build/neoterm_step_patch_package.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_patch_package.sh"

# Replace autotools build-aux/config.{sub,guess} with ours to add android targets.
# shellcheck source=scripts/build/neoterm_step_replace_guess_scripts.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_replace_guess_scripts.sh"

# For package scripts to override. Called in $NEOTERM_PKG_BUILDDIR.
neoterm_step_pre_configure() {
	return
}

# Setup configure args and run $NEOTERM_PKG_SRCDIR/configure. This function is called from neoterm_step_configure
# shellcheck source=scripts/build/configure/neoterm_step_configure_autotools.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/configure/neoterm_step_configure_autotools.sh"

# Setup configure args and run cmake. This function is called from neoterm_step_configure
# shellcheck source=scripts/build/configure/neoterm_step_configure_cmake.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/configure/neoterm_step_configure_cmake.sh"

# Setup configure args and run meson. This function is called from neoterm_step_configure
# shellcheck source=scripts/build/configure/neoterm_step_configure_meson.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/configure/neoterm_step_configure_meson.sh"

# Setup configure args and run haskell build system. This function is called from neoterm_step_configure.
# shellcheck source=scripts/build/configure/neoterm_step_configure_haskell_build.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/configure/neoterm_step_configure_haskell_build.sh"

# Configure the package
# shellcheck source=scripts/build/configure/neoterm_step_configure.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/configure/neoterm_step_configure.sh"

# Hook for packages after configure step
neoterm_step_post_configure() {
	return
}

# Make package, either with ninja or make
# shellcheck source=scripts/build/neoterm_step_make.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_make.sh"

# Make install, either with ninja, make of cargo
# shellcheck source=scripts/build/neoterm_step_make_install.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_make_install.sh"

# Hook function for package scripts to override.
neoterm_step_post_make_install() {
	return
}

# Add service scripts from array NEOTERM_PKG_SERVICE_SCRIPT, if it is set
# shellcheck source=scripts/build/neoterm_step_install_service_scripts.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_install_service_scripts.sh"

# Link/copy the LICENSE for the package to $NEOTERM_PREFIX/share/$NEOTERM_PKG_NAME/
# shellcheck source=scripts/build/neoterm_step_install_license.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_install_license.sh"

# Function to cp (through tar) installed files to massage dir
# shellcheck source=scripts/build/neoterm_step_extract_into_massagedir.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_extract_into_massagedir.sh"

# Hook function to create {pre,post}install, {pre,post}rm-scripts for subpkgs
# shellcheck source=scripts/build/neoterm_step_create_subpkg_debscripts.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_subpkg_debscripts.sh"

# Create all subpackages. Run from neoterm_step_massage
# shellcheck source=scripts/build/neoterm_create_debian_subpackages.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_create_debian_subpackages.sh"

# Create all subpackages. Run from neoterm_step_massage
# shellcheck source=scripts/build/neoterm_create_pacman_subpackages.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_create_pacman_subpackages.sh"

# Function to run various cleanup/fixes
# shellcheck source=scripts/build/neoterm_step_massage.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_massage.sh"

# Hook for packages after massage step
neoterm_step_post_massage() {
	return
}

# Hook function to create {pre,post}install, {pre,post}rm-scripts and similar
neoterm_step_create_debscripts() {
	return
}

# Convert Debian maintainer scripts into pacman-compatible installation hooks.
# This is used only when creating pacman packages.
# shellcheck source=scripts/build/neoterm_step_create_pacman_install_hook.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_pacman_install_hook.sh"

# Create the build deb file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/neoterm_step_create_debian_package.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_debian_package.sh"

# Create the build .pkg.tar.xz file. Not to be overridden by package scripts.
# shellcheck source=scripts/build/neoterm_step_create_pacman_package.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_create_pacman_package.sh"

# Finish the build. Not to be overridden by package scripts.
# shellcheck source=scripts/build/neoterm_step_finish_build.sh
source "$NEOTERM_SCRIPTDIR/scripts/build/neoterm_step_finish_build.sh"

################################################################################

# shellcheck source=scripts/properties.sh
. "$NEOTERM_SCRIPTDIR/scripts/properties.sh"

if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
	# Setup NEOTERM_APP_PACKAGE_MANAGER
	source "$NEOTERM_PREFIX/bin/neoterm-setup-package-manager"

	# For on device builds cross compiling is not supported.
	# Target architecture must be same as for environment used currently.
	case "$NEOTERM_APP_PACKAGE_MANAGER" in
		"apt") NEOTERM_ARCH=$(dpkg --print-architecture);;
		"pacman") NEOTERM_ARCH=$(pacman-conf Architecture);;
	esac
	export NEOTERM_ARCH
fi

# Check if the package is in the compiled list
neoterm_check_package_in_built_packages_list() {
	[ ! -f "$NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH" ] && neoterm_error_exit "ERROR: file '$NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH' not found."
	cat "$NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH" | grep -q " $1 "
	return $?
}

# Adds a package to the list of built packages if it is not in the list
neoterm_add_package_to_built_packages_list() {
	if ! neoterm_check_package_in_built_packages_list "$1"; then
		echo -n "$1 " >> $NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH
	fi
}

# Check if the package is in the compiling list
neoterm_check_package_in_building_packages_list() {
	[ ! -f "$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH" ] && neoterm_error_exit "ERROR: file '$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH' not found."
	grep -q "^${1}$" "$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
	return $?
}

# Special hook to prevent use of "sudo" inside package build scripts.
# build-package.sh shouldn't perform any privileged operations.
sudo() {
	neoterm_error_exit "Do not use 'sudo' inside build scripts. Build environment should be configured through ./scripts/setup-ubuntu.sh."
}

_show_usage() {
	echo "Usage: ./build-package.sh [options] PACKAGE_1 PACKAGE_2 ..."
	echo
	echo "Build a package by creating a .deb file in the debs/ folder."
	echo
	echo "Available options:"
	[ "$NEOTERM_ON_DEVICE_BUILD" = "false" ] && echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -d Build with debug symbols."
	echo "  -D Build a disabled package in disabled-packages/."
	echo "  -f Force build even if package has already been built."
	echo "  -F Force build even if package and its dependencies have already been built."
	[ "$NEOTERM_ON_DEVICE_BUILD" = "false" ] && echo "  -i Download and extract dependencies instead of building them."
	echo "  -I Download and extract dependencies instead of building them, keep existing $NEOTERM_BASE_DIR files."
	echo "  -L The package and its dependencies will be based on the same library."
	echo "  -q Quiet build."
	echo "  -w Install dependencies without version binding."
	echo "  -s Skip dependency check."
	echo "  -o Specify directory where to put built packages. Default: output/."
	echo "  --format Specify package output format (debian, pacman)."
	echo "  --library Specify library of package (bionic, glibc)."
	exit 1
}

declare -a PACKAGE_LIST=()

if [ "$#" -lt 1 ]; then _show_usage; fi
while (($# >= 1)); do
	case "$1" in
		--) shift 1; break;;
		-h|--help) _show_usage;;
		--format)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					neoterm_error_exit "./build-package.sh: argument to '--format' should not be empty"
				fi
				export NEOTERM_PACKAGE_FORMAT="$1"
			else
				neoterm_error_exit "./build-package.sh: option '--format' requires an argument"
			fi
			;;
		--library)
			if [ $# -ge 2 ]; then
				shift
				if [ -z "$1" ]; then
					neoterm_error_exit "./build-package.sh: argument to '--library' should not be empty"
				fi
				export NEOTERM_PACKAGE_LIBRARY="$1"
			else
				neoterm_error_exit "./build-package.sh: option '--library' requires an argument"
			fi
			;;
		-a)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					neoterm_error_exit "Argument to '-a' should not be empty."
				fi
				if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
					neoterm_error_exit "./build-package.sh: option '-a' is not available for on-device builds"
				else
					export NEOTERM_ARCH="$1"
				fi
			else
				neoterm_error_exit "./build-package.sh: option '-a' requires an argument"
			fi
			;;
		-d) export NEOTERM_DEBUG_BUILD=true;;
		-D) NEOTERM_IS_DISABLED=true;;
		-f) NEOTERM_FORCE_BUILD=true;;
		-F) NEOTERM_FORCE_BUILD_DEPENDENCIES=true && NEOTERM_FORCE_BUILD=true;;
		-i)
			if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
				neoterm_error_exit "./build-package.sh: option '-i' is not available for on-device builds"
			elif [ "$NEOTERM_PREFIX" != "/data/data/com.neoterm/files/usr" ]; then
				neoterm_error_exit "./build-package.sh: option '-i' is available only when NEOTERM_APP_PACKAGE is 'com.neoterm'"
			else
				export NEOTERM_INSTALL_DEPS=true
			fi
			;;
		-I)
			if [ "$NEOTERM_PREFIX" != "/data/data/com.neoterm/files/usr" ]; then
				neoterm_error_exit "./build-package.sh: option '-I' is available only when NEOTERM_APP_PACKAGE is 'com.neoterm'"
			else
				export NEOTERM_INSTALL_DEPS=true
				export NEOTERM_NO_CLEAN=true
			fi
			;;
		-L) export NEOTERM_GLOBAL_LIBRARY=true;;
		-q) export NEOTERM_QUIET_BUILD=true;;
		-w) export NEOTERM_WITHOUT_DEPVERSION_BINDING=true;;
		-s) export NEOTERM_SKIP_DEPCHECK=true;;
		-o)
			if [ $# -ge 2 ]; then
				shift 1
				if [ -z "$1" ]; then
					neoterm_error_exit "./build-package.sh: argument to '-o' should not be empty"
				fi
				NEOTERM_OUTPUT_DIR=$(realpath -m "$1")
			else
				neoterm_error_exit "./build-package.sh: option '-o' requires an argument"
			fi
			;;
		-c) NEOTERM_CONTINUE_BUILD=true;;
		-*) neoterm_error_exit "./build-package.sh: illegal option '$1'";;
		*) PACKAGE_LIST+=("$1");;
	esac
	shift 1
done
unset -f _show_usage

# Dependencies should be used from repo only if they are built for
# same package name.
if [ "$NEOTERM_REPO_PACKAGE" != "$NEOTERM_APP_PACKAGE" ]; then
	echo "Ignoring -i option to download dependencies since repo package name ($NEOTERM_REPO_PACKAGE) does not equal app package name ($NEOTERM_APP_PACKAGE)"
	NEOTERM_INSTALL_DEPS=false
fi

if [ "$NEOTERM_REPO_PKG_FORMAT" != "debian" ] && [ "$NEOTERM_REPO_PKG_FORMAT" != "pacman" ]; then
	neoterm_error_exit "'pkg_format' is incorrectly specified in repo.json file. Only 'debian' and 'pacman' formats are supported"
fi

if [ -n "${NEOTERM_PACKAGE_FORMAT-}" ]; then
	case "${NEOTERM_PACKAGE_FORMAT-}" in
		debian|pacman) :;;
		*) neoterm_error_exit "Unsupported package format \"${NEOTERM_PACKAGE_FORMAT-}\". Only 'debian' and 'pacman' formats are supported";;
	esac
fi

if [ -n "${NEOTERM_PACKAGE_LIBRARY-}" ]; then
	case "${NEOTERM_PACKAGE_LIBRARY-}" in
		bionic|glibc) :;;
		*) neoterm_error_exit "Unsupported library \"${NEOTERM_PACKAGE_LIBRARY-}\". Only 'bionic' and 'glibc' library are supported";;
	esac
fi

if [ "${NEOTERM_INSTALL_DEPS-false}" = "true" ] || [ "${NEOTERM_PACKAGE_LIBRARY-bionic}" = "glibc" ]; then
	# Setup PGP keys for verifying integrity of dependencies.
	# Keys are obtained from our keyring package.
	gpg --list-keys 2C7F29AE97891F6419A9E2CDB0076E490B71616B > /dev/null 2>&1 || {
		gpg --import "$NEOTERM_SCRIPTDIR/packages/neoterm-keyring/grimler.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key 2C7F29AE97891F6419A9E2CDB0076E490B71616B
	}
	gpg --list-keys CC72CF8BA7DBFA0182877D045A897D96E57CF20C > /dev/null 2>&1 || {
		gpg --import "$NEOTERM_SCRIPTDIR/packages/neoterm-keyring/neoterm-autobuilds.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key CC72CF8BA7DBFA0182877D045A897D96E57CF20C
	}
	gpg --list-keys 998DE27318E867EA976BA877389CEED64573DFCA > /dev/null 2>&1 || {
		gpg --import "$NEOTERM_SCRIPTDIR/packages/neoterm-keyring/neoterm-pacman.gpg"
		gpg --no-tty --command-file <(echo -e "trust\n5\ny")  --edit-key 998DE27318E867EA976BA877389CEED64573DFCA
	}
fi

for ((i=0; i<${#PACKAGE_LIST[@]}; i++)); do
	# Following commands must be executed under lock to prevent running
	# multiple instances of "./build-package.sh".
	#
	# To provide sane environment for each package, builds are done
	# in subshell.
	(
		if ! $NEOTERM_BUILD_IGNORE_LOCK; then
			flock -n 5 || neoterm_error_exit "Another build is already running within same environment."
		fi

		# Handle 'all' arch:
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ] && [ -n "${NEOTERM_ARCH+x}" ] && [ "${NEOTERM_ARCH}" = 'all' ]; then
			for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
				env NEOTERM_ARCH="$arch" NEOTERM_BUILD_IGNORE_LOCK=true ./build-package.sh \
					${NEOTERM_FORCE_BUILD+-f} ${NEOTERM_INSTALL_DEPS+-i} ${NEOTERM_IS_DISABLED+-D} \
					${NEOTERM_DEBUG_BUILD+-d} ${NEOTERM_OUTPUT_DIR+-o $NEOTERM_OUTPUT_DIR} \
					${NEOTERM_FORCE_BUILD_DEPENDENCIES+-F} ${NEOTERM_GLOBAL_LIBRARY+-L} \
					${NEOTERM_WITHOUT_DEPVERSION_BINDING+-w} \
					--format ${NEOTERM_PACKAGE_FORMAT:=debian} \
					--library ${NEOTERM_PACKAGE_LIBRARY:=bionic} "${PACKAGE_LIST[i]}"
			done
			exit
		fi

		# Check the package to build:
		NEOTERM_PKG_NAME=$(basename "${PACKAGE_LIST[i]}")
		export NEOTERM_PKG_BUILDER_DIR=
		if [[ ${PACKAGE_LIST[i]} == *"/"* ]]; then
			# Path to directory which may be outside this repo:
			if [ ! -d "${PACKAGE_LIST[i]}" ]; then neoterm_error_exit "'${PACKAGE_LIST[i]}' seems to be a path but is not a directory"; fi
			export NEOTERM_PKG_BUILDER_DIR=$(realpath "${PACKAGE_LIST[i]}")
		else
			# Package name:
			for package_directory in $NEOTERM_PACKAGES_DIRECTORIES; do
				if [ -d "${NEOTERM_SCRIPTDIR}/${package_directory}/${NEOTERM_PKG_NAME}" ]; then
					export NEOTERM_PKG_BUILDER_DIR=${NEOTERM_SCRIPTDIR}/$package_directory/$NEOTERM_PKG_NAME
					break
				elif [ -n "${NEOTERM_IS_DISABLED=""}" ] && [ -d "${NEOTERM_SCRIPTDIR}/disabled-packages/${NEOTERM_PKG_NAME}" ]; then
					export NEOTERM_PKG_BUILDER_DIR=$NEOTERM_SCRIPTDIR/disabled-packages/$NEOTERM_PKG_NAME
					break
				fi
			done
			if [ -z "${NEOTERM_PKG_BUILDER_DIR}" ]; then
				neoterm_error_exit "No package $NEOTERM_PKG_NAME found in any of the enabled repositories. Are you trying to set up a custom repository?"
			fi
		fi
		NEOTERM_PKG_BUILDER_SCRIPT=$NEOTERM_PKG_BUILDER_DIR/build.sh
		if test ! -f "$NEOTERM_PKG_BUILDER_SCRIPT"; then
			neoterm_error_exit "No build.sh script at package dir $NEOTERM_PKG_BUILDER_DIR!"
		fi

		neoterm_step_setup_variables
		neoterm_step_handle_buildarch

		if [ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			neoterm_step_setup_build_folders
		fi

		neoterm_step_start_build

		if ! neoterm_check_package_in_building_packages_list "${NEOTERM_PKG_BUILDER_DIR#${NEOTERM_SCRIPTDIR}/}"; then
			echo "${NEOTERM_PKG_BUILDER_DIR#${NEOTERM_SCRIPTDIR}/}" >> $NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH
		fi

		if [ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			neoterm_step_get_dependencies
			if [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
				neoterm_step_setup_cgct_environment
			fi
			neoterm_step_override_config_scripts
		fi

		neoterm_step_create_timestamp_file

		if [ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			cd "$NEOTERM_PKG_CACHEDIR"
			neoterm_step_get_source
			cd "$NEOTERM_PKG_SRCDIR"
			neoterm_step_post_get_source
			neoterm_step_handle_hostbuild
		fi

		neoterm_step_setup_toolchain

		if [ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			neoterm_step_get_dependencies_python
			neoterm_step_patch_package
			neoterm_step_replace_guess_scripts
			cd "$NEOTERM_PKG_SRCDIR"
			neoterm_step_pre_configure
		fi

		# Even on continued build we might need to setup paths
		# to tools so need to run part of configure step
		cd "$NEOTERM_PKG_BUILDDIR"
		neoterm_step_configure

		if [ "$NEOTERM_CONTINUE_BUILD" == "false" ]; then
			cd "$NEOTERM_PKG_BUILDDIR"
			neoterm_step_post_configure
		fi
		cd "$NEOTERM_PKG_BUILDDIR"
		neoterm_step_make
		cd "$NEOTERM_PKG_BUILDDIR"
		neoterm_step_make_install
		cd "$NEOTERM_PKG_BUILDDIR"
		neoterm_step_post_make_install
		neoterm_step_install_service_scripts
		neoterm_step_install_license
		cd "$NEOTERM_PKG_MASSAGEDIR"
		neoterm_step_extract_into_massagedir
		neoterm_step_massage
		cd "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX_CLASSICAL"
		neoterm_step_post_massage
		cd "$NEOTERM_PKG_MASSAGEDIR"
		if [ "$NEOTERM_PACKAGE_FORMAT" = "debian" ]; then
			neoterm_step_create_debian_package
		elif [ "$NEOTERM_PACKAGE_FORMAT" = "pacman" ]; then
			neoterm_step_create_pacman_package
		else
			neoterm_error_exit "Unknown packaging format '$NEOTERM_PACKAGE_FORMAT'."
		fi
		# Saving a list of compiled packages for further work with it
		if neoterm_check_package_in_building_packages_list "$NEOTERM_PKG_NAME"; then
			sed -i "/^${NEOTERM_PKG_NAME}$/d" "$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
		fi
		neoterm_add_package_to_built_packages_list "$NEOTERM_PKG_NAME"
		neoterm_step_finish_build
	) 5< "$NEOTERM_BUILD_LOCK_FILE"
done

# Removing a file to store a list of compiled packages
if [ "$NEOTERM_BUILD_PACKAGE_CALL_DEPTH" = "0" ]; then
	rm "$NEOTERM_BUILD_PACKAGE_CALL_BUILT_PACKAGES_LIST_FILE_PATH"
	rm "$NEOTERM_BUILD_PACKAGE_CALL_BUILDING_PACKAGES_LIST_FILE_PATH"
fi
