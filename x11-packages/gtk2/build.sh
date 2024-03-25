NEOTERM_PKG_HOMEPAGE=https://www.gtk.org/
NEOTERM_PKG_DESCRIPTION="GObject-based multi-platform GUI toolkit (legacy)"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.24
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.33
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtk+/${_MAJOR_VERSION}/gtk+-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="adwaita-icon-theme, atk, coreutils, desktop-file-utils, fontconfig, freetype, glib, glib-bin, gtk-update-icon-cache, harfbuzz, libandroid-shmem, libcairo, librsvg, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxinerama, libxrandr, libxrender, pango, shared-mime-info, ttf-dejavu"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_CONFLICTS="libgtk2"
NEOTERM_PKG_REPLACES="libgtk2"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-shm
--enable-xkb
--enable-xinerama
--disable-glibtest
--disable-cups
--disable-papi
--enable-introspection=yes
"

## 1. gtk-update-icon-cache is subpackage of 'gtk3'
## 2. locales are not supported by NeoTerm and wasting space
## 3. for backward compatibility; not in build using Git source
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/gtk-update-icon-cache
lib/locale
share/gtk-doc
"

neoterm_step_pre_configure() {
	autoreconf -fi

	neoterm_setup_gir

	export LIBS="-landroid-shmem"
	export LDFLAGS="${LDFLAGS} -landroid-shmem"
}

neoterm_step_post_configure() {
	touch ./gtk/g-ir-scanner
}

neoterm_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			"${NEOTERM_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
