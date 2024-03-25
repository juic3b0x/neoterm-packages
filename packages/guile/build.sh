NEOTERM_PKG_HOMEPAGE=http://www.gnu.org/software/guile/
NEOTERM_PKG_DESCRIPTION="Portable, embeddable Scheme implementation written in C"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.9
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/guile/guile-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=18525079ad29a0d46d15c76581b5d91c8702301bfd821666d2e1d13726162811
NEOTERM_PKG_DEPENDS="libandroid-spawn, libandroid-support, libffi, libgc, libgmp, libiconv, libunistring, ncurses, readline"
NEOTERM_PKG_BUILD_DEPENDS="libtool"
NEOTERM_PKG_BREAKS="guile-dev"
NEOTERM_PKG_REPLACES="guile-dev"
NEOTERM_PKG_CONFLICTS="guile18"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_type_complex_double=no ac_cv_search_clock_getcpuclockid=false ac_cv_func_GC_move_disappearing_link=yes ac_cv_func_GC_is_heap_ptr=yes"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true

# https://github.com/juic3b0x/neoterm-packages/issues/14806
NEOTERM_PKG_NO_STRIP=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
LIBS=-landroid-spawn
ac_cv_func_posix_spawn=yes
ac_cv_func_posix_spawnp=yes
gl_cv_func_posix_spawn_works=yes
gl_cv_func_posix_spawnp_secure_exec=yes
"

neoterm_step_host_build() {
	mkdir HOSTBUILDINSTALL

	../src/configure --prefix=$NEOTERM_PKG_HOSTBUILD_DIR/HOSTBUILDINSTALL # CFLAGS="-m32" LDFLAGS=" -L/usr/lib/i386-linux-gnu" --host=i386-linux-gnu
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	export GUILE_FOR_BUILD="$NEOTERM_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/bin/guile
	export LD_LIBRARY_PATH="$NEOTERM_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/lib

	export CC_FOR_BUILD="gcc -m${NEOTERM_ARCH_BITS}"

	# Value of PKG_CONFIG becomes hardcoded in bin/*-config
	export PKG_CONFIG=pkg-config
}

neoterm_step_post_configure() {
	cp $NEOTERM_PKG_BUILDER_DIR/malloc.h $NEOTERM_PKG_BUILDDIR/lib/
}
