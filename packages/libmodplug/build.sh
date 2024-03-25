NEOTERM_PKG_HOMEPAGE=https://modplug-xmms.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="The ModPlug mod file playing library"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.9.1.r461
NEOTERM_PKG_SRCURL=https://github.com/ShiftMediaProject/modplug/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d489a13cc863180b0f8209ad7b69d4413df454858d6f4ce94a03669213dc56cd
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
