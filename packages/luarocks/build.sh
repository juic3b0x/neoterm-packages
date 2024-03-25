NEOTERM_PKG_HOMEPAGE=https://luarocks.org/
NEOTERM_PKG_DESCRIPTION="Deployment and management system for Lua modules"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.9.2
NEOTERM_PKG_SRCURL=https://luarocks.org/releases/luarocks-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bca6e4ecc02c203e070acdb5f586045d45c078896f6236eb46aa33ccd9b94edb
__LUA_VERSION=5.1 # Lua version against which it will be built.
# Do not use varible here since buildorder.py do not evaluate bash before reading.
NEOTERM_PKG_DEPENDS="curl, lua51"
NEOTERM_PKG_BUILD_DEPENDS="liblua51"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_configure() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" != true ]; then
		# Create temporary symlink to workaround luarock bootstrap
		# script trying to run cross-compiled lua
		mv "$NEOTERM_PREFIX"/bin/lua"$__LUA_VERSION"{,.bak}
		ln -sf /usr/bin/lua"$__LUA_VERSION" "$NEOTERM_PREFIX"/bin/lua"$__LUA_VERSION"
	fi

	./configure --prefix="$NEOTERM_PREFIX" \
		--with-lua="$NEOTERM_PREFIX"
}

neoterm_step_post_make_install() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" != "true" ]; then
		# Restore lua
		unlink "$NEOTERM_PREFIX"/bin/lua"$__LUA_VERSION"
		mv "$NEOTERM_PREFIX"/bin/lua"$__LUA_VERSION"{.bak,}
	fi
}

neoterm_step_post_massage() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" != true ]; then
		# Remove lua, due to us moving it back and fourth, the build system
		# thinks it is a newly compiled package.
		rm bin/lua"$__LUA_VERSION"
	fi
}
