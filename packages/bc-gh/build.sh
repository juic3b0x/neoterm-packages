NEOTERM_PKG_HOMEPAGE=https://git.gavinhoward.com/gavin/bc
NEOTERM_PKG_DESCRIPTION="Unix dc and POSIX bc with GNU and BSD extensions"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Gavin D. Howard <gavin@gavinhoward.com>"
NEOTERM_PKG_VERSION=6.7.5
NEOTERM_PKG_SRCURL=https://github.com/gavinhoward/bc/releases/download/${NEOTERM_PKG_VERSION}/bc-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2ec36fefd261a4855b1abbab17bbc9c15837899842bdb3a0a6611d6bb1f01952
NEOTERM_PKG_DEPENDS="readline"

neoterm_step_configure() {
	cd $NEOTERM_PKG_BUILDDIR
	# Without NLS_PATH set like this, bc will complain that the
	# locale files will not be in the right place.
	#
	# GEN_HOST=0 prevents the need for a host compiler.
	#
	# The --predefined-build-type makes bc and dc act like the GNU
	# bc and dc by default, although users can change that at
	# runtime.
	NLS_PATH=$NEOTERM_PREFIX/share/locale/%L/%N GEN_HOST=0 EXECSUFFIX=-gh \
		$NEOTERM_PKG_SRCDIR/configure.sh \
		--predefined-build-type=GNU --enable-readline \
		--disable-nls --prefix=$NEOTERM_PREFIX
}

neoterm_step_make_install() {
	install -Dm700 -T bin/bc $NEOTERM_PREFIX/bin/bc-gh
	ln -sf ./bc-gh $NEOTERM_PREFIX/bin/dc-gh
	chmod 700 $NEOTERM_PREFIX/bin/dc-gh
	install -Dm600 manuals/bc.1 $NEOTERM_PREFIX/share/man/man1/bc-gh.1
	install -Dm600 manuals/dc.1 $NEOTERM_PREFIX/share/man/man1/dc-gh.1
}
