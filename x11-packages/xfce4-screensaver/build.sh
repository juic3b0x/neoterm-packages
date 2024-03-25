NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/apps/screensaver/start
NEOTERM_PKG_DESCRIPTION="Xfce Screensaver is a screen saver and locker that aims to have simple, sane, secure defaults and be well integrated with the desktop."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.2
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-screensaver/${_MAJOR_VERSION}/xfce4-screensaver-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=e4fcd2c414d3a4215e9e86a55edd87e2545b15c961917f5d72cace35b76e2b98
NEOTERM_PKG_DEPENDS="dbus, dbus-glib, garcon, gdk-pixbuf, glib, gtk3, libcairo, libwnck, libx11, libxext, libxfce4ui, libxfce4util, libxklavier, libxss, opengl, pango, neoterm-auth, xfconf"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-locking --sysconfdir=$NEOTERM_PREFIX/etc"
NEOTERM_PKG_BUILD_IN_SRC=true
