NEOTERM_PKG_HOMEPAGE=https://github.com/mstorsjo/llvm-mingw
NEOTERM_PKG_DESCRIPTION="MinGW-w64 tools for LLVM-MinGW"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@licy183"
NEOTERM_PKG_VERSION=11.0.0
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=bd0ea1633bd830204cc23a696889335e9d4a32b8619439ee17f22188695fcc5f
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_DEPENDS="llvm-mingw-w64-ucrt"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	mkdir -p $NEOTERM_PREFIX/opt/llvm-mingw-w64
	local _INSTALL_PREFIX=$NEOTERM_PREFIX/opt/llvm-mingw-w64
	local _INCLUDE_DIR="$_INSTALL_PREFIX/generic-w64-mingw32/include"

	# Build gendef
	pushd mingw-w64-tools/gendef
	mkdir -p build && cd build
	../configure --host=$NEOTERM_HOST_PLATFORM --prefix="$_INSTALL_PREFIX"
	make -j $NEOTERM_MAKE_PROCESSES
	make install-strip
	mkdir -p "$_INSTALL_PREFIX/share/gendef"
	install -m644 ../COPYING "$_INSTALL_PREFIX/share/gendef"
	popd

	# Build widl
	pushd mingw-w64-tools/widl
	mkdir -p build && cd build
	../configure --host=$NEOTERM_HOST_PLATFORM \
				--prefix="$_INSTALL_PREFIX" \
				--target=x86_64-w64-mingw32 \
				--with-widl-includedir="$_INCLUDE_DIR" 
	make -j $NEOTERM_MAKE_PROCESSES
	make install-strip
	mkdir -p "$_INSTALL_PREFIX/share/widl"
	install -m644 ../../../COPYING "$_INSTALL_PREFIX/share/widl"
	popd

	# The build above produced x86_64-w64-mingw32-widl, add symlinks to it
	# with other prefixes.
	local _arch
	for _arch in aarch64 armv7 i686; do
		ln -sf x86_64-w64-mingw32-widl $_INSTALL_PREFIX/bin/$_arch-w64-mingw32-widl
	done
	for _arch in aarch64 armv7 i686 x86_64; do
		ln -sf x86_64-w64-mingw32-widl $_INSTALL_PREFIX/bin/$_arch-w64-mingw32uwp-widl
	done
}

neoterm_step_make_install() {
	local _INSTALL_PREFIX=$NEOTERM_PREFIX/opt/llvm-mingw-w64
	mkdir -p $NEOTERM_PREFIX/bin

	# Symlinks tools to $PREFIX/bin
	local _tool
	for _tool in gendef {aarch64,armv7,i686,x86_64}-w64-mingw32{,uwp}-widl; do
		ln -sr $_INSTALL_PREFIX/bin/$_tool $NEOTERM_PREFIX/bin/$_tool
	done
}

neoterm_step_install_license() {
	mkdir -p $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME

	cp $NEOTERM_PREFIX/opt/llvm-mingw-w64/share/gendef/COPYING $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING-gendef
	cp $NEOTERM_PREFIX/opt/llvm-mingw-w64/share/widl/COPYING $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING-widl
}
