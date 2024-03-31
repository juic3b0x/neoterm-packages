NEOTERM_PKG_HOMEPAGE=http://www.kfish.org/software/xsel/
NEOTERM_PKG_DESCRIPTION="Command-line program for getting and setting the contents of the X selection"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="Doron Behar <me@doronbehar.com>"
NEOTERM_PKG_VERSION=1.2.1
NEOTERM_PKG_SRCURL=https://github.com/kfish/xsel/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=18487761f5ca626a036d65ef2db8ad9923bf61685e06e7533676c56d7d60eb14
NEOTERM_PKG_DEPENDS="libx11"

neoterm_step_pre_configure() {
	autoreconf -fi
}
