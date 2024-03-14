neoterm_step_setup_variables() {
	: "${NEOTERM_ARCH:="aarch64"}" # arm, aarch64, i686 or x86_64.
	: "${NEOTERM_OUTPUT_DIR:="${NEOTERM_SCRIPTDIR}/output"}"
	: "${NEOTERM_DEBUG_BUILD:="false"}"
	: "${NEOTERM_FORCE_BUILD:="false"}"
	: "${NEOTERM_FORCE_BUILD_DEPENDENCIES:="false"}"
	: "${NEOTERM_INSTALL_DEPS:="false"}"
	: "${NEOTERM_MAKE_PROCESSES:="$(nproc)"}"
	: "${NEOTERM_NO_CLEAN:="false"}"
	: "${NEOTERM_PKG_API_LEVEL:="24"}"
	: "${NEOTERM_CONTINUE_BUILD:="false"}"
	: "${NEOTERM_QUIET_BUILD:="false"}"
	: "${NEOTERM_WITHOUT_DEPVERSION_BINDING:="false"}"
	: "${NEOTERM_SKIP_DEPCHECK:="false"}"
	: "${NEOTERM_GLOBAL_LIBRARY:="false"}"
	: "${NEOTERM_TOPDIR:="$HOME/.neoterm-build"}"
	: "${NEOTERM_PACMAN_PACKAGE_COMPRESSION:="xz"}"

	if [ -z "${NEOTERM_PACKAGE_FORMAT-}" ]; then
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] && [ -n "${NEOTERM_APP_PACKAGE_MANAGER-}" ]; then
			NEOTERM_PACKAGE_FORMAT="$([ "${NEOTERM_APP_PACKAGE_MANAGER-}" = "apt" ] && echo "debian" || echo "${NEOTERM_APP_PACKAGE_MANAGER-}")"
		else
			NEOTERM_PACKAGE_FORMAT="debian"
		fi
	fi

	case "${NEOTERM_PACKAGE_FORMAT-}" in
		debian) export NEOTERM_PACKAGE_MANAGER="apt";;
		pacman) export NEOTERM_PACKAGE_MANAGER="pacman";;
		*) neoterm_error_exit "Unsupported package format \"${NEOTERM_PACKAGE_FORMAT-}\". Only 'debian' and 'pacman' formats are supported";;
	esac

	# Default package library base
	if [ -z "${NEOTERM_PACKAGE_LIBRARY-}" ]; then
		export NEOTERM_PACKAGE_LIBRARY="bionic"
	fi

	if [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		export NEOTERM_PREFIX="$NEOTERM_PREFIX/glibc"
		if ! package__is_package_name_have_glibc_prefix "$NEOTERM_PKG_NAME"; then
			NEOTERM_PKG_NAME="$(package__add_prefix_glibc_to_package_name ${NEOTERM_PKG_NAME})"
		fi
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		# For on-device builds cross-compiling is not supported so we can
		# store information about built packages under $NEOTERM_TOPDIR.
		NEOTERM_BUILT_PACKAGES_DIRECTORY="$NEOTERM_TOPDIR/.built-packages"
		NEOTERM_NO_CLEAN="true"

		if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
			# On-device builds without neoterm-exec are unsupported.
			if ! grep -q "${NEOTERM_PREFIX}/lib/libneoterm-exec.so" <<< "${LD_PRELOAD-x}"; then
				neoterm_error_exit "On-device builds without neoterm-exec are not supported."
			fi
		fi
	else
		NEOTERM_BUILT_PACKAGES_DIRECTORY="/data/data/.built-packages"
	fi

	# NEOTERM_PKG_MAINTAINER should be explicitly set in build.sh of the package.
	: "${NEOTERM_PKG_MAINTAINER:="default"}"

	if [ "x86_64" = "$NEOTERM_ARCH" ] || [ "aarch64" = "$NEOTERM_ARCH" ]; then
		NEOTERM_ARCH_BITS=64
	else
		NEOTERM_ARCH_BITS=32
	fi

	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		NEOTERM_HOST_PLATFORM="${NEOTERM_ARCH}-linux-android"
	else
		NEOTERM_HOST_PLATFORM="${NEOTERM_ARCH}-linux-gnu"
	fi
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		NEOTERM_HOST_PLATFORM="${NEOTERM_HOST_PLATFORM}eabi"
		if [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
			NEOTERM_HOST_PLATFORM="${NEOTERM_HOST_PLATFORM}hf"
		fi
	fi

	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ] && [ ! -d "$NDK" ]; then
			neoterm_error_exit 'NDK not pointing at a directory!'
		fi

		if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ] && ! grep -s -q "Pkg.Revision = $NEOTERM_NDK_VERSION_NUM" "$NDK/source.properties"; then
			neoterm_error_exit "Wrong NDK version - we need $NEOTERM_NDK_VERSION"
		fi
	elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
			if [ -n "${LD_PRELOAD-}" ]; then
				unset LD_PRELOAD
			fi
			if ! $(echo "$PATH" | grep -q "^$NEOTERM_PREFIX/bin"); then
				if [ -d "${NEOTERM_PREFIX}/bin" ]; then
					export PATH="${NEOTERM_PREFIX}/bin:${PATH}"
				else
					neoterm_error_exit "Glibc components are not installed, run './scripts/setup-neoterm-glibc.sh'"
				fi
			fi
		else
			if [ ! -d "${CGCT_DIR}/${NEOTERM_ARCH}/bin" ]; then
				neoterm_error_exit "The cgct tools were not found, run './scripts/setup-cgct.sh'"
			fi
		fi
	fi

	# The build tuple that may be given to --build configure flag:
	NEOTERM_BUILD_TUPLE=$(sh "$NEOTERM_SCRIPTDIR/scripts/config.guess")

	# We do not put all of build-tools/$NEOTERM_ANDROID_BUILD_TOOLS_VERSION/ into PATH
	# to avoid stuff like arm-linux-androideabi-ld there to conflict with ones from
	# the standalone toolchain.
	NEOTERM_D8=$ANDROID_HOME/build-tools/$NEOTERM_ANDROID_BUILD_TOOLS_VERSION/d8

	NEOTERM_COMMON_CACHEDIR="$NEOTERM_TOPDIR/_cache"
	NEOTERM_ELF_CLEANER=$NEOTERM_COMMON_CACHEDIR/neoterm-elf-cleaner

	export prefix=${NEOTERM_PREFIX}
	export PREFIX=${NEOTERM_PREFIX}

	# Explicitly export in case the default was set.
	export NEOTERM_ARCH=${NEOTERM_ARCH}

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		# In "offline" mode store/pick cache from directory with
		# build.sh script.
		NEOTERM_PKG_CACHEDIR=$NEOTERM_PKG_BUILDER_DIR/cache
	else
		NEOTERM_PKG_CACHEDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/cache
	fi
	NEOTERM_CMAKE_BUILD=Ninja # Which cmake generator to use
	NEOTERM_PKG_ANTI_BUILD_DEPENDS="" # This cannot be used to "resolve" circular dependencies
	NEOTERM_PKG_BREAKS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	NEOTERM_PKG_BUILDDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/build
	NEOTERM_PKG_BUILD_DEPENDS=""
	NEOTERM_PKG_BUILD_IN_SRC=false
	NEOTERM_PKG_CONFFILES=""
	NEOTERM_PKG_CONFLICTS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts
	NEOTERM_PKG_DEPENDS=""
	NEOTERM_PKG_DESCRIPTION="FIXME:Add description"
	NEOTERM_PKG_DISABLE_GIR=false # neoterm_setup_gir
	NEOTERM_PKG_ENABLE_CLANG16_PORTING=true
	NEOTERM_PKG_ESSENTIAL=false
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=""
	NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS=""
	NEOTERM_PKG_EXTRA_MAKE_ARGS=""
	NEOTERM_PKG_FORCE_CMAKE=false # if the package has autotools as well as cmake, then set this to prefer cmake
	NEOTERM_PKG_GIT_BRANCH="" # branch defaults to 'v$NEOTERM_PKG_VERSION' unless this variable is defined
	NEOTERM_PKG_GO_USE_OLDER=false # set to true to use the older supported release of Go.
	NEOTERM_PKG_HAS_DEBUG=true # set to false if debug build doesn't exist or doesn't work, for example for python based packages
	NEOTERM_PKG_HOMEPAGE=""
	NEOTERM_PKG_HOSTBUILD=false # Set if a host build should be done in NEOTERM_PKG_HOSTBUILD_DIR:
	NEOTERM_PKG_HOSTBUILD_DIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/host-build
	NEOTERM_PKG_LICENSE_FILE="" # Relative path from $NEOTERM_PKG_SRCDIR to LICENSE file. It is installed to $NEOTERM_PREFIX/share/$NEOTERM_PKG_NAME.
	NEOTERM_PKG_MASSAGEDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/massage
	NEOTERM_PKG_METAPACKAGE=false
	NEOTERM_PKG_NO_ELF_CLEANER=false # set this to true to disable running of neoterm-elf-cleaner on built binaries
	NEOTERM_PKG_NO_SHEBANG_FIX=false # if true, skip fixing shebang accordingly to NEOTERM_PREFIX
	NEOTERM_PKG_NO_SHEBANG_FIX_FILES="" # files to be excluded from fixing shebang
	NEOTERM_PKG_NO_STRIP=false # set this to true to disable stripping binaries
	NEOTERM_PKG_NO_STATICSPLIT=false
	NEOTERM_PKG_STATICSPLIT_EXTRA_PATTERNS=""
	NEOTERM_PKG_PACKAGEDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/package
	NEOTERM_PKG_PLATFORM_INDEPENDENT=false
	NEOTERM_PKG_PRE_DEPENDS=""
	NEOTERM_PKG_PROVIDES="" #https://www.debian.org/doc/debian-policy/#virtual-packages-provides
	NEOTERM_PKG_RECOMMENDS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	NEOTERM_PKG_REPLACES=""
	NEOTERM_PKG_REVISION="0" # http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
	NEOTERM_PKG_RM_AFTER_INSTALL=""
	NEOTERM_PKG_SHA256=""
	NEOTERM_PKG_SRCDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/src
	NEOTERM_PKG_SUGGESTS=""
	NEOTERM_PKG_TMPDIR=$NEOTERM_TOPDIR/$NEOTERM_PKG_NAME/tmp
	NEOTERM_PKG_SERVICE_SCRIPT=() # Fill with entries like: ("daemon name" 'script to execute'). Script is echoed with -e so can contain \n for multiple lines
	NEOTERM_PKG_GROUPS="" # https://wiki.archlinux.org/title/Pacman#Installing_package_groups
	NEOTERM_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=false # if the package does not support compilation on a device, then this package should not be compiled on devices
	NEOTERM_PKG_SETUP_PYTHON=false # setting python to compile a package
	NEOTERM_PYTHON_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION) # get the latest version of python
	NEOTERM_PKG_PYTHON_TARGET_DEPS="" # python modules to be installed via pip3
	NEOTERM_PKG_PYTHON_BUILD_DEPS="" # python modules to be installed via build-pip
	NEOTERM_PKG_PYTHON_COMMON_DEPS="" # python modules to be installed via pip3 or build-pip
	NEOTERM_PYTHON_CROSSENV_PREFIX="$NEOTERM_TOPDIR/python-crossenv-prefix-$NEOTERM_ARCH" # python modules dependency location (only used in non-devices)
	NEOTERM_PYTHON_HOME=$NEOTERM_PREFIX/lib/python${NEOTERM_PYTHON_VERSION} # location of python libraries
	NEOTERM_PKG_MESON_NATIVE=false
	NEOTERM_PKG_CMAKE_CROSSCOMPILING=true

	unset CFLAGS CPPFLAGS LDFLAGS CXXFLAGS
	unset NEOTERM_MESON_ENABLE_SOVERSION # setenv to enable SOVERSION suffix for shared libs built with Meson
}
