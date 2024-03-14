NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/apps/xfce4-panel-profiles/start
NEOTERM_PKG_DESCRIPTION="A simple application to manage Xfce panel layouts."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.0
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.14
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-panel-profiles/${_MAJOR_VERSION}/xfce4-panel-profiles-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=6d08354e8c44d4b0370150809c1ed601d09c8b488b68986477260609a78be3f9
NEOTERM_PKG_DEPENDS="gtk3, libxfce4ui, libxfce4util, pygobject, python, xfce4-panel"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	sed -e s,@prefix@,$NEOTERM_PREFIX, Makefile.in.in > Makefile.in
	sed \
		-e s,@appname@,xfce4-panel-profiles,g \
		-e s,@version@,$NEOTERM_PKG_VERSION,g \
		-e s,@mandir@,$NEOTERM_PREFIX/share/man,g \
		-e s,@docdir@,$NEOTERM_PREFIX/share/doc/xfce4-panel-profiles,g \
		-e s,@python@,$NEOTERM_PREFIX/bin/python,g \
		Makefile.in > Makefile
}
