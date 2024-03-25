NEOTERM_PKG_HOMEPAGE=https://practical-scheme.net/gauche/
NEOTERM_PKG_DESCRIPTION="An R7RS Scheme implementation developed to be a handy script interpreter"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.12
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/shirok/Gauche/releases/download/release${NEOTERM_PKG_VERSION//./_}/Gauche-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=b4ae64921b07a96661695ebd5aac0dec813d1a68e546a61609113d7843f5b617
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="gdbm, libcrypt, libiconv, mbedtls, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libatomic-ops"
NEOTERM_PKG_RECOMMENDS="binutils-is-llvm | binutils, ca-certificates"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-ca-bundle=$NEOTERM_PREFIX/etc/tls/cert.pem
--with-slib=$NEOTERM_PREFIX/share/slib
"
# As of 0.9.10 some code hangs with threads enabled, e.g.
# ```
# (use rfc.uri)
# (uri-decode-string "")
# ```
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-threads=none"

neoterm_step_host_build() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	find "$NEOTERM_PKG_SRCDIR" -mindepth 1 -maxdepth 1 ! -name build_gosh -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD
	make -j $NEOTERM_MAKE_PROCESSES
	make install
}

neoterm_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$NEOTERM_PKG_HOSTBUILD_DIR/prefix

	cp $NEOTERM_PKG_BUILDER_DIR/fake-ndbm-makedb.c "$NEOTERM_PKG_SRCDIR"/ext/dbm/

	export BUILD_GOSH=$_PREFIX_FOR_BUILD/bin/gosh
	export PATH=$PATH:$_PREFIX_FOR_BUILD/bin

	autoreconf -fi
}
