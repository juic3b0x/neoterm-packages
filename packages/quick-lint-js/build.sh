NEOTERM_PKG_HOMEPAGE=https://quick-lint-js.com/
NEOTERM_PKG_DESCRIPTION="Finds bugs in JavaScript programs"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.2.0"
NEOTERM_PKG_SRCURL=git+https://github.com/quick-lint/quick-lint-js
NEOTERM_PKG_GIT_BRANCH=$NEOTERM_PKG_VERSION
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_TESTING=OFF -DQUICK_LINT_JS_USE_BUILD_TOOLS=$NEOTERM_PKG_HOSTBUILD_DIR/build-tools/"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	# https://quick-lint-js.com/contribute/build-from-source/cross-compiling/
	neoterm_setup_cmake
	cmake -DCMAKE_BUILD_TYPE=Release -S "$NEOTERM_PKG_SRCDIR" -B build-tools $NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -C build-tools quick-lint-js-build-tools $NEOTERM_PKG_EXTRA_MAKE_ARGS
}
