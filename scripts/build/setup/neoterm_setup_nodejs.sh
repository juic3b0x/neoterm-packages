neoterm_setup_nodejs() {
	# Use LTS version for now
	local NODEJS_VERSION=18.16.1
	local NODEJS_FOLDER

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		NODEJS_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/nodejs-${NODEJS_VERSION}
	else
		NODEJS_FOLDER=${NEOTERM_COMMON_CACHEDIR}/nodejs-$NODEJS_VERSION
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$NODEJS_FOLDER/bin/node" ]; then
			mkdir -p "$NODEJS_FOLDER"
			local NODEJS_TAR_FILE=$NEOTERM_PKG_TMPDIR/nodejs-$NODEJS_VERSION.tar.xz
			neoterm_download https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz \
				"$NODEJS_TAR_FILE" \
				ecfe263dbd9c239f37b5adca823b60be1bb57feabbccd25db785e647ebc5ff5e
			tar -xf "$NODEJS_TAR_FILE" -C "$NODEJS_FOLDER" --strip-components=1
		fi
		export PATH=$NODEJS_FOLDER/bin:$PATH
	else
		local NODEJS_PKG_VERSION=$(bash -c ". $NEOTERM_SCRIPTDIR/packages/nodejs/build.sh; echo \$NEOTERM_PKG_VERSION")
		if ([ ! -e "$NEOTERM_BUILT_PACKAGES_DIRECTORY/nodejs" ] ||
		    [ "$(cat "$NEOTERM_BUILT_PACKAGES_DIRECTORY/nodejs")" != "$NODEJS_PKG_VERSION" ]) &&
		   ([[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' nodejs 2>/dev/null)" != "installed" ]] ||
		    [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q nodejs 2>/dev/null)" ]]); then
			echo "Package 'nodejs' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install nodejs"
			echo
			echo "  pacman -S nodejs"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh nodejs"
			echo
			exit 1
		fi
	fi
}
