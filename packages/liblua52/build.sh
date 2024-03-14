NEOTERM_PKG_HOMEPAGE=https://www.lua.org
NEOTERM_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.2.x)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.2.4
NEOTERM_PKG_REVISION=8
NEOTERM_PKG_SRCURL=https://www.lua.org/ftp/lua-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=b9e2e4aad6789b3b63a056d442f7b39f0ecfca3ae0f1fc0ae4e9614401b69f4b
NEOTERM_PKG_BREAKS="liblua52-dev"
NEOTERM_PKG_REPLACES="liblua52-dev"
NEOTERM_PKG_BUILD_DEPENDS="readline"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	sed -e "s/%VER%/${NEOTERM_PKG_VERSION%.*}/g;s/%REL%/${NEOTERM_PKG_VERSION}/g" \
		-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
		"$NEOTERM_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		MYCFLAGS="$CFLAGS -fPIC" \
		MYLDFLAGS="$LDFLAGS" \
		CC="$CC" \
		CXX="$CXX" \
		linux
}

neoterm_step_make_install() {
	make \
		TO_BIN="lua5.2 luac5.2" \
		TO_LIB="liblua5.2.so liblua5.2.so.5.2 liblua5.2.so.${NEOTERM_PKG_VERSION} liblua5.2.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$NEOTERM_PREFIX" \
		INSTALL_INC="$NEOTERM_PREFIX/include/lua5.2" \
		INSTALL_MAN="$NEOTERM_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$NEOTERM_PREFIX"/lib/pkgconfig/lua52.pc

	mv -f "$NEOTERM_PREFIX"/share/man/man1/lua.1 "$NEOTERM_PREFIX"/share/man/man1/lua5.2.1
	mv -f "$NEOTERM_PREFIX"/share/man/man1/luac.1 "$NEOTERM_PREFIX"/share/man/man1/luac5.2.1
}
