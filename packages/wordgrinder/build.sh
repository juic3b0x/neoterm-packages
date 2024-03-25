NEOTERM_PKG_HOMEPAGE=http://cowlark.com/wordgrinder/
NEOTERM_PKG_DESCRIPTION="A Unicode-aware character cell word processor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="licenses/COPYING.Lua, licenses/COPYING.LuaBitOp, licenses/COPYING.LuaFileSystem, licenses/COPYING.Minizip, licenses/COPYING.Scowl, licenses/COPYING.uthash, licenses/COPYING.wcwidth, licenses/COPYING.WordGrinder, licenses/COPYING.xpattern"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8
NEOTERM_PKG_SRCURL=https://github.com/davidgiven/wordgrinder/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=856cbed2b4ccd5127f61c4997a30e642d414247970f69932f25b4b5a81b18d3f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="liblua53, ncurses, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_ninja

	# Missing and causes install failure.
	touch licenses/COPYING.LuaFileSystem

	make CC=gcc OBJDIR="$PWD/build" "$PWD"/build/lua
	make OBJDIR="$PWD/build" LUA_PACKAGE=lua53
}

neoterm_step_make_install() {
	install -Dm700 \
		"$NEOTERM_PKG_SRCDIR"/bin/wordgrinder-lua53-curses-release \
		"$NEOTERM_PREFIX"/bin/wordgrinder
	install -Dm600 \
		"$NEOTERM_PKG_SRCDIR"/bin/wordgrinder.1 \
		"$NEOTERM_PREFIX"/share/man/man1/
}
