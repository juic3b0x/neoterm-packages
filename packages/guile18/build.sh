NEOTERM_PKG_HOMEPAGE=http://www.gnu.org/software/guile/
NEOTERM_PKG_DESCRIPTION="Portable, embeddable Scheme implementation written in C. (legacy branch)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.8
NEOTERM_PKG_REVISION=16
NEOTERM_PKG_SRCURL=ftp://ftp.gnu.org/pub/gnu/guile/guile-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050
NEOTERM_PKG_DEPENDS="libcrypt, libgmp, libltdl, ncurses, readline"
NEOTERM_PKG_BUILD_DEPENDS="libtool"
NEOTERM_PKG_BREAKS="guile18-dev"
NEOTERM_PKG_REPLACES="guile18-dev"
NEOTERM_PKG_CONFLICTS="guile"
NEOTERM_PKG_HOSTBUILD=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--program-suffix=1.8
--disable-error-on-warning"

neoterm_step_host_build() {
	mkdir HOSTBUILDINSTALL

	CFLAGS=" -O1" ../src/configure \
		--prefix="$NEOTERM_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL \
		--program-suffix=1.8 \
		--disable-error-on-warning

	make -j "$NEOTERM_MAKE_PROCESSES"
	make install
}

neoterm_step_pre_configure() {
	CFLAGS=${CFLAGS/Oz/Os}

	if [ $NEOTERM_ARCH = "i686" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --without-threads"
	fi

	export GUILE_FOR_BUILD="$NEOTERM_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/bin/guile1.8
	export LD_LIBRARY_PATH="$NEOTERM_PKG_HOSTBUILD_DIR"/HOSTBUILDINSTALL/lib
}

neoterm_step_post_make_install() {
	sed -i '1s/guile/guile1.8/' -i "$NEOTERM_PREFIX"/bin/guile-config1.8
	mv -f \
		"$NEOTERM_PREFIX"/share/aclocal/guile.m4 \
		"$NEOTERM_PREFIX"/share/aclocal/guile18.m4
}
