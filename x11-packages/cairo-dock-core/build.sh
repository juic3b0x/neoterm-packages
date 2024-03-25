NEOTERM_PKG_HOMEPAGE=http://glx-dock.org/
NEOTERM_PKG_DESCRIPTION="Cairo-Dock is a simple and avanzed dock for linux desktop."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
_COMMIT=6c569e67a2a366e7634224a0133ede51755629cb
NEOTERM_PKG_VERSION=3.4.1
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://github.com/Cairo-Dock/cairo-dock-core/archive/${_COMMIT}.zip
NEOTERM_PKG_SHA256=e59e99147ce9c901b46d4b56b88bd53aeda34292b86fd9fbf2c55d158153f2ec
NEOTERM_PKG_DEPENDS="dbus-glib, gdk-pixbuf, glib, glu, gtk3, libcairo, libcurl, librsvg, libx11, libxcomposite, libxinerama, libxml2, libxrandr, libxrender, libxtst, opengl, pango"
NEOTERM_PKG_BUILD_DEPENDS="valac"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DFORCE_NOT_LIB64=yes
-DCMAKE_INSTALL_LIBDIR=lib
"
NEOTERM_CMAKE_BUILD="Unix Makefiles"

