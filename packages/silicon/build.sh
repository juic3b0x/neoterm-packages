NEOTERM_PKG_HOMEPAGE=https://github.com/Aloxaf/silicon
NEOTERM_PKG_DESCRIPTION="Silicon is an alternative to Carbon implemented in Rust"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@neoterm.dev>"
NEOTERM_PKG_VERSION="0.5.2"
NEOTERM_PKG_SRCURL=https://github.com/Aloxaf/silicon/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=815d41775dd9cd399650addf8056f803f3f57e68438e8b38445ee727a56b4b2d
NEOTERM_PKG_DEPENDS="fontconfig, harfbuzz"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_rust

	# Dummy CMake toolchain file to workaround build error:
	# error: failed to run custom build command for `freetype-sys v0.13.1`
	# ...
	# CMake Error at /home/builder/.neoterm-build/_cache/cmake-3.27.5/share/cmake-3.27/Modules/Platform/Android-Determine.cmake:217 (message):
	# Android: Neither the NDK or a standalone toolchain was found.
	export TARGET_CMAKE_TOOLCHAIN_FILE="${NEOTERM_PKG_BUILDDIR}/android.toolchain.cmake"
	touch "${NEOTERM_PKG_BUILDDIR}/android.toolchain.cmake"
}

neoterm_step_make() {
	cargo build --jobs $NEOTERM_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

neoterm_step_make_install() {
	install -Dm755 -t $NEOTERM_PREFIX/bin target/${CARGO_TARGET_NAME}/release/silicon
}
