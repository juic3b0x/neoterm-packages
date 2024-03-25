NEOTERM_PKG_HOMEPAGE=https://github.com/google/glog
NEOTERM_PKG_DESCRIPTION="Logging library for C++"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.0"
NEOTERM_PKG_SRCURL=https://github.com/google/glog/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=375106b5976231b92e66879c1a92ce062923b9ae573c42b56ba28b112ee4cc11
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gflags, libc++"
NEOTERM_PKG_BUILD_DEPENDS="gflags-static"
NEOTERM_PKG_BREAKS="google-glog-dev"
NEOTERM_PKG_REPLACES="google-glog-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^\s*set_target_properties\s*\(glog\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -llog"
}

neoterm_step_post_make_install() {
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/libglog.pc.in \
		"$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@prefix@|$NEOTERM_PREFIX|g" "$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@exec_prefix@|$NEOTERM_PREFIX|g" "$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@libdir@|$NEOTERM_PREFIX/lib|g" "$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@includedir@|$NEOTERM_PREFIX/include|g" "$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
	sed -i "s|@VERSION@|$NEOTERM_PKG_VERSION|g" "$NEOTERM_PREFIX"/lib/pkgconfig/libglog.pc
}
