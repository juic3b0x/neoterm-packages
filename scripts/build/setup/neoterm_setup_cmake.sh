neoterm_setup_cmake() {
	local NEOTERM_CMAKE_MAJORVESION=3.28
	local NEOTERM_CMAKE_MINORVERSION=3
	local NEOTERM_CMAKE_VERSION=$NEOTERM_CMAKE_MAJORVESION.$NEOTERM_CMAKE_MINORVERSION
	local NEOTERM_CMAKE_TARNAME=cmake-${NEOTERM_CMAKE_VERSION}-linux-x86_64.tar.gz
	local NEOTERM_CMAKE_TARFILE=$NEOTERM_PKG_TMPDIR/$NEOTERM_CMAKE_TARNAME
	local NEOTERM_CMAKE_FOLDER
	if [ "$NEOTERM_PACKAGE_LIBRARY" = "bionic" ]; then
		local NEOTERM_CMAKE_NAME="cmake"
	elif [ "$NEOTERM_PACKAGE_LIBRARY" = "glibc" ]; then
		local NEOTERM_CMAKE_NAME="cmake-glibc"
	fi

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		NEOTERM_CMAKE_FOLDER=$NEOTERM_SCRIPTDIR/build-tools/cmake-$NEOTERM_CMAKE_VERSION
	else
		NEOTERM_CMAKE_FOLDER=$NEOTERM_COMMON_CACHEDIR/cmake-$NEOTERM_CMAKE_VERSION
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$NEOTERM_CMAKE_FOLDER" ]; then
			neoterm_download https://github.com/Kitware/CMake/releases/download/v${NEOTERM_CMAKE_VERSION}/$NEOTERM_CMAKE_TARNAME \
				"$NEOTERM_CMAKE_TARFILE" \
				804d231460ab3c8b556a42d2660af4ac7a0e21c98a7f8ee3318a74b4a9a187a6
			rm -Rf "$NEOTERM_PKG_TMPDIR/cmake-${NEOTERM_CMAKE_VERSION}-linux-x86_64"
			tar xf "$NEOTERM_CMAKE_TARFILE" -C "$NEOTERM_PKG_TMPDIR"
			shopt -s nullglob
			local f
			for f in "$NEOTERM_SCRIPTDIR"/scripts/build/setup/cmake-*.patch; do
				echo "[${FUNCNAME[0]}]: Applying $(basename "$f")"
				patch --silent -p1 -d "$NEOTERM_PKG_TMPDIR/cmake-${NEOTERM_CMAKE_VERSION}-linux-x86_64" < "$f"
			done
			shopt -u nullglob
			mv "$NEOTERM_PKG_TMPDIR/cmake-${NEOTERM_CMAKE_VERSION}-linux-x86_64" \
				"$NEOTERM_CMAKE_FOLDER"
		fi

		export PATH=$NEOTERM_CMAKE_FOLDER/bin:$PATH
	else
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' $NEOTERM_CMAKE_NAME 2>/dev/null)" != "installed" ]] ||
                   [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q $NEOTERM_CMAKE_NAME 2>/dev/null)" ]]; then
			echo "Package '$NEOTERM_CMAKE_NAME' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install $NEOTERM_CMAKE_NAME"
			echo
			echo "  pacman -S $NEOTERM_CMAKE_NAME"
			echo
			exit 1
		fi
	fi

	export CMAKE_INSTALL_ALWAYS=1
}
