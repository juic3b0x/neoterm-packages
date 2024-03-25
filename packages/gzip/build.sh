NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gzip/
NEOTERM_PKG_DESCRIPTION="Standard GNU file compression utilities"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.13
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gzip/gzip-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7454eb6935db17c6655576c2e1b0fabefd38b4d0936e0f87f48cd062ce91a057
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_GREP=grep"
NEOTERM_PKG_GROUPS="base-devel"

neoterm_step_pre_configure() {
	if [ $NEOTERM_ARCH = i686 ]; then
		# Avoid text relocations
		export DEFS="NO_ASM"
	fi
}
