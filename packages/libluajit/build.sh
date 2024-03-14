NEOTERM_PKG_HOMEPAGE=https://luajit.org/
NEOTERM_PKG_DESCRIPTION="Just-In-Time Compiler for Lua"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:2.1.1707061634"
_COMMIT="787736990ac3b7d5ceaba2697c7d0f58f77bb782"
NEOTERM_PKG_SRCURL=https://github.com/LuaJIT/LuaJIT/archive/${_COMMIT}.tar.gz
NEOTERM_PKG_SHA256=2e3f74bc279f46cc463abfc67b36e69faaf0366237004771f4cac4bf2a9f5efb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_BREAKS="libluajit-dev"
NEOTERM_PKG_REPLACES="libluajit-dev"
NEOTERM_PKG_EXTRA_MAKE_ARGS="amalg PREFIX=$NEOTERM_PREFIX"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_LUAJIT_JIT_FOLDER_RELATIVE=share/luajit-${NEOTERM_PKG_VERSION:2:3}/jit

neoterm_step_pre_configure() {
	# luajit wants same pointer size for host and target build
	export HOST_CC="gcc"
	if [ $NEOTERM_ARCH_BITS = "32" ]; then
		if [ $(uname) = "Linux" ]; then
			# NOTE: "apt install libc6-dev-i386" for 32-bit headers
			export HOST_CFLAGS="-m32"
			export HOST_LDFLAGS="-m32"
		elif [ $(uname) = "Darwin" ]; then
			export HOST_CFLAGS="-m32 -arch i386"
			export HOST_LDFLAGS="-arch i386"
		fi
	fi
	export TARGET_FLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
	export TARGET_SYS=Linux
	unset CFLAGS LDFLAGS
}

neoterm_step_make_install () {
	mkdir -p $NEOTERM_PREFIX/include/luajit-${NEOTERM_PKG_VERSION:2:3}/
	cp -f $NEOTERM_PKG_SRCDIR/src/{lauxlib.h,lua.h,lua.hpp,luaconf.h,luajit.h,lualib.h} $NEOTERM_PREFIX/include/luajit-${NEOTERM_PKG_VERSION:2:3}/
	rm -f $NEOTERM_PREFIX/lib/libluajit*

	install -Dm600 $NEOTERM_PKG_SRCDIR/src/libluajit.so $NEOTERM_PREFIX/lib/libluajit-5.1.so.2.1.0
	install -Dm600 $NEOTERM_PKG_SRCDIR/src/libluajit.a $NEOTERM_PREFIX/lib/libluajit-5.1.a
	(cd $NEOTERM_PREFIX/lib;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit.so;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit-5.1.so;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit-5.1.so.2;
		ln -s -f libluajit-5.1.a libluajit.a;)

	install -Dm600 $NEOTERM_PKG_SRCDIR/etc/luajit.1 $NEOTERM_PREFIX/share/man/man1/luajit.1
	install -Dm600 $NEOTERM_PKG_SRCDIR/etc/luajit.pc $NEOTERM_PREFIX/lib/pkgconfig/luajit.pc
	install -Dm700 $NEOTERM_PKG_SRCDIR/src/luajit $NEOTERM_PREFIX/bin/luajit

	# Files needed for the -b option (http://luajit.org/running.html) to work.
	# Note that they end up in the 'luajit' subpackage, not the 'libluajit' one.
	local NEOTERM_LUAJIT_JIT_FOLDER=$NEOTERM_PREFIX/$NEOTERM_LUAJIT_JIT_FOLDER_RELATIVE
	rm -Rf $NEOTERM_LUAJIT_JIT_FOLDER
	mkdir -p $NEOTERM_LUAJIT_JIT_FOLDER
	cp $NEOTERM_PKG_SRCDIR/src/jit/*lua $NEOTERM_LUAJIT_JIT_FOLDER
}
