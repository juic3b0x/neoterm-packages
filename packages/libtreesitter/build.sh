NEOTERM_PKG_HOMEPAGE=https://github.com/tree-sitter/tree-sitter
NEOTERM_PKG_DESCRIPTION="An incremental parsing system for programming tools"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.21.0-pre-release-1"
NEOTERM_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2e231021af39a188ea6de8c3c20800e366bee2e8fa477ae33681dc9de0731a3b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/^SONAME_MAJOR\s*:?=\s*([0-9]+).*/\1/p' \
			Makefile)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_make_install() {
	neoterm_setup_rust

	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release

	install -Dm700 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tree-sitter
}
