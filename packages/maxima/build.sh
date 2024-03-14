NEOTERM_PKG_HOMEPAGE="https://maxima.sourceforge.io/"
NEOTERM_PKG_DESCRIPTION="A Computer Algebra System"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Marlin Sööse <marlin.soose@laro.se>"
NEOTERM_PKG_VERSION=()
NEOTERM_PKG_VERSION+=(5.47.0)
NEOTERM_PKG_VERSION+=(23.9.9) # ECL version
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=(https://downloads.sourceforge.net/sourceforge/maxima/Maxima-source/$NEOTERM_PKG_VERSION-source/maxima-$NEOTERM_PKG_VERSION.tar.gz
                   https://common-lisp.net/project/ecl/static/files/release/ecl-${NEOTERM_PKG_VERSION[1]}.tgz)
NEOTERM_PKG_SHA256=(9104021b24fd53e8c03a983509cb42e937a925e8c0c85c335d7709a14fd40f7a
                   c51bdab4ca6c1173dd3fe9cfe9727bcefb97bb0a3d6434b627ca6bdaeb33f880)
NEOTERM_PKG_DEPENDS="ecl"
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"
NEOTERM_PKG_BUILD_IN_SRC="true"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-ecl"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	mv ecl-${NEOTERM_PKG_VERSION[1]} ecl
}

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	mkdir ecl
	pushd ecl
	local ecl_srcdir=$NEOTERM_PKG_SRCDIR/ecl/src
	autoreconf -fi $ecl_srcdir/gmp
	$ecl_srcdir/configure ABI=${NEOTERM_ARCH_BITS} \
		CFLAGS=-m${NEOTERM_ARCH_BITS} LDFLAGS=-m${NEOTERM_ARCH_BITS} \
		--prefix=$_PREFIX_FOR_BUILD --srcdir=$ecl_srcdir --disable-c99complex
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	popd

	PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	mkdir maxima
	pushd maxima
	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 ! -name ecl -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD $NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
	make -j $NEOTERM_MAKE_PROCESSES
	popd
}

neoterm_step_make() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	
	cat > $_PREFIX_FOR_BUILD/bin/gcc <<-EOF
		#!/bin/sh
		exec \$CC \$CFLAGS \$CPPFLAGS \$LDFLAGS "\$@" -Wno-unused-command-line-argument
	EOF
	chmod 0700 $_PREFIX_FOR_BUILD/bin/gcc
	local loop_max=1000
	local f
	local i=0
	while [ ! -e src/binary-ecl/maxima ]; do
		make -C src
		for f in $(find src/binary-ecl -type f -name '*.fas'); do
			cp $NEOTERM_PKG_HOSTBUILD_DIR/maxima/$f $f
		done
		i=$(( $i + 1 ))
		if [ $i -gt $loop_max ]; then
			return 1
		fi
	done
	make
	rm -f $_PREFIX_FOR_BUILD/bin/gcc
}
