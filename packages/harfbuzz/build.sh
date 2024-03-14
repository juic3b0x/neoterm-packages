NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
NEOTERM_PKG_DESCRIPTION="OpenType text shaping engine"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.3.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/harfbuzz/harfbuzz/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7cefc6cc161e9d5c88210dafc43bc733ca3e383fd3dd4f1e6178f81bd41cfaae
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="freetype, glib, libcairo, libgraphite"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="harfbuzz-dev"
NEOTERM_PKG_REPLACES="harfbuzz-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgobject=enabled
-Dgraphite=enabled
-Dintrospection=enabled
"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/gtk-doc
"

neoterm_step_post_get_source() {
	mv CMakeLists.txt CMakeLists.txt.unused
}

neoterm_step_pre_configure() {
	neoterm_setup_gir

	local _WRAPPER_BIN="${NEOTERM_PKG_BUILDDIR}/_wrapper/bin"
	mkdir -p "${_WRAPPER_BIN}"
	if [[ "${NEOTERM_ON_DEVICE_BUILD}" == "false" ]]; then
		sed "s|^export PKG_CONFIG_LIBDIR=|export PKG_CONFIG_LIBDIR=${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:|" \
			"${NEOTERM_STANDALONE_TOOLCHAIN}/bin/pkg-config" \
			> "${_WRAPPER_BIN}/pkg-config"
		chmod +x "${_WRAPPER_BIN}/pkg-config"
		export PKG_CONFIG="${_WRAPPER_BIN}/pkg-config"
	fi
	export PATH="${_WRAPPER_BIN}:${PATH}"
}
