NEOTERM_PKG_HOMEPAGE=https://gitlab.com/vala-panel-project/vala-panel-appmenu
NEOTERM_PKG_DESCRIPTION="Global Menu for Vala Panel (metapackage)"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.6
NEOTERM_PKG_SRCURL=https://gitlab.com/vala-panel-project/vala-panel-appmenu/-/archive/${NEOTERM_PKG_VERSION}/vala-panel-appmenu-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=c137f8f30ab5925a4a236a8a047b7962ec9be987fe25dd2d092666e0580fdacf
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dwm_backend=wnck
-Dvalapanel=disabled
-Dxfce=enabled
-Dmate=disabled
-Dbudgie=disabled
-Dregistrar=disabled
-Dappmenu-gtk-module=disabled
-Djayatana=disabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	CPPFLAGS+=" -Dulong=u_long"
	LDFLAGS+=" -lX11"
}
