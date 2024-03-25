neoterm_setup_cargo_c() {
	local NEOTERM_CARGO_C_VERSION=0.9.20
	local NEOTERM_CARGO_C_SHA256=1a53a2d506b5ba402ebe0291b7e1ef00bc74b1ff5ca4782723098f83d64159a3
	local NEOTERM_CARGO_C_TARNAME=cargo-c-x86_64-unknown-linux-musl.tar.gz
	local NEOTERM_CARGO_C_TARFILE=$NEOTERM_PKG_TMPDIR/$NEOTERM_CARGO_C_TARNAME
	local NEOTERM_CARGO_C_FOLDER

	if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
		NEOTERM_CARGO_C_FOLDER=$NEOTERM_SCRIPTDIR/build-tools/cargo-c-$NEOTERM_CARGO_C_VERSION
	else
		NEOTERM_CARGO_C_FOLDER=$NEOTERM_COMMON_CACHEDIR/cargo-c-$NEOTERM_CARGO_C_VERSION
	fi

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "true" ]; then
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' cargo-c 2>/dev/null)" != "installed" ]] ||
			[[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q cargo-c 2>/dev/null)" ]]; then
			echo "Package 'cargo-c' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install cargo-c"
			echo
			echo "  pacman -S cargo-c"
			echo
			exit 1
		fi
		return
	fi

	if [ ! -d "$NEOTERM_CARGO_C_FOLDER" ]; then
		neoterm_download https://github.com/lu-zero/cargo-c/releases/download/v$NEOTERM_CARGO_C_VERSION/$NEOTERM_CARGO_C_TARNAME \
			"$NEOTERM_CARGO_C_TARFILE" \
			"$NEOTERM_CARGO_C_SHA256"
		rm -Rf "$NEOTERM_CARGO_C_FOLDER"
		mkdir -p "$NEOTERM_CARGO_C_FOLDER"
		tar xf "$NEOTERM_CARGO_C_TARFILE" -C "$NEOTERM_CARGO_C_FOLDER"
	fi

	export PATH=$NEOTERM_CARGO_C_FOLDER:$PATH
}
