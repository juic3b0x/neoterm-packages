# shellcheck shell=bash disable=SC2155
neoterm_setup_xmake() {
	local XMAKE_VERSION=2.8.5
	local XMAKE_TGZ_URL=https://github.com/xmake-io/xmake/releases/download/v${XMAKE_VERSION}/xmake-v${XMAKE_VERSION}.tar.gz
	local XMAKE_TGZ_SHA256=19c67be3bcfcbda96ca87a18effac39bfccc443fbb3754c7bbc01511decd24af
	local XMAKE_TGZ_FILE=${NEOTERM_PKG_TMPDIR}/xmake-${XMAKE_VERSION}.tar.gz
	local XMAKE_FOLDER=${NEOTERM_COMMON_CACHEDIR}/xmake-${XMAKE_VERSION}
	if [[ "${NEOTERM_PACKAGES_OFFLINE-false}" == "true" ]]; then
		XMAKE_FOLDER=${NEOTERM_SCRIPTDIR}/build-tools/xmake-${XMAKE_VERSION}
	fi
	local XMAKE_PKG_VERSION=$(. "${NEOTERM_SCRIPTDIR}/packages/xmake/build.sh"; echo ${NEOTERM_PKG_VERSION})

	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then
		if [[ "$(cat "${NEOTERM_BUILT_PACKAGES_DIRECTORY}/xmake" 2>/dev/null)" != "${XMAKE_PKG_VERSION}" && -z "$(command -v xmake)" ]]; then
			cat <<- EOL >&2
			Package 'xmake' is not installed.
			You can install it with

			pkg install xmake

			or build it from source with

			./build-package.sh xmake
			EOL
			exit 1
		fi
		return
	fi

	# always assume host build as xmake dont provide prebuilt binary
	# dont use xmake-*.run as it uses single core to build and
	# auto installs into ~/.local/{bin,share}

	if [[ ! -x "${XMAKE_FOLDER}/bin/xmake" ]]; then
		mkdir -p "${XMAKE_FOLDER}"
		neoterm_download "${XMAKE_TGZ_URL}" "${XMAKE_TGZ_FILE}" "${XMAKE_TGZ_SHA256}"
		tar -xf "${XMAKE_TGZ_FILE}" -C "${XMAKE_FOLDER}" --strip-components=1

		# xmake injects -m64 and -m32 when it shouldnt
		local files=$(grep -E "march = \"-m(32|64)" -nHR "${XMAKE_FOLDER}" | grep -E "gcc" | cut -d":" -f1 | sort)
		for f in ${files}; do
			echo "neoterm_setup_xmake: Patching ${f}"
			sed -e "/.*march = \"-m.*/d" -i "${f}"
		done

		(
			unset AR AS CC CFLAGS CPP CPPFLAGS CXX CXXFLAGS LD LDFLAGS PREFIX NEOTERM_ARCH
			pushd "${XMAKE_FOLDER}"
			./configure --prefix="${XMAKE_FOLDER}"
			make -j"$(nproc)" install
			popd
		)
	fi

	export PATH="${XMAKE_FOLDER}/bin:${PATH}"
	if [[ -z "$(command -v xmake)" ]]; then
		neoterm_error_exit "neoterm_setup_xmake: No xmake executable found!"
	fi
}
