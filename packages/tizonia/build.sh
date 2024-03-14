NEOTERM_PKG_HOMEPAGE=https://github.com/tizonia/
NEOTERM_PKG_DESCRIPTION="A command-line streaming music client/server for Linux"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.22.0
NEOTERM_PKG_REVISION=14
NEOTERM_PKG_SRCURL=https://github.com/tizonia/tizonia-openmax-il/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0750cae23ed600fb4b4699a392f43a5e03dcd0870383d64da4b8c28ea94a82f8
NEOTERM_PKG_DEPENDS="boost, dbus, libandroid-wordexp, libc++, libcurl, libflac, liblog4c, libmad, libmediainfo, libmp3lame, liboggz, libopus, libsndfile, libsqlite, libuuid, libvpx, mpg123, opusfile, pulseaudio, python, taglib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, libev"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	local srcdir="$NEOTERM_PKG_SRCDIR"/3rdparty/dbus-cplusplus
	autoreconf -fi "$srcdir"
	"$srcdir"/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	
	install -Dm700 $NEOTERM_PKG_BUILDER_DIR/exe_wrapper $_PREFIX_FOR_BUILD/bin/
	PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	export BOOST_ROOT=$NEOTERM_PREFIX
	LDFLAGS+=" -landroid-wordexp"
}

neoterm_step_configure_meson() {
	neoterm_setup_meson
	sed -i 's/^\(\[binaries\]\)$/\1\nexe_wrapper = '\'exe_wrapper\''/g' \
		$NEOTERM_MESON_CROSSFILE
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $NEOTERM_MESON \
		$NEOTERM_PKG_SRCDIR \
		$NEOTERM_PKG_BUILDDIR \
		--cross-file $NEOTERM_MESON_CROSSFILE \
		--prefix $NEOTERM_PREFIX \
		--libdir lib \
		--buildtype minsize \
		--strip \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}
