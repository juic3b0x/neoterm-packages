NEOTERM_PKG_HOMEPAGE=https://github.com/facebook/zstd
NEOTERM_PKG_DESCRIPTION="Zstandard compression"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.5"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/facebook/zstd/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=98e9c3d949d1b924e28e01eccb7deed865eefebf25c2f21c702e5cd5b63b85e1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="liblzma, zlib"
NEOTERM_PKG_BREAKS="zstd-dev"
NEOTERM_PKG_REPLACES="zstd-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefault_library=both
-Dbin_programs=true
-Dbin_tests=false
-Dbin_contrib=true
-Dzlib=enabled
-Dlzma=enabled
-Dlz4=disabled
"

# Is this needed?
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/zstd-frugal
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/build/meson"

	# SOVERSION suffix is needed for backward compatibility. Do not remove
	# this (and the guard in the post-massage step) unless you know what
	# you are doing. `zstd` is a dependency of `apt` to which something
	# catastrophic could happen if you are careless.
	export NEOTERM_MESON_ENABLE_SOVERSION=1
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libzstd.so.1"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
