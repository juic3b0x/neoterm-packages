NEOTERM_PKG_HOMEPAGE=https://core.tcl-lang.org/tcllib/
NEOTERM_PKG_DESCRIPTION="Tcl Standard Library"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="license.terms"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.21
NEOTERM_PKG_SRCURL=https://core.tcl-lang.org/tcllib/uv/tcllib-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=10c7749e30fdd6092251930e8a1aa289b193a3b7f1abf17fee1d4fa89814762f
NEOTERM_PKG_DEPENDS="tcl"
NEOTERM_PKG_RECOMMENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	true
}

neoterm_step_make() {
	true
}

neoterm_step_make_install() {
	tclsh installer.tcl \
		-pkg-path ${NEOTERM_PREFIX}/lib/tcllib${NEOTERM_PKG_VERSION} \
		-app-path ${NEOTERM_PREFIX}/bin \
		-nroff-path ${NEOTERM_PREFIX}/share/man/mann \
		-no-examples \
		-no-html \
		-no-wait \
		-no-gui
}
