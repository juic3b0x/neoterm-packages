NEOTERM_PKG_HOMEPAGE=https://www.colm.net/open-source/ragel/
NEOTERM_PKG_DESCRIPTION="Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=7.0.4
NEOTERM_PKG_SRCURL=https://www.colm.net/files/ragel/ragel-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=84b1493efe967e85070c69e78b04dc55edc5c5718f9d6b77929762cb2abed278
NEOTERM_PKG_DEPENDS="colm, libc++"
NEOTERM_PKG_BUILD_DEPENDS="colm-static"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-colm=$NEOTERM_PREFIX
--disable-manual
"

neoterm_step_host_build() {
	local COLM_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/colm/build.sh
	local COLM_SRCURL=$(. $COLM_BUILD_SH; echo $NEOTERM_PKG_SRCURL)
	local COLM_SHA256=$(. $COLM_BUILD_SH; echo $NEOTERM_PKG_SHA256)
	local COLM_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $COLM_SRCURL)
	neoterm_download $COLM_SRCURL $COLM_TARFILE $COLM_SHA256
	tar xf $COLM_TARFILE --strip-components=1
	rm -f src/config.h src/defs.h
	ln -sf . src/colm
	sed -i '/^SUBDIRS =/s/ test//' Makefile.in
	./configure
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	local colm_bin_dir=$NEOTERM_PKG_HOSTBUILD_DIR/src
	echo "Applying configure.diff"
	sed "s|@COLM_BIN_DIR@|${colm_bin_dir}|g" \
		$NEOTERM_PKG_BUILDER_DIR/configure.diff | patch --silent -p1
	local libgcc=$($CC -print-libgcc-file-name)
	export LIBS="-L$(dirname ${libgcc}) -l:$(basename ${libgcc})"
}
