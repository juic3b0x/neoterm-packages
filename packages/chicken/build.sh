NEOTERM_PKG_HOMEPAGE=https://www.call-cc.org
NEOTERM_PKG_DESCRIPTION="A feature rich Scheme compiler and interpreter"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.3.0
NEOTERM_PKG_SRCURL=https://code.call-cc.org/releases/${NEOTERM_PKG_VERSION}/chicken-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c3ad99d8f9e17ed810912ef981ac3b0c2e2f46fb0ecc033b5c3b6dca1bdb0d76
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PLATFORM=android"

neoterm_step_pre_configure() {
	local ARCH="${NEOTERM_ARCH/_/-}" # Replace '_' in x86_64 with '-'.
	if [[ "${NEOTERM_ARCH}" == "i686" ]]; then
		ARCH="x86"
	fi
	NEOTERM_PKG_EXTRA_MAKE_ARGS+=" ARCH=${ARCH}"

	export C_COMPILER="$CC"
}
