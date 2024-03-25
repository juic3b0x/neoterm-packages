NEOTERM_PKG_HOMEPAGE=https://www.lua.org
NEOTERM_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.1.x)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.1.5
NEOTERM_PKG_SRCURL=https://www.lua.org/ftp/lua-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333
NEOTERM_PKG_BUILD_DEPENDS="readline"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC"
}

neoterm_step_configure() {
	sed -e "s/%VER%/${NEOTERM_PKG_VERSION%.*}/g;s/%REL%/${NEOTERM_PKG_VERSION}/g" \
		-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
		"$NEOTERM_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		MYCFLAGS="$CFLAGS" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

neoterm_step_make_install() {
	make \
		TO_BIN="lua5.1 luac5.1" \
		TO_LIB="liblua5.1.so liblua5.1.so.5.1 liblua5.1.so.${NEOTERM_PKG_VERSION} liblua5.1.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$NEOTERM_PREFIX" \
		INSTALL_INC="$NEOTERM_PREFIX/include/lua5.1" \
		INSTALL_MAN="$NEOTERM_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$NEOTERM_PREFIX"/lib/pkgconfig/lua51.pc

	mv -f "$NEOTERM_PREFIX"/share/man/man1/lua.1 "$NEOTERM_PREFIX"/share/man/man1/lua5.1.1
	mv -f "$NEOTERM_PREFIX"/share/man/man1/luac.1 "$NEOTERM_PREFIX"/share/man/man1/luac5.1.1
}
