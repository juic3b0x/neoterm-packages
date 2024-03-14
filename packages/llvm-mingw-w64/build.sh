NEOTERM_PKG_HOMEPAGE=https://github.com/mstorsjo/llvm-mingw
NEOTERM_PKG_DESCRIPTION="MinGW-w64 toolchain based on LLVM"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@licy183"
# Bump llvm-mingw-w64* to the same version in one PR.
NEOTERM_PKG_VERSION="20231031"
NEOTERM_PKG_SRCURL=https://github.com/mstorsjo/llvm-mingw/releases/download/$NEOTERM_PKG_VERSION/llvm-mingw-$NEOTERM_PKG_VERSION-ucrt-ubuntu-20.04-x86_64.tar.xz
NEOTERM_PKG_SHA256=95a4fb16425ce3234a2bf94c6d7c6c1fbf6833a4fa80d84c82ccf2ad533f0737
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="clang, llvm, llvm-tools, llvm-mingw-w64-libcompiler-rt, llvm-mingw-w64-ucrt"
NEOTERM_PKG_RECOMMENDS="llvm-mingw-w64-tools"
NEOTERM_PKG_CONFLICTS="mingw-w64"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/opt/llvm-mingw-w64/bin
	cd $NEOTERM_PKG_SRCDIR/bin

	# These files are packaged in llvm-mingw-w64-tools
	rm *widl gendef

	# Do not package lldb
	rm *lldb*

	# On Termux, use the wrapper script rather than the wrapper binary
	rm *wrapper
	rm *wrapper.sh.orig

	# Install prefixed scripts
	mv {aarch64,armv7,i686,x86_64}* $NEOTERM_PREFIX/opt/llvm-mingw-w64/bin
	mv *wrapper.sh $NEOTERM_PREFIX/opt/llvm-mingw-w64/bin

	# Symlinks clang, lld and llvm tools
	local _tool
	for _tool in ./*; do
		local _toolname=$(basename $_tool)
		ln -sr $NEOTERM_PREFIX/bin/$_toolname $NEOTERM_PREFIX/opt/llvm-mingw-w64/bin
	done

	# Symlinks prefixed scripts to $PREFIX/bin
	for _tool in $NEOTERM_PREFIX/opt/llvm-mingw-w64/bin/{aarch64,armv7,i686,x86_64}*; do
		if [ ! -e $NEOTERM_PREFIX/bin/"$(basename $_tool)" ]; then
			ln -sr $_tool $NEOTERM_PREFIX/bin/"$(basename $_tool)"
		fi
	done
}
