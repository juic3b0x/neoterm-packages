NEOTERM_PKG_HOMEPAGE=https://www.llvm.org/
NEOTERM_PKG_DESCRIPTION="Compiler runtime libraries for LLVM-MinGW"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@licy183"
# Bump llvm-mingw-w64* to the same version in one PR.
NEOTERM_PKG_VERSION="20231031"
NEOTERM_PKG_SRCURL=https://github.com/mstorsjo/llvm-mingw/releases/download/$NEOTERM_PKG_VERSION/llvm-mingw-$NEOTERM_PKG_VERSION-ucrt-ubuntu-20.04-x86_64.tar.xz
NEOTERM_PKG_SHA256=95a4fb16425ce3234a2bf94c6d7c6c1fbf6833a4fa80d84c82ccf2ad533f0737
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_make_install() {
	# Install compier-rt libraries
	local LLVM_MAJOR_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/libllvm/build.sh; echo $LLVM_MAJOR_VERSION)
	mkdir -p $NEOTERM_PREFIX/lib/clang/$LLVM_MAJOR_VERSION/lib/windows
	mv $NEOTERM_PKG_SRCDIR/lib/clang/*/lib/windows $NEOTERM_PREFIX/lib/clang/$LLVM_MAJOR_VERSION/lib/
}

neoterm_step_install_license() {
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME
	cp $NEOTERM_PKG_SRCDIR/LICENSE.TXT $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/
}
