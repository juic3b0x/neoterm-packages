NEOTERM_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3key.html
NEOTERM_PKG_DESCRIPTION="A library and database with escape sequence to key symbol mappings"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.10
NEOTERM_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3key-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=b3f63c8a5bdf4efc10a293e5124a4a1095af6149af96b0a10b3ce7da7400f8c1
NEOTERM_PKG_DEPENDS="libt3config, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	local LIBT3CONFIG_BUILD_SH=$NEOTERM_SCRIPTDIR/packages/libt3config/build.sh
	local LIBT3CONFIG_SRCURL=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$NEOTERM_PKG_SRCURL")
	local LIBT3CONFIG_SHA256=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$NEOTERM_PKG_SHA256")
	local LIBT3CONFIG_TARFILE=$NEOTERM_PKG_CACHEDIR/$(basename $LIBT3CONFIG_SRCURL)
	neoterm_download $LIBT3CONFIG_SRCURL $LIBT3CONFIG_TARFILE $LIBT3CONFIG_SHA256

	mkdir -p libt3config
	pushd libt3config
	tar xf $LIBT3CONFIG_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	popd

	mkdir -p libt3key
	pushd libt3key
	find $NEOTERM_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext \
		LDFLAGS="-Wl,-rpath=$_PREFIX_FOR_BUILD/lib"
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	popd

	unset PKG_CONFIG_PATH
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	export PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	local libtooldir=$NEOTERM_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$NEOTERM_SCRIPTDIR/scripts/config.sub" ./
	cp "$NEOTERM_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$NEOTERM_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
