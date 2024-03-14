NEOTERM_PKG_HOMEPAGE=https://github.com/rcoh/angle-grinder
NEOTERM_PKG_DESCRIPTION="Slice and dice logs on the command line"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.19.2"
NEOTERM_PKG_SRCURL="https://github.com/rcoh/angle-grinder/archive/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=3a5637bbd3ef3fc2f8164a1af90b8894f79c1b2adb89a874f1f3c5a56006e18b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# ```
	# ld: error: undefined symbol: __emutls_get_address
	# ```
	# It isn't able to find/link with `libgcc` during arm build.

	if [[ "${NEOTERM_ARCH}" == "arm" ]]; then
		RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}
