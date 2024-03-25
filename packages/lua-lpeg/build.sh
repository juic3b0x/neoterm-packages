NEOTERM_PKG_HOMEPAGE=http://www.inf.puc-rio.br/~roberto/lpeg
NEOTERM_PKG_DESCRIPTION="Pattern-matching library for Lua 5.3"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.0
NEOTERM_PKG_SRCURL=http://www.inf.puc-rio.br/~roberto/lpeg/lpeg-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4b155d67d2246c1ffa7ad7bc466c1ea899bbc40fef0257cc9c03cecbaed4352a
NEOTERM_PKG_DEPENDS="liblua53"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS -fPIC -I$NEOTERM_PREFIX/include/lua5.3" \
		LDFLAGS="$LDFLAGS -L$NEOTERM_PREFIX/lib/lua/5.3 -llua5.3" \
		LUADIR="$NEOTERM_PREFIX"/include/lua/5.3
}

neoterm_step_make_install() {
	install -Dm600 lpeg.so "$NEOTERM_PREFIX"/lib/lua/5.3/lpeg.so
	install -Dm600 re.lua "$NEOTERM_PREFIX"/share/lua/5.3/re.lua
}
