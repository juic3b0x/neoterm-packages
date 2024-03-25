neoterm_setup_crystal() {
	local NEOTERM_CRYSTAL_VERSION=1.10.1
	local NEOTERM_CRYSTAL_SHA256=bd74b24cac07f6227ee0874c6d9264688ca4388a0a8687493e4ca04285454912
	local NEOTERM_CRYSTAL_TARNAME=crystal-${NEOTERM_CRYSTAL_VERSION}-1-linux-x86_64-bundled.tar.gz
	local NEOTERM_CRYSTAL_TARFILE=$NEOTERM_PKG_TMPDIR/crystal-$NEOTERM_CRYSTAL_VERSION.tar.gz
	local NEOTERM_CRYSTAL_FOLDER

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		NEOTERM_CRYSTAL_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/crystal-${NEOTERM_CRYSTAL_VERSION}
	else
		NEOTERM_CRYSTAL_FOLDER=${NEOTERM_COMMON_CACHEDIR}/crystal-${NEOTERM_CRYSTAL_VERSION}
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$NEOTERM_CRYSTAL_FOLDER" ]; then
			mkdir -p "$NEOTERM_CRYSTAL_FOLDER"
			neoterm_download "https://github.com/crystal-lang/crystal/releases/download/$NEOTERM_CRYSTAL_VERSION/$NEOTERM_CRYSTAL_TARNAME" \
				"$NEOTERM_CRYSTAL_TARFILE" \
				"$NEOTERM_CRYSTAL_SHA256"
			tar xf "$NEOTERM_CRYSTAL_TARFILE" --strip-components=2 -C "$NEOTERM_CRYSTAL_FOLDER"
		fi
		export PATH=$NEOTERM_CRYSTAL_FOLDER/bin:$PATH
	else
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' crystal 2>/dev/null)" != "installed" ]] ||
                   [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q crystal 2>/dev/null)" ]]; then
			echo "Package 'crystal' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install crystal"
			echo
			echo "  pacman -S crystal"
			echo
			exit 1
		fi
	fi
}
