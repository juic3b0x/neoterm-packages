NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-create-package
NEOTERM_PKG_DESCRIPTION="Utility to create NeoTerm packages"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.12.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-create-package/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=13bcc1264844e9865eeab19805f24ff28bbfac8d39c11bca66f4357fa70e6ace
NEOTERM_PKG_DEPENDS="binutils-is-llvm | binutils, python"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin src/neoterm-create-package
}
