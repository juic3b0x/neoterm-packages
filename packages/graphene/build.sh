NEOTERM_PKG_HOMEPAGE=https://ebassi.github.io/graphene/
NEOTERM_PKG_DESCRIPTION="A thin layer of graphic data types"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.10
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.8
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/graphene/${_MAJOR_VERSION}/graphene-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a37bb0e78a419dcbeaa9c7027bcff52f5ec2367c25ec859da31dfde2928f279a
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_CONFLICTS="gst-plugins-base (<< 1.20.3-1)"
NEOTERM_PKG_BREAKS="gst-plugins-base (<< 1.20.3-1)"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local pywrap="$NEOTERM_PKG_BUILDDIR/_bin/python-wrapper"
		mkdir -p "$(dirname "$pywrap")"
		cat > "$pywrap" <<-EOF
			#!/bin/bash-static
			unset LD_LIBRARY_PATH
			exec /usr/bin/python3 "\$@"
		EOF
		chmod 0700 "$pywrap"
		echo "Applying wrap-python.diff"
		sed -e "s|@PYTHON_WRAPPER@|${pywrap}|g" \
			"$NEOTERM_PKG_BUILDER_DIR/wrap-python.diff" \
			| patch --silent -p1 -d "$NEOTERM_PKG_SRCDIR"
	fi
}
