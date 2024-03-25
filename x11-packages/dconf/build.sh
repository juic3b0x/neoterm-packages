NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/dconf
NEOTERM_PKG_DESCRIPTION="dconf is a simple key/value storage system that is heavily optimised for reading"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.40.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://gitlab.gnome.org/GNOME/dconf
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="dbus, glib-bin"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="-Dbash_completion=false -Dvapi=false"

