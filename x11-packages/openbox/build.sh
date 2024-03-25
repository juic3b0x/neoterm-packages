NEOTERM_PKG_HOMEPAGE=http://openbox.org
NEOTERM_PKG_DESCRIPTION="Highly configurable and lightweight X11 window manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.6.1
NEOTERM_PKG_REVISION=57
NEOTERM_PKG_SRCURL=http://openbox.org/dist/openbox/openbox-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8b4ac0760018c77c0044fab06a4f0c510ba87eae934d9983b10878483bde7ef7
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-session-management"
NEOTERM_PKG_DEPENDS="bash, fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, imlib2, libcairo, libice, librsvg, libsm, libx11, libxcursor, libxext, libxft, libxinerama, libxml2, libxrandr, libxrender, pango, startup-notification"

# Configuration utility.
NEOTERM_PKG_RECOMMENDS="obconf"

# For default menu entries.
NEOTERM_PKG_SUGGESTS="aterm, fltk, geany, the-powder-toy, dosbox"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/gdm-control
bin/gnome-panel-control
bin/openbox-gnome-session
bin/openbox-kde-session
share/man/man1/openbox-gnome-session.1
share/man/man1/openbox-kde-session.1
share/gnome-session
share/gnome
share/xsessions/openbox-gnome.desktop
share/xsessions/openbox-kde.desktop
"

NEOTERM_PKG_CONFFILES="
etc/xdg/openbox/autostart
etc/xdg/openbox/environment
etc/xdg/openbox/menu.xml
etc/xdg/openbox/rc.xml
"

neoterm_step_post_make_install() {
	## install custom variant of scripts startup scripts
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/scripts/openbox-session" "${NEOTERM_PREFIX}/bin/openbox-session"
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" "${NEOTERM_PREFIX}/bin/openbox-session"
	chmod 755 "${NEOTERM_PREFIX}/bin/openbox-session"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/scripts/openbox-autostart" "${NEOTERM_PREFIX}/libexec/openbox-autostart"
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" "${NEOTERM_PREFIX}/libexec/openbox-autostart"
	chmod 755 "${NEOTERM_PREFIX}/libexec/openbox-autostart"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/scripts/openbox-xdg-autostart" "${NEOTERM_PREFIX}/libexec/openbox-xdg-autostart"
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" "${NEOTERM_PREFIX}/libexec/openbox-xdg-autostart"
	chmod 755 "${NEOTERM_PREFIX}/libexec/openbox-xdg-autostart"

	## install custom config files
	cp -f "${NEOTERM_PKG_BUILDER_DIR}/configs/autostart" "${NEOTERM_PREFIX}/etc/xdg/openbox/autostart"
	chmod 755 "${NEOTERM_PREFIX}/etc/xdg/openbox/autostart"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/configs/environment" "${NEOTERM_PREFIX}/etc/xdg/openbox/environment"
	chmod 755 "${NEOTERM_PREFIX}/etc/xdg/openbox/environment"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/configs/menu.xml" "${NEOTERM_PREFIX}/etc/xdg/openbox/menu.xml"
	chmod 644 "${NEOTERM_PREFIX}/etc/xdg/openbox/menu.xml"

	cp -f "${NEOTERM_PKG_BUILDER_DIR}/configs/rc.xml" "${NEOTERM_PREFIX}/etc/xdg/openbox/rc.xml"
	chmod 644 "${NEOTERM_PREFIX}/etc/xdg/openbox/rc.xml"

	## install theme 'Onyx-Black'
	cp -a "${NEOTERM_PKG_BUILDER_DIR}/Theme-Onyx-Black" "${NEOTERM_PREFIX}/share/themes/Onyx-black"
	find "${NEOTERM_PREFIX}/share/themes/Onyx-black" -type d | xargs chmod 755
	find "${NEOTERM_PREFIX}/share/themes/Onyx-black" -type f | xargs chmod 644
}
