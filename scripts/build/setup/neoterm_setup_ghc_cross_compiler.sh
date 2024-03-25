# shellcheck shell=bash
# Utility function to setup a GHC cross-compiler toolchain targeting Android.
neoterm_setup_ghc_cross_compiler() {
	local NEOTERM_GHC_VERSION=9.2.5
	local GHC_PREFIX="ghc-cross-${NEOTERM_GHC_VERSION}-${NEOTERM_ARCH}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == false ]]; then
		local NEOTERM_GHC_RUNTIME_FOLDER

		if [[ "${NEOTERM_PACKAGES_OFFLINE-false}" == true ]]; then
			NEOTERM_GHC_RUNTIME_FOLDER="${NEOTERM_SCRIPTDIR}/build-tools/${GHC_PREFIX}-runtime"
		else
			NEOTERM_GHC_RUNTIME_FOLDER="${NEOTERM_COMMON_CACHEDIR}/${GHC_PREFIX}-runtime"
		fi

		local NEOTERM_GHC_TAR="${NEOTERM_COMMON_CACHEDIR}/${GHC_PREFIX}.tar.xz"

		export PATH="${NEOTERM_GHC_RUNTIME_FOLDER}/bin:${PATH}"

		test -d "${NEOTERM_PREFIX}/lib/ghc-${NEOTERM_GHC_VERSION}" ||
			neoterm_error_exit "Package 'ghc-libs' is not installed. It is required by GHC cross-compiler." \
				"You should specify it in 'NEOTERM_PKG_BUILD_DEPENDS'."

		[[ -d "${NEOTERM_GHC_RUNTIME_FOLDER}" ]] && return

		local CHECKSUMS
		CHECKSUMS="$(
			cat <<-EOF
				aarch64:47893a77abd35ce5f884bf9c67f8f0437dbcb297d5939e17a3ce7aa74c7d34b8
				arm:dca3aa7a523054e5b472793afb0d750162052ffa762122c1200e5d832187bb86
				i686:428c26a4c2a26737a9c031dbe7545c6514d9042cb28d926ffa8702c2930326c5
				x86_64:1b27fa3dfa02cc9959b43a82b2881b55a1def397da7e7f7ff64406c666763f50
			EOF
		)"

		neoterm_download "https://github.com/MrAdityaAlok/ghc-cross-tools/releases/download/ghc-v${NEOTERM_GHC_VERSION}/ghc-cross-bin-${NEOTERM_GHC_VERSION}-${NEOTERM_ARCH}.tar.xz" \
			"${NEOTERM_GHC_TAR}" \
			"$(echo "${CHECKSUMS}" | grep -w "${NEOTERM_ARCH}" | cut -d ':' -f 2)"

		mkdir -p "${NEOTERM_GHC_RUNTIME_FOLDER}"
		tar -xf "${NEOTERM_GHC_TAR}" -C "${NEOTERM_GHC_RUNTIME_FOLDER}"
		rm "${NEOTERM_GHC_TAR}"

		# Replace ghc settings with settings of the cross compiler.
		# NOTE: This edits file in $NEOTERM_PREFIX after timestamp creation. Remove it in massage step.
		sed "s|\$topdir/bin/unlit|${NEOTERM_GHC_RUNTIME_FOLDER}/lib/ghc-${NEOTERM_GHC_VERSION}/bin/unlit|g" \
			"${NEOTERM_GHC_RUNTIME_FOLDER}/lib/ghc-${NEOTERM_GHC_VERSION}/settings" > \
			"${NEOTERM_PREFIX}/lib/ghc-${NEOTERM_GHC_VERSION}/settings"

		for tool in ghc ghc-pkg hsc2hs hp2ps; do
			sed -i "s|\$executablename|${NEOTERM_GHC_RUNTIME_FOLDER}/lib/ghc-${NEOTERM_GHC_VERSION}/bin/${tool}|g" \
				"${NEOTERM_GHC_RUNTIME_FOLDER}/bin/${tool}"
		done

	else
		if [[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' ghc 2>/dev/null)" != "installed" ||
			[[ "${NEOTERM_APP_PACKAGE_MANAGER}" == "pacman" ]] && ! "$(pacman -Q ghc 2>/dev/null)"; then
			echo "Package 'ghc' is not installed."
			exit 1
		fi
	fi
}
