neoterm_step_start_build() {
	# shellcheck source=/dev/null
	source "$NEOTERM_PKG_BUILDER_SCRIPT"
	# Path to hostbuild marker, for use if package has hostbuild step
	NEOTERM_HOSTBUILD_MARKER="$NEOTERM_PKG_HOSTBUILD_DIR/NEOTERM_BUILT_FOR_$NEOTERM_PKG_VERSION"

	if [ "$NEOTERM_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage has no sources and therefore platform-independent.
		NEOTERM_PKG_SKIP_SRC_EXTRACT=true
		NEOTERM_PKG_PLATFORM_INDEPENDENT=true
	fi

	if [ -n "${NEOTERM_PKG_BLACKLISTED_ARCHES:=""}" ] && [ "$NEOTERM_PKG_BLACKLISTED_ARCHES" != "${NEOTERM_PKG_BLACKLISTED_ARCHES/$NEOTERM_ARCH/}" ]; then
		echo "Skipping building $NEOTERM_PKG_NAME for arch $NEOTERM_ARCH"
		exit 0
	fi

	if [ -n "$NEOTERM_PKG_PYTHON_COMMON_DEPS" ] || [[ "$NEOTERM_ON_DEVICE_BUILD" = "false" && -n "$NEOTERM_PKG_PYTHON_BUILD_DEPS" ]] || [[ "$NEOTERM_ON_DEVICE_BUILD" = "true" && -n "$NEOTERM_PKG_PYTHON_TARGET_DEPS" ]]; then
		# Enable python setting
		NEOTERM_PKG_SETUP_PYTHON=true
	fi

	NEOTERM_PKG_FULLVERSION=$NEOTERM_PKG_VERSION
	if [ "$NEOTERM_PKG_REVISION" != "0" ] || [ "$NEOTERM_PKG_FULLVERSION" != "${NEOTERM_PKG_FULLVERSION/-/}" ]; then
		# "0" is the default revision, so only include it if the upstream versions contains "-" itself
		NEOTERM_PKG_FULLVERSION+="-$NEOTERM_PKG_REVISION"
	fi
	# full format version for pacman
	local NEOTERM_PKG_VERSION_EDITED=${NEOTERM_PKG_VERSION//-/.}
	local INCORRECT_SYMBOLS=$(echo $NEOTERM_PKG_VERSION_EDITED | grep -o '[0-9][a-z]')
	if [ -n "$INCORRECT_SYMBOLS" ]; then
		local NEOTERM_PKG_VERSION_EDITED=${NEOTERM_PKG_VERSION_EDITED//${INCORRECT_SYMBOLS:0:1}${INCORRECT_SYMBOLS:1:1}/${INCORRECT_SYMBOLS:0:1}.${INCORRECT_SYMBOLS:1:1}}
	fi
	NEOTERM_PKG_FULLVERSION_FOR_PACMAN="${NEOTERM_PKG_VERSION_EDITED}"
	if [ -n "$NEOTERM_PKG_REVISION" ]; then
		NEOTERM_PKG_FULLVERSION_FOR_PACMAN+="-${NEOTERM_PKG_REVISION}"
	else
		NEOTERM_PKG_FULLVERSION_FOR_PACMAN+="-0"
	fi

	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		if [ "$NEOTERM_PKG_HAS_DEBUG" = "true" ]; then
			DEBUG="-dbg"
		else
			echo "Skipping building debug build for $NEOTERM_PKG_NAME"
			exit 0
		fi
	else
		DEBUG=""
	fi

	if [ "$NEOTERM_DEBUG_BUILD" = "false" ] && [ "$NEOTERM_FORCE_BUILD" = "false" ]; then
		if [ -e "$NEOTERM_BUILT_PACKAGES_DIRECTORY/$NEOTERM_PKG_NAME" ] &&
			[ "$(cat "$NEOTERM_BUILT_PACKAGES_DIRECTORY/$NEOTERM_PKG_NAME")" = "$NEOTERM_PKG_FULLVERSION" ]; then
			echo "$NEOTERM_PKG_NAME@$NEOTERM_PKG_FULLVERSION built - skipping (rm $NEOTERM_BUILT_PACKAGES_DIRECTORY/$NEOTERM_PKG_NAME to force rebuild)"
			exit 0
		elif [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] &&
			([[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status} ${Version}\n' "$NEOTERM_PKG_NAME" 2>/dev/null)" = "installed $NEOTERM_PKG_FULLVERSION" ]] ||
			 [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && "$(pacman -Q $NEOTERM_PKG_NAME 2>/dev/null)" = "$NEOTERM_PKG_NAME $NEOTERM_PKG_FULLVERSION_FOR_PACMAN" ]]); then
			echo "$NEOTERM_PKG_NAME@$NEOTERM_PKG_FULLVERSION installed - skipping"
			exit 0
		fi
	fi

	echo "neoterm - building $NEOTERM_PKG_NAME for arch $NEOTERM_ARCH..."
	test -t 1 && printf "\033]0;%s...\007" "$NEOTERM_PKG_NAME"

	# Avoid exporting PKG_CONFIG_LIBDIR until after neoterm_step_host_build.
	export NEOTERM_PKG_CONFIG_LIBDIR=$NEOTERM_PREFIX/lib/pkgconfig:$NEOTERM_PREFIX/share/pkgconfig

	if [ "$NEOTERM_PKG_BUILD_IN_SRC" = "true" ]; then
		echo "Building in src due to NEOTERM_PKG_BUILD_IN_SRC being set to true" > "$NEOTERM_PKG_BUILDDIR/BUILDING_IN_SRC.txt"
		NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_SRCDIR
	fi

	if [ "$NEOTERM_CONTINUE_BUILD" == "true" ]; then
		# If the package has a hostbuild step, verify that it has been built
		if [ "$NEOTERM_PKG_HOSTBUILD" == "true" ] && [ ! -f "$NEOTERM_HOSTBUILD_MARKER" ]; then
			neoterm_error_exit "Cannot continue this build, hostbuilt tools are missing"
		fi

		# The rest in this function can be skipped when doing
		# a continued build
		return
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ] && [ "$NEOTERM_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED" = "true" ]; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not available for on-device builds."
	fi

	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
			case "$NEOTERM_APP_PACKAGE_MANAGER" in
				"apt") apt install -y neoterm-elf-cleaner;;
				"pacman") pacman -S neoterm-elf-cleaner --needed --noconfirm;;
			esac
			NEOTERM_ELF_CLEANER="$(command -v neoterm-elf-cleaner)"
		else
			local NEOTERM_ELF_CLEANER_VERSION
			NEOTERM_ELF_CLEANER_VERSION=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/neoterm-elf-cleaner/build.sh; echo \$NEOTERM_PKG_VERSION")
			neoterm_download \
				"https://repo.theworkjoy.com/neoterm-elf-cleaner" \
				"$NEOTERM_ELF_CLEANER" \
				265fad74a346195579bf6c5c07a9b3e521cb7eb982f64608fee5e033040f83ea
			chmod u+x "$NEOTERM_ELF_CLEANER"
		fi

		# Some packages search for libutil, libpthread and librt even
		# though this functionality is provided by libc.  Provide
		# library stubs so that such configure checks succeed.
		mkdir -p "$NEOTERM_PREFIX/lib"
		for lib in libutil.so libpthread.so librt.so; do
			if [ ! -f $NEOTERM_PREFIX/lib/$lib ]; then
				echo 'INPUT(-lc)' > $NEOTERM_PREFIX/lib/$lib
			fi
		done
	fi
}
