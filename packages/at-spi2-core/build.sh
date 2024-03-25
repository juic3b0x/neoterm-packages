NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Accessibility
NEOTERM_PKG_DESCRIPTION="Assistive Technology Service Provider Interface (AT-SPI)"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.50.1"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/at-spi2-core/${NEOTERM_PKG_VERSION%.*}/at-spi2-core-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5727b5c0687ac57ba8040e79bd6731b714a36b8fcf32190f236b8fb3698789e7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="dbus, glib, libx11, libxi, libxtst"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, libxml2"
NEOTERM_PKG_PROVIDES="at-spi2-atk, atk"
NEOTERM_PKG_REPLACES="at-spi2-atk (<< 2.46.0), atk (<< 2.46.0), libatk"
NEOTERM_PKG_BREAKS="at-spi2-atk (<< 2.46.0), atk (<< 2.46.0), libatk"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddbus_daemon=$NEOTERM_PREFIX/bin/dbus-daemon
-Dintrospection=enabled
-Dx11=enabled
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

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
