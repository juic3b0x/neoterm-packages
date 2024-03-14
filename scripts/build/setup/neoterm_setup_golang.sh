# Utility function for golang-using packages to setup a go toolchain.
neoterm_setup_golang() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local NEOTERM_GO_VERSION=go1.21.6
		local NEOTERM_GO_SHA256=3f934f40ac360b9c01f616a9aa1796d227d8b0328bf64cb045c7b8c4ee9caea4
		if [ "$NEOTERM_PKG_GO_USE_OLDER" = "true" ]; then
			NEOTERM_GO_VERSION=go1.20.13
			NEOTERM_GO_SHA256=9a9d3dcae2b6a638b1f2e9bd4db08ffb39c10e55d9696914002742d90f0047b5
		fi
		local NEOTERM_GO_PLATFORM=linux-amd64

		local NEOTERM_BUILDGO_FOLDER
		if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
			NEOTERM_BUILDGO_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/${NEOTERM_GO_VERSION}
		else
			NEOTERM_BUILDGO_FOLDER=${NEOTERM_COMMON_CACHEDIR}/${NEOTERM_GO_VERSION}
		fi

		export GOROOT=$NEOTERM_BUILDGO_FOLDER
		export PATH=${GOROOT}/bin:${PATH}

		if [ -d "$NEOTERM_BUILDGO_FOLDER" ]; then return; fi

		local NEOTERM_BUILDGO_TAR=$NEOTERM_COMMON_CACHEDIR/${NEOTERM_GO_VERSION}.${NEOTERM_GO_PLATFORM}.tar.gz
		rm -Rf "$NEOTERM_COMMON_CACHEDIR/go" "$NEOTERM_BUILDGO_FOLDER"
		neoterm_download https://golang.org/dl/${NEOTERM_GO_VERSION}.${NEOTERM_GO_PLATFORM}.tar.gz \
			"$NEOTERM_BUILDGO_TAR" \
			"$NEOTERM_GO_SHA256"

		( cd "$NEOTERM_COMMON_CACHEDIR"; tar xf "$NEOTERM_BUILDGO_TAR"; mv go "$NEOTERM_BUILDGO_FOLDER"; rm "$NEOTERM_BUILDGO_TAR" )

		if [ "$NEOTERM_PKG_GO_USE_OLDER" = "false" ]; then
			( cd "$NEOTERM_BUILDGO_FOLDER"; . ${NEOTERM_SCRIPTDIR}/packages/golang/fix-hardcoded-etc-resolv-conf.sh )
		fi
	else
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' golang 2>/dev/null)" != "installed" ]] ||
		   [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q golang 2>/dev/null)" ]]; then
			echo "Package 'golang' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install golang"
			echo
			echo "  pacman -S golang"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh golang"
			echo
			exit 1
		fi

		export GOROOT="$NEOTERM_PREFIX/lib/go"
	fi
}
