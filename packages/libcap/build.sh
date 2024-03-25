NEOTERM_PKG_HOMEPAGE=https://sites.google.com/site/fullycapable/
NEOTERM_PKG_DESCRIPTION="POSIX 1003.1e capabilities"
NEOTERM_PKG_LICENSE="BSD 3-Clause, GPL-2.0"
NEOTERM_PKG_LICENSE_FILE="License"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.69
NEOTERM_PKG_SRCURL=https://kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f311f8f3dad84699d0566d1d6f7ec943a9298b28f714cae3c931dfd57492d7eb
NEOTERM_PKG_DEPENDS="attr"
NEOTERM_PKG_BREAKS="libcap-dev"
NEOTERM_PKG_REPLACES="libcap-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make CC="$CC -Wl,-rpath=$NEOTERM_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy PREFIX="$NEOTERM_PREFIX" PTHREADS=no PAM_CAP=no
}

neoterm_step_make_install() {
	make CC="$CC -Wl,-rpath=$NEOTERM_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy prefix="$NEOTERM_PREFIX" RAISE_SETFCAP=no lib=/lib PTHREADS=no install PAM_CAP=no
}
