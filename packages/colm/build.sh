NEOTERM_PKG_HOMEPAGE=https://www.colm.net/open-source/colm/
NEOTERM_PKG_DESCRIPTION="COmputer Language Machinery"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.14.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.colm.net/files/colm/colm-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6037b31c358dda6f580f7321f97a182144a8401c690b458fcae055c65501977d
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	rm -f src/config.h src/defs.h
	ln -sf . src/colm
}

neoterm_step_host_build() {
	local srcdir=$NEOTERM_PKG_SRCDIR
	${srcdir}/configure
	local f
	for f in ${srcdir}/src/*.lm; do
		ln -sf ${f} src/$(basename ${f})
	done
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/src:$PATH

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
