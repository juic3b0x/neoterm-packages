# shellcheck shell=bash
# Utility function to setup a GHC toolchain.
neoterm_setup_ghc() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local NEOTERM_GHC_VERSION=8.10.7
		local NEOTERM_GHC_TEMP_FOLDER="${NEOTERM_COMMON_CACHEDIR}/ghc-${NEOTERM_GHC_VERSION}"
		local NEOTERM_GHC_TAR="${NEOTERM_GHC_TEMP_FOLDER}.tar.xz"
		local NEOTERM_GHC_RUNTIME_FOLDER

		if [ "${NEOTERM_PACKAGES_OFFLINE-false}" = "true" ]; then
			NEOTERM_GHC_RUNTIME_FOLDER="${NEOTERM_SCRIPTDIR}/build-tools/ghc-${NEOTERM_GHC_VERSION}-runtime"
		else
			NEOTERM_GHC_RUNTIME_FOLDER="${NEOTERM_COMMON_CACHEDIR}/ghc-${NEOTERM_GHC_VERSION}-runtime"
		fi

		export PATH="$NEOTERM_GHC_RUNTIME_FOLDER/bin:$PATH"

		[ -d "$NEOTERM_GHC_RUNTIME_FOLDER" ] && return

		neoterm_download "https://downloads.haskell.org/~ghc/${NEOTERM_GHC_VERSION}/ghc-${NEOTERM_GHC_VERSION}-x86_64-deb10-linux.tar.xz" \
			"$NEOTERM_GHC_TAR" \
			a13719bca87a0d3ac0c7d4157a4e60887009a7f1a8dbe95c4759ec413e086d30

		rm -Rf "$NEOTERM_GHC_TEMP_FOLDER"
		tar xf "$NEOTERM_GHC_TAR" -C "$NEOTERM_COMMON_CACHEDIR"

		(
			set -e
			unset CC CXX CFLAGS CXXFLAGS CPPFLAGS LDFLAGS AR AS CPP LD RANLIB READELF STRIP
			cd "$NEOTERM_GHC_TEMP_FOLDER"
			./configure --prefix="$NEOTERM_GHC_RUNTIME_FOLDER"
			make install
		)

		# Cabal passes a host string to the libraries' configure scripts that isn't valid.
		# After this patch we need to always pass --configure-option=--host=${NEOTERM_HOST_PLATFORM}
		# to Setup.hs configure.
		(
			CABAL_VERSION="3.6.2.0"
			CABAL_TEMP_FOLDER="$(mktemp -d -t cabal-"${CABAL_VERSION}".XXXXXX)"
			CABAL_TAR="${CABAL_TEMP_FOLDER}/cabal-${CABAL_VERSION}.tar.gz"

			neoterm_download \
				https://hackage.haskell.org/package/Cabal-"${CABAL_VERSION}"/Cabal-"${CABAL_VERSION}".tar.gz \
				"${CABAL_TAR}" \
				9e903d06a7fb0893c6f303199e737a7d555fbb5e309be8bcc782b4eb2717bc42

			tar xf "${CABAL_TAR}" -C "${CABAL_TEMP_FOLDER}" --strip-components=1

			cd "${CABAL_TEMP_FOLDER}"

			sed -i 's/maybeHostFlag = i/maybeHostFlag = [] -- i/' src/Distribution/Simple.hs

			runhaskell Setup configure --prefix="${NEOTERM_GHC_RUNTIME_FOLDER}"
			runhaskell Setup build
			runhaskell Setup install
			ghc-pkg recache
		)
		rm -Rf "$NEOTERM_GHC_TEMP_FOLDER" "$NEOTERM_GHC_TAR"
	else
		if [[ "$NEOTERM_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' ghc 2>/dev/null)" != "installed" ]] ||
			[[ "$NEOTERM_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q ghc 2>/dev/null)" ]]; then
			echo "Package 'ghc' is not installed."
			exit 1
		fi
	fi
}
