NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="A session manager for XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-session/${_MAJOR_VERSION}/xfce4-session-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=382f93e096ec6493098719cab8cc31b93ad9bb469c0715c0c5117d75fe7394ec
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, libice, libsm, libwnck, libx11, libxfce4ui, libxfce4util, pango, xfconf, xorg-iceauth, xorg-xrdb"
NEOTERM_PKG_RECOMMENDS="gnupg, hicolor-icon-theme, xfce4-settings, xfdesktop, xfwm4"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_ICEAUTH=${NEOTERM_PREFIX}/bin/iceauth
--with-xsession-prefix=$NEOTERM_PREFIX
"

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	if [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$NEOTERM_PREFIX/bin/x-session-manager x-session-manager $NEOTERM_PREFIX/bin/xfce4-session 50
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	if [ "\$1" != "upgrade" ]; then
		if [ -x "$NEOTERM_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove x-session-manager $NEOTERM_PREFIX/bin/xfce4-session
		fi
	fi
	EOF
}
