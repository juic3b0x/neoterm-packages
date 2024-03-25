NEOTERM_PKG_HOMEPAGE=https://github.com/dvorka/hstr
NEOTERM_PKG_DESCRIPTION="Shell history suggest box for bash and zsh"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.1
NEOTERM_PKG_SRCURL=https://github.com/dvorka/hstr/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e5293d4fe2502662f19c793bef416e05ac020490218e71c75a5e92919c466071
NEOTERM_PKG_DEPENDS="ncurses, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__tmp_hstr_ms_wsl=no
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
