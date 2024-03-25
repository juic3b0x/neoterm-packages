NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
NEOTERM_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages (legacy v2.13)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.13
NEOTERM_PKG_SRCURL=http://ftp.gnu.org/gnu/autoconf/autoconf-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e
NEOTERM_PKG_DEPENDS="m4, make, perl"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--program-suffix=-2.13"

neoterm_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$NEOTERM_PREFIX/bin/sh|" *.m4
}

neoterm_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$NEOTERM_PREFIX/bin/m4|" $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$NEOTERM_PREFIX/bin/sh|" $NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/bin/autoconf-2.13
}
