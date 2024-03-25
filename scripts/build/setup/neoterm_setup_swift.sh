neoterm_setup_swift() {
	local SWIFT_TRIPLE=${NEOTERM_HOST_PLATFORM/-/-unknown-}$NEOTERM_PKG_API_LEVEL
	export SWIFT_TARGET_TRIPLE=${SWIFT_TRIPLE/arm-/armv7-}

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local NEOTERM_SWIFT_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/swift/build.sh; echo $NEOTERM_PKG_VERSION)
		local SWIFT_RELEASE=$(. $NEOTERM_SCRIPTDIR/packages/swift/build.sh; echo $SWIFT_RELEASE)
		local SWIFT_BIN="swift-$NEOTERM_SWIFT_VERSION-$SWIFT_RELEASE-ubuntu22.04"
		local SWIFT_FOLDER

		if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
			SWIFT_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/${SWIFT_BIN}
		else
			SWIFT_FOLDER=${NEOTERM_COMMON_CACHEDIR}/${SWIFT_BIN}
		fi

		if [ ! -d "$SWIFT_FOLDER" ]; then
			local SWIFT_TAR=$NEOTERM_PKG_TMPDIR/${SWIFT_BIN}.tar.gz
			neoterm_download \
				https://download.swift.org/swift-$NEOTERM_SWIFT_VERSION-release/ubuntu2204/swift-$NEOTERM_SWIFT_VERSION-$SWIFT_RELEASE/$SWIFT_BIN.tar.gz \
				$SWIFT_TAR \
				ded6983736ab5e15862e5a924ebd5c4f9459802317eff719936442c832698d06

			(cd $NEOTERM_PKG_TMPDIR ; tar xf $SWIFT_TAR ; mv $SWIFT_BIN $SWIFT_FOLDER; rm $SWIFT_TAR)
		fi
		export SWIFT_BINDIR="$SWIFT_FOLDER/usr/bin"
		export SWIFT_CROSSCOMPILE_CONFIG="$SWIFT_FOLDER/usr/android-$NEOTERM_ARCH.json"
		if [ ! -z ${NEOTERM_STANDALONE_TOOLCHAIN+x} ]; then
			local MULTILIB_DIR="$NEOTERM_ARCH-linux-android"
			test $NEOTERM_ARCH == 'arm' && MULTILIB_DIR+="eabi"
			cat <<- EOF > $SWIFT_CROSSCOMPILE_CONFIG
			{ "version": 1,
			"target": "${SWIFT_TARGET_TRIPLE}",
			"toolchain-bin-dir": "${SWIFT_BINDIR}",
			"sdk": "${NEOTERM_STANDALONE_TOOLCHAIN}/sysroot",
			"extra-cc-flags": [ "-fPIC" ],
			"extra-swiftc-flags": [ "-resource-dir", "${NEOTERM_PREFIX}/lib/swift",
			   "-Xcc", "-I${NEOTERM_PREFIX}/include",
			   "-L${NEOTERM_PREFIX}/opt/ndk-multilib/$MULTILIB_DIR/lib", "-L${NEOTERM_PREFIX}/lib",
			   "-tools-directory", "${NEOTERM_STANDALONE_TOOLCHAIN}/bin", ],
			"extra-cpp-flags": [ "-lstdc++" ] }
			EOF
		fi
	else
		if [[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' swift 2>/dev/null)" != "installed" ]] ||
		   [[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "pacman" && ! "$(pacman -Q swift 2>/dev/null)" ]]; then
			echo "Package 'swift' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install swift"
			echo
			echo "  pacman -S swift"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh swift"
			echo
			exit 1
		fi
		export SWIFT_BINDIR="$NEOTERM_PREFIX/bin"
	fi
}
