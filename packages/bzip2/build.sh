NEOTERM_PKG_HOMEPAGE=http://www.bzip.org/
NEOTERM_PKG_DESCRIPTION="BZ2 format compression library"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.8
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=47fd74b2ff83effad0ddf62074e6fad1f6b4a77a96e121ab421c20a216371a1f
NEOTERM_PKG_BREAKS="libbz2-dev"
NEOTERM_PKG_REPLACES="libbz2-dev"
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $NEOTERM_PKG_SRCDIR/Makefile
}

neoterm_step_make() {
	# bzip2 uses a separate makefile for the shared library
	make -f Makefile-libbz2_so
}

neoterm_step_make_install() {
	# The shared library makefile contains no install makefile, so issue a normal install to get scripts
	make $NEOTERM_PKG_EXTRA_MAKE_ARGS install

	# Clean out statically linked binaries and libs and replace them with shared ones:
	rm -Rf $NEOTERM_PREFIX/lib/libbz2*
	rm -Rf $NEOTERM_PREFIX/bin/{bzcat,bunzip2}
	cp bzip2-shared $NEOTERM_PREFIX/bin/bzip2
	cp libbz2.so.${NEOTERM_PKG_VERSION} $NEOTERM_PREFIX/lib
	(cd $NEOTERM_PREFIX/lib && ln -s libbz2.so.${NEOTERM_PKG_VERSION} libbz2.so.1.0)
	(cd $NEOTERM_PREFIX/lib && ln -s libbz2.so.${NEOTERM_PKG_VERSION} libbz2.so)
	(cd $NEOTERM_PREFIX/bin && ln -s bzip2 bzcat)
	(cd $NEOTERM_PREFIX/bin && ln -s bzip2 bunzip2)
	# bzgrep should be enough so remove bz{e,f}grep
	rm $NEOTERM_PREFIX/bin/bz{e,f}grep $NEOTERM_PREFIX/share/man/man1/bz{e,f}grep.1
}
