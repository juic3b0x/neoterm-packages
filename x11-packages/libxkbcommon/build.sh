NEOTERM_PKG_HOMEPAGE=https://xkbcommon.org/
NEOTERM_PKG_DESCRIPTION="Keymap handling library for toolkits and window systems"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.6.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/xkbcommon/libxkbcommon/archive/xkbcommon-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4aa6c1cad7dce1238d6f48b6729f1998c7e3f0667a21100d5268c91a5830ad7b
NEOTERM_PKG_DEPENDS="libxcb, libxml2, libwayland, xkeyboard-config"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-protocols, xorg-util-macros"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='(?<=-).+'
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-docs=false
-Denable-wayland=true
"

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/libwayland/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}
