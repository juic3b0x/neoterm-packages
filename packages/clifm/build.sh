NEOTERM_PKG_HOMEPAGE=https://github.com/leo-arch/clifm
NEOTERM_PKG_DESCRIPTION="The shell-like, command line terminal file manager: simple, fast, extensible, and lightweight as hell"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.17"
NEOTERM_PKG_SRCURL=https://github.com/leo-arch/clifm/releases/download/v${NEOTERM_PKG_VERSION}/clifm-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c6b64bbbdb4f1c7a752db004150ac3a773696624ec62d8d33204b259e810421f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcap, libacl, readline, file, libandroid-glob, libandroid-support"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-f misc/neoterm/Makefile"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
