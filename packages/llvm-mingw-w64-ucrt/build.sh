NEOTERM_PKG_HOMEPAGE=https://www.mingw-w64.org/
NEOTERM_PKG_DESCRIPTION="MinGW-w64 runtime for LLVM-MinGW"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@licy183"
# Bump llvm-mingw-w64* to the same version in one PR.
NEOTERM_PKG_VERSION="20231031"
NEOTERM_PKG_SRCURL=https://github.com/mstorsjo/llvm-mingw/releases/download/$NEOTERM_PKG_VERSION/llvm-mingw-$NEOTERM_PKG_VERSION-ucrt-ubuntu-20.04-x86_64.tar.xz
NEOTERM_PKG_SHA256=95a4fb16425ce3234a2bf94c6d7c6c1fbf6833a4fa80d84c82ccf2ad533f0737
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/opt/llvm-mingw-w64
	mv $NEOTERM_PKG_SRCDIR/{aarch64,armv7,i686,x86_64,generic}-w64-mingw32 $NEOTERM_PREFIX/opt/llvm-mingw-w64
}

neoterm_step_install_license() {
	# Runtimes are consist of runtimes libraries from mingw-w64 and libunwind/libc++ from LLVM
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME

	# Install the license of mingw-w64 and mingw-w64-runtimes
	local _file
	for _file in $NEOTERM_PREFIX/opt/llvm-mingw-w64/aarch64-w64-mingw32/share/mingw32/*; do
		cp $_file $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/
	done

	# Install the license of LLVM
	cp $NEOTERM_PKG_SRCDIR/LICENSE.TXT $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE-LLVM.TXT
}
