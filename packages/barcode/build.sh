NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/barcode/
NEOTERM_PKG_DESCRIPTION="Tool to convert text strings to printed bars"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.99
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=http://mirrors.kernel.org/gnu/barcode/barcode-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=e87ecf6421573e17ce35879db8328617795258650831affd025fba42f155cdc6
NEOTERM_PKG_BUILD_DEPENDS="gettext"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -I$NEOTERM_PREFIX/share/gettext"
	CFLAGS+=" -fcommon"
}
