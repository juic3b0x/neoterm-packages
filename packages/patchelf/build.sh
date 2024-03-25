NEOTERM_PKG_HOMEPAGE=https://nixos.org/patchelf.html
NEOTERM_PKG_DESCRIPTION="Utility to modify the dynamic linker and RPATH of ELF executables"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.18.0"
NEOTERM_PKG_SRCURL=https://github.com/NixOS/patchelf/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=1451d01ee3a21100340aed867d0b799f46f0b1749680028d38c3f5d0128fb8a7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	./bootstrap.sh
}
