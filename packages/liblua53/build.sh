NEOTERM_PKG_HOMEPAGE=https://www.lua.org/
NEOTERM_PKG_DESCRIPTION="Shared library for the Lua interpreter (v5.3.x)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.3.6
NEOTERM_PKG_SRCURL=https://www.lua.org/ftp/lua-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fc5fd69bb8736323f026672b1b7235da613d7177e72558893a0bdcd320466d60
NEOTERM_PKG_EXTRA_MAKE_ARGS=linux
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BREAKS="liblua-dev, liblua (<< 5.3.5-6)"
NEOTERM_PKG_REPLACES="liblua-dev, liblua (<< 5.3.5-6)"
NEOTERM_PKG_BUILD_DEPENDS="readline"

neoterm_step_configure() {
	sed -e "s/%VER%/${NEOTERM_PKG_VERSION%.*}/g;s/%REL%/${NEOTERM_PKG_VERSION}/g" \
		-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
		"$NEOTERM_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

neoterm_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_UNPACK"
	export MYLDFLAGS=$LDFLAGS
}

neoterm_step_make_install() {
	make \
		TO_BIN="lua5.3 luac5.3" \
		TO_LIB="liblua5.3.so liblua5.3.so.5.3 liblua5.3.so.${NEOTERM_PKG_VERSION} liblua5.3.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$NEOTERM_PREFIX" \
		INSTALL_INC="$NEOTERM_PREFIX/include/lua5.3" \
		INSTALL_MAN="$NEOTERM_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$NEOTERM_PREFIX"/lib/pkgconfig/lua53.pc
}

neoterm_step_post_make_install() {
	cd "$NEOTERM_PREFIX"/share/man/man1
	mv -f lua.1 lua5.3.1
	mv -f luac.1 luac5.3.1
	export AR="$OLDAR"
}
