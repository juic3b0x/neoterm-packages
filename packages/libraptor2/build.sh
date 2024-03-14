NEOTERM_PKG_HOMEPAGE=https://librdf.org/raptor/
NEOTERM_PKG_DESCRIPTION="RDF Syntax Library"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-2.0, Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.LIB, LICENSE-2.0.txt, LICENSE.txt, NOTICE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.16
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://download.librdf.org/source/raptor2-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=089db78d7ac982354bdbf39d973baf09581e6904ac4c92a98c5caadb3de44680
NEOTERM_PKG_DEPENDS="libcurl, libicu, libxml2, libxslt, yajl"
NEOTERM_PKG_BUILD_DEPENDS="icu-devtools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-icu-config=icu-config
--with-yajl=$NEOTERM_PREFIX
"

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}

neoterm_step_post_massage() {
	# For backward compatibility. Rebuild revdeps and delete this.
	cd ${NEOTERM_PKG_MASSAGEDIR}/${NEOTERM_PREFIX}/lib || exit 1
	if [ ! -e "./libraptor2.so.0" ]; then
		ln -sf libraptor2.so libraptor2.so.0
	fi
}
