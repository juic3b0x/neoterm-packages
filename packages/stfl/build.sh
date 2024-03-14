NEOTERM_PKG_HOMEPAGE=http://www.clifford.at/stfl
NEOTERM_PKG_DESCRIPTION="Structured Terminal Forms Language/Library"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.24
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://grimler.se/neoterm/stfl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d4a7aa181a475aaf8a8914a8ccb2a7ff28919d4c8c0f8a061e17a0c36869c090
NEOTERM_PKG_DEPENDS="libandroid-support, libiconv, ncurses"
NEOTERM_PKG_BREAKS="stfl-dev"
NEOTERM_PKG_REPLACES="stfl-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure(){
	# mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h
	sed -i 's/FOUND_RUBY = 1/FOUND_RUBY = 0/g' Makefile.cfg
	
	# /usr/bin/ld: ../libstfl.a(public.o): Relocations in generic ELF (EM: 183)
	# /usr/bin/ld: ../libstfl.a: error adding symbols: file in wrong format
	sed -i 's/FOUND_PERL5 = 1/FOUND_PERL5 = 0/g' Makefile.cfg

	CPPFLAGS+=" -DNCURSES_WIDECHAR"
}

neoterm_step_configure() {
	CC+=" $CPPFLAGS"
	export LDLIBS="-liconv"
}
