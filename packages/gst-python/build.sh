NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Python bindings for GStreamer"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.24.0"
NEOTERM_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-python/gst-python-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=041c2255c1ea9936c777dcb08a36ecaa6a24a69a12fc46ef53f1530d46c59f9d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gst-plugins-base, gstreamer, pygobject, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
"
