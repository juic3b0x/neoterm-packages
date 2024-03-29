NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-create-package
NEOTERM_PKG_DESCRIPTION="Utility to create NeoTerm packages"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.12.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/theworkjoy/neoterm-create-package/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d5eb1435cb88f680980742c2f0cd74f61da8de9920a978046f8346385c97711c
NEOTERM_PKG_DEPENDS="binutils-is-llvm | binutils, python"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin src/neoterm-create-package
}
