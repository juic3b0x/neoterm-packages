NEOTERM_PKG_HOMEPAGE=https://github.com/bettio/AtomVM
NEOTERM_PKG_DESCRIPTION="The minimal Erlang VM implementation"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:0.5.0
NEOTERM_PKG_SRCURL=https://github.com/atomvm/AtomVM/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=7119667d2f8d7e80be6ba1cbeafc873fd0e7fd876ab4064c51ac473d6a508bdd
NEOTERM_PKG_DEPENDS="zlib"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_cmake
	cmake "$NEOTERM_PKG_SRCDIR"
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_post_configure() {
	# We need the "PackBEAM" compiled for host.
	export PATH=$PATH:$NEOTERM_PKG_HOSTBUILD_DIR/tools/packbeam
}

neoterm_step_make_install() {
	install -Dm700 "$NEOTERM_PKG_BUILDDIR"/src/AtomVM \
		"$NEOTERM_PREFIX"/bin/AtomVM
	install -Dm700 "$NEOTERM_PKG_BUILDDIR"/tools/packbeam/PackBEAM \
		"$NEOTERM_PREFIX"/bin/PackBEAM
}
