NEOTERM_PKG_HOMEPAGE=https://gegl.org/babl/
NEOTERM_PKG_DESCRIPTION="Dynamic pixel format translation library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.1
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.108
NEOTERM_PKG_SRCURL=https://download.gimp.org/pub/babl/${_MAJOR_VERSION}/babl-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=26defe9deaab7ac4d0e076cab49c2a0d6ebd0df0c31fd209925a5f07edee1475
NEOTERM_PKG_DEPENDS="littlecms"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_BREAKS="babl-dev"
NEOTERM_PKG_REPLACES="babl-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-gir=true
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
