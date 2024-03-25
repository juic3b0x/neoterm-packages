NEOTERM_PKG_HOMEPAGE=https://people.freedesktop.org/~hughsient/appstream-glib/
NEOTERM_PKG_DESCRIPTION="Provides GObjects and helper methods to make it easy to read and write AppStream metadata"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://people.freedesktop.org/~hughsient/appstream-glib/releases/appstream-glib-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=71256500add5048d6f08878904708b3d0c3875f402e0adcd358e91d47dcd8b96
NEOTERM_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, gtk3, json-glib, libarchive, libcairo, libcurl, libstemmer, libuuid, libyaml, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Drpm=false
-Dgtk-doc=false
-Dintrospection=true
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
