# shellcheck shell=bash
neoterm_setup_cabal() {
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		local NEOTERM_CABAL_VERSION=3.8.1.0
		local NEOTERM_CABAL_TAR="${NEOTERM_COMMON_CACHEDIR}/cabal-${NEOTERM_CABAL_VERSION}.tar.xz"

		local NEOTERM_CABAL_RUNTIME_FOLDER

		if [[ "${NEOTERM_PACKAGES_OFFLINE-false}" == "true" ]]; then
			NEOTERM_CABAL_RUNTIME_FOLDER="${NEOTERM_SCRIPTDIR}/build-tools/cabal-${NEOTERM_CABAL_VERSION}-runtime"
		else
			NEOTERM_CABAL_RUNTIME_FOLDER="${NEOTERM_COMMON_CACHEDIR}/cabal-${NEOTERM_CABAL_VERSION}-runtime"
		fi

		export PATH="${NEOTERM_CABAL_RUNTIME_FOLDER}:${PATH}"

		[[ -d "${NEOTERM_CABAL_RUNTIME_FOLDER}" ]] && return

		neoterm_download "https://github.com/MrAdityaAlok/ghc-cross-tools/releases/download/cabal-install-v${NEOTERM_CABAL_VERSION}/cabal-install-${NEOTERM_CABAL_VERSION}.tar.xz" \
			"${NEOTERM_CABAL_TAR}" \
			6a8c3c04414cbf1c805d2c1c63a09bdc879a7babd9ac1143370bdb6f6bf5a927

		mkdir -p "${NEOTERM_CABAL_RUNTIME_FOLDER}"
		tar xf "${NEOTERM_CABAL_TAR}" -C "${NEOTERM_CABAL_RUNTIME_FOLDER}"
		rm "${NEOTERM_CABAL_TAR}"

		cabal update

	else
		if [[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' cabal-install 2>/dev/null)" != "installed" ||
			[[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "pacman" ]] && ! "$(pacman -Q cabal-install 2>/dev/null)"; then
			echo "Package 'cabal-install' is not installed."
			exit 1
		fi
	fi
}
