NEOTERM_PKG_HOMEPAGE=https://www.lua.org/
NEOTERM_PKG_DESCRIPTION="Shared library for the Lua interpreter"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.4.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.lua.org/ftp/lua-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88
NEOTERM_PKG_EXTRA_MAKE_ARGS=linux-readline
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BREAKS="liblua-dev"
NEOTERM_PKG_REPLACES="liblua-dev"
NEOTERM_PKG_BUILD_DEPENDS="readline"

neoterm_step_configure() {
	sed -e "s/%VER%/${NEOTERM_PKG_VERSION%.*}/g;s/%REL%/${NEOTERM_PKG_VERSION}/g" \
		-e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" \
		"$NEOTERM_PKG_BUILDER_DIR"/lua.pc.in > lua.pc
}

neoterm_step_pre_configure() {
	OLDAR="$AR"
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_3"
	export MYLDFLAGS=$LDFLAGS
}

neoterm_step_make_install() {
	make \
		TO_BIN="lua5.4 luac5.4" \
		TO_LIB="liblua5.4.so liblua5.4.so.5.4 liblua5.4.so.${NEOTERM_PKG_VERSION} liblua5.4.a" \
		INSTALL_DATA="cp -d" \
		INSTALL_TOP="$NEOTERM_PREFIX" \
		INSTALL_INC="$NEOTERM_PREFIX/include/lua5.4" \
		INSTALL_MAN="$NEOTERM_PREFIX/share/man/man1" \
		install
	install -Dm600 lua.pc "$NEOTERM_PREFIX"/lib/pkgconfig/lua54.pc
}

neoterm_step_post_make_install() {
	cd "$NEOTERM_PREFIX"/share/man/man1
	mv -f lua.1 lua5.4.1
	mv -f luac.1 luac5.4.1
	export AR="$OLDAR"
}
