NEOTERM_PKG_HOMEPAGE=https://gi.readthedocs.io/
NEOTERM_PKG_DESCRIPTION="Uniform machine readable API"
NEOTERM_PKG_LICENSE="LGPL-2.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.78.1"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gobject-introspection/${NEOTERM_PKG_VERSION%.*}/gobject-introspection-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=bd7babd99af7258e76819e45ba4a6bc399608fe762d83fde3cac033c50841bb4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libffi"
NEOTERM_PKG_SUGGESTS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dcairo_libname=libcairo-gobject.so
-Dpython=python
-Dbuild_introspection_data=true
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
		-Dgi_cross_binary_wrapper=$GI_CROSS_LAUNCHER
		"
	unset GI_CROSS_LAUNCHER
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
			-Dgi_cross_use_prebuilt_gi=true
			-Dgi_cross_ldd_wrapper=$(command -v ldd)
			"
	fi

	echo "Applying meson-python.diff"
	sed "s%@PYTHON_VERSION@%$NEOTERM_PYTHON_VERSION%g" \
		$NEOTERM_PKG_BUILDER_DIR/meson-python.diff | patch --silent -p1

	CPPFLAGS+="
		-I$NEOTERM_PREFIX/include/python${NEOTERM_PYTHON_VERSION}
		-I$NEOTERM_PREFIX/include/python${NEOTERM_PYTHON_VERSION}/cpython
		"
}
