NEOTERM_PKG_HOMEPAGE=https://github.com/luvit/luv
NEOTERM_PKG_DESCRIPTION="Bare libuv bindings for lua"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.48.0-2"
NEOTERM_PKG_SRCURL=https://github.com/luvit/luv/releases/download/$NEOTERM_PKG_VERSION/luv-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=2c3a1ddfebb4f6550293a40ee789f7122e97647eede51511f57203de48c03b7a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libluajit, libuv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_MODULE=OFF
-DBUILD_SHARED_LIBS=ON
-DLUA_BUILD_TYPE=System
-DLUAJIT_INCLUDE_DIR=$NEOTERM_PREFIX/include/luajit-2.1
-DLUA_PACKAGE_DIR=$NEOTERM_PREFIX/lib/lua/5.1
-DWITH_LUA_ENGINE=LuaJit
-DWITH_SHARED_LIBUV=ON
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(sed -En 's/^set\(LUV_VERSION_MAJOR\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	export LDFLAGS+=" -L$NEOTERM_PREFIX/lib/lua/5.1"
}
