# shellcheck shell=bash
# Utility script to setup jailbreak-cabal script. It is used by haskell build system to remove version
# constraints in cabal files.
neoterm_setup_jailbreak_cabal() {
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		local NEOTERM_JAILBREAK_VERSION=1.3.5
		local NEOTERM_JAILBREAK_TAR="${NEOTERM_COMMON_CACHEDIR}/jailbreak-cabal-${NEOTERM_JAILBREAK_VERSION}.tar.gz"
		local NEOTERM_JAILBREAK_RUNTIME_FOLDER

		if [[ "${NEOTERM_PACKAGES_OFFLINE-false}" == "true" ]]; then
			NEOTERM_JAILBREAK_RUNTIME_FOLDER="${NEOTERM_SCRIPTDIR}/build-tools/jailbreak-cabal-${NEOTERM_JAILBREAK_VERSION}-runtime"
		else
			NEOTERM_JAILBREAK_RUNTIME_FOLDER="${NEOTERM_COMMON_CACHEDIR}/jailbreak-cabal-${NEOTERM_JAILBREAK_VERSION}-runtime"
		fi

		export PATH="${NEOTERM_JAILBREAK_RUNTIME_FOLDER}:${PATH}"

		[[ -d "${NEOTERM_JAILBREAK_RUNTIME_FOLDER}" ]] && return

		neoterm_download "https://github.com/MrAdityaAlok/ghc-cross-tools/releases/download/jailbreak-cabal-v${NEOTERM_JAILBREAK_VERSION}/jailbreak-cabal-${NEOTERM_JAILBREAK_VERSION}.tar.xz" \
			"${NEOTERM_JAILBREAK_TAR}" \
			"8d1a8b8fadf48f4abf42da025d5cf843bd68e1b3c18ecacdc0cd0c9bd470c64e"

		mkdir -p "${NEOTERM_JAILBREAK_RUNTIME_FOLDER}"
		tar xf "${NEOTERM_JAILBREAK_TAR}" -C "${NEOTERM_JAILBREAK_RUNTIME_FOLDER}"

		rm "${NEOTERM_JAILBREAK_TAR}"
	else
		if [[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' jailbreak-cabal 2>/dev/null)" != "installed" ||
			[[ "${NEOTERM_APP_PACKAGE_MANAGER}" = "pacman" ]] && ! "$(pacman -Q jailbreak-cabal 2>/dev/null)"; then
			echo "Package 'jailbreak-cabal' is not installed."
			exit 1
		fi
	fi
}
