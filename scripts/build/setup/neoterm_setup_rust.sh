# shellcheck shell=bash disable=SC1091 disable=SC2086 disable=SC2155
neoterm_setup_rust() {
	export CARGO_TARGET_NAME="${NEOTERM_ARCH}-linux-android"
	if [[ "${NEOTERM_ARCH}" == "arm" ]]; then
		CARGO_TARGET_NAME="armv7-linux-androideabi"
	fi

	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "true" ]]; then
		if [[ -z "$(command -v rustc)" ]]; then
			cat <<- EOL
			Package 'rust' is not installed.
			You can install it with

			pkg install rust

			pacman -S rust

			or build it from source with

			./build-package.sh rust

			Note that package 'rust' is known to be problematic for building on device.
			EOL
			exit 1
		fi
		local RUSTC_VERSION=$(rustc --version | awk '{ print $2 }')
		if [[ -n "${NEOTERM_RUST_VERSION-}" && "${NEOTERM_RUST_VERSION-}" != "${RUSTC_VERSION}" ]]; then
			cat <<- EOL >&2
			WARN: On device build with old rust version is not possible!
			NEOTERM_RUST_VERSION = ${NEOTERM_RUST_VERSION}
			RUSTC_VERSION       = ${RUSTC_VERSION}
			EOL
		fi
		return
	fi

	local ENV_NAME=CARGO_TARGET_${CARGO_TARGET_NAME^^}_LINKER
	ENV_NAME=${ENV_NAME//-/_}
	export $ENV_NAME="${CC}"
	# TARGET_CFLAGS and CFLAGS incorrectly applied globally
	# for host build and other targets so set them individually
	export CFLAGS_aarch64_linux_android="${CPPFLAGS}"
	export CFLAGS_armv7_linux_androideabi="${CPPFLAGS}"
	export CFLAGS_i686_linux_android="${CPPFLAGS}"
	export CFLAGS_x86_64_linux_android="${CPPFLAGS}"
	unset CFLAGS

	if [[ -z "${NEOTERM_RUST_VERSION-}" ]]; then
		NEOTERM_RUST_VERSION=$(. "${NEOTERM_SCRIPTDIR}"/packages/rust/build.sh; echo ${NEOTERM_PKG_VERSION})
	fi
	if [[ "${NEOTERM_RUST_VERSION}" == *"~beta"* ]]; then
		NEOTERM_RUST_VERSION="beta"
	fi

	curl https://sh.rustup.rs -sSfo "${NEOTERM_PKG_TMPDIR}"/rustup.sh
	sh "${NEOTERM_PKG_TMPDIR}"/rustup.sh -y --default-toolchain "${NEOTERM_RUST_VERSION}"

	export PATH="${HOME}/.cargo/bin:${PATH}"

	rustup target add "${CARGO_TARGET_NAME}"
}