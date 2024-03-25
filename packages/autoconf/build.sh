NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
NEOTERM_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.72"
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/autoconf/autoconf-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ba885c1319578d6c94d46e9b0dceb4014caafe2490e437a0dbca3f270a223f5a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="m4, make, perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_GROUPS="base-devel"

neoterm_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$NEOTERM_PREFIX/bin/sh|" lib/*/*.m4
}

neoterm_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$NEOTERM_PREFIX/bin/m4|" bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$NEOTERM_PREFIX/bin/sh|" bin/autoconf
}
