NEOTERM_PKG_HOMEPAGE=https://github.com/zigtools/zls
NEOTERM_PKG_DESCRIPTION="Zig language server"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@SunPodder"
NEOTERM_PKG_VERSION=0.11.0
NEOTERM_PKG_SRCURL="https://github.com/zigtools/zls/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=09fee5720fed9f3e1f494236ba88bf9176d3a01304feaa355b9f4726a574431b
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_zig
	zig build -Dtarget=$ZIG_TARGET_NAME -Doptimize=ReleaseSafe
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin zig-out/bin/zls
}
