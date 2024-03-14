NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="GStreamer Ugly Plug-ins"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.24.0"
NEOTERM_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=c5d1cbdf71ab0c675bca236f70edfa1feb3f813fd4bfff563308f466d8805ca5
NEOTERM_PKG_DEPENDS="glib, gst-plugins-base"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
"
