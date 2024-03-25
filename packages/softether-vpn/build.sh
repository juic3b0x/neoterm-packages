NEOTERM_PKG_HOMEPAGE=https://www.softether.org/
NEOTERM_PKG_DESCRIPTION="An open-source cross-platform multi-protocol VPN program"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=(5.02.5180)
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_VERSION+=(1.0.18)
NEOTERM_PKG_SRCURL=(https://github.com/SoftEtherVPN/SoftEtherVPN/releases/download/${NEOTERM_PKG_VERSION}/SoftEtherVPN-${NEOTERM_PKG_VERSION}.tar.xz
                   https://github.com/jedisct1/libsodium/archive/${NEOTERM_PKG_VERSION[1]}-RELEASE.tar.gz)
NEOTERM_PKG_SHA256=(b5649a8ea3cc6477325e09e2248ef708d434ee3b2251eb8764bcfc15fb1de456
                   b7292dd1da67a049c8e78415cd498ec138d194cfdb302e716b08d26b80fecc10)
NEOTERM_PKG_DEPENDS="libiconv, libsodium, ncurses, openssl, readline, resolv-conf, zlib"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DHAS_SSE2=OFF
"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_RM_AFTER_INSTALL="lib/systemd"

neoterm_step_post_get_source() {
	mv libsodium-${NEOTERM_PKG_VERSION[1]}-RELEASE libsodium
}

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	mkdir -p libsodium
	pushd libsodium
	$NEOTERM_PKG_SRCDIR/libsodium/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	popd

	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	neoterm_setup_cmake
	cmake $NEOTERM_PKG_SRCDIR
	make -j $NEOTERM_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

neoterm_step_post_configure() {
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR/src/hamcorebuilder:$PATH
}
