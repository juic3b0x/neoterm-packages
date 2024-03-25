NEOTERM_PKG_HOMEPAGE=https://ziglang.org
NEOTERM_PKG_DESCRIPTION="General-purpose programming language and toolchain"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="zig/LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.11.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/ziglang/zig-bootstrap/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=046cede54ae0627c6ac98a1b3915242b35bc550ac7aaec3ec4cef6904c95019e
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	neoterm_setup_cmake
	neoterm_setup_ninja
	neoterm_setup_zig
}

neoterm_step_make() {
	# zig 0.11.0+ uses 3 stages bootstrapping build system
	# which NDK cant be used anymore
	unset AS CC CFLAGS CPP CPPFLAGS CXX CXXFLAGS LD LDFLAGS

	# build.patch skipped various steps to make CI build <6 hours
	./build "${ZIG_TARGET_NAME}" baseline
}

neoterm_step_make_install() {
	cp -fr "out/zig-${ZIG_TARGET_NAME}-baseline" "${NEOTERM_PREFIX}/lib/zig"
	ln -fsv "../lib/zig/zig" "${NEOTERM_PREFIX}/bin/zig"
}
