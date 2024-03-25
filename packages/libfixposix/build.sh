NEOTERM_PKG_HOMEPAGE=https://github.com/sionescu/libfixposix/
NEOTERM_PKG_DESCRIPTION="Thin wrapper over POSIX syscalls"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.1
NEOTERM_PKG_SRCURL=https://github.com/sionescu/libfixposix/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5d9d3d321d4c7302040389c43f966a70d180abb58d1d7df370f39e0d402d50d4
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_decl_TIOCSCTTY=yes
ac_cv_prog_PKGCONFIG=yes
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
