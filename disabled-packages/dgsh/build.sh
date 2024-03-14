NEOTERM_PKG_HOMEPAGE=https://www.spinellis.gr/sw/dgsh/
NEOTERM_PKG_DESCRIPTION="The directed graph shell"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_SRCURL=https://github.com/dspinellis/dgsh/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=22a7f2794e1287a46b03ce38c27a1d9349d1c66535c30e065c8783626555c76c
NEOTERM_PKG_BUILD_DEPENDS="check"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR=$NEOTERM_PKG_SRCDIR/core-tools
	NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_SRCDIR
	cd $NEOTERM_PKG_BUILDDIR

	sed -i -e 's/#.*$//g' src/dgsh-elf.s
	cp $NEOTERM_PKG_BUILDER_DIR/s_cpow.c src/

	touch ../.config
	mkdir -p m4
	autoreconf -fi
}
