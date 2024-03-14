NEOTERM_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/projects/orc.html
NEOTERM_PKG_DESCRIPTION="Library of Optimized Inner Loops Runtime Compiler"
NEOTERM_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.38"
NEOTERM_PKG_SRCURL=https://github.com/GStreamer/orc/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3f9cd05bbb0d8beca8cb02eab4b80b579ab9eb1a715458700104ae2aeeb02908
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dorc-test=disabled
-Dtests=disabled
-Dbenchmarks=disabled
-Dexamples=disabled
-Dgtk_doc=disabled
"
