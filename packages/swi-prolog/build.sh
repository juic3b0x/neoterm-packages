NEOTERM_PKG_HOMEPAGE=https://swi-prolog.org/
NEOTERM_PKG_DESCRIPTION="Most popular and complete prolog implementation"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Use "development" versions.
NEOTERM_PKG_VERSION=9.1.11
NEOTERM_PKG_SRCURL=https://www.swi-prolog.org/download/devel/src/swipl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2a668333faebc19431989bd08f5d0f9716af29eb914a092a795bf3705925a289
NEOTERM_PKG_DEPENDS="libarchive, libcrypt, libgmp, libyaml, ncurses, openssl, ossp-uuid, readline, zlib, pcre2"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DHAVE_WEAK_ATTRIBUTE_EXITCODE=0
-DHAVE_WEAK_ATTRIBUTE_EXITCODE__TRYRUN_OUTPUT=
-DINSTALL_DOCUMENTATION=OFF
-DUSE_GMP=ON
-DSWIPL_NATIVE_FRIEND=${NEOTERM_PKG_HOSTBUILD_DIR}
-DPOSIX_SHELL=${NEOTERM_PREFIX}/bin/sh
-DSWIPL_TMP_DIR=${NEOTERM_PREFIX}/tmp
-DSWIPL_INSTALL_IN_LIB=ON
-DSWIPL_PACKAGES_BDB=OFF
-DSWIPL_PACKAGES_ODBC=OFF
-DSWIPL_PACKAGES_QT=OFF
-DSWIPL_PACKAGES_X=OFF
-DINSTALL_TESTS=OFF
-DBUILD_TESTING=OFF
-DSYSTEM_CACERT_FILENAME=${NEOTERM_PREFIX}/etc/tls/cert.pem"

# We do this to produce:
# a native host build to produce
# boot<nn>.prc, INDEX.pl, ssl cetificate tests,
# SWIPL_NATIVE_FRIEND tells SWI-Prolog to use
# this build for the artifacts needed to build the
# Android version
neoterm_step_host_build() {
	neoterm_setup_cmake
	neoterm_setup_ninja

	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		export LDFLAGS=-m32
		export CFLAGS=-m32
		export CXXFLAGS=-m32
		CMAKE_EXTRA_DEFS="-DCMAKE_LIBRARY_PATH=/usr/lib/i386-linux-gnu"
	else
		CMAKE_EXTRA_DEFS=""
	fi

	cmake "$NEOTERM_PKG_SRCDIR"          \
		-G "Ninja"                      \
		$CMAKE_EXTRA_DEFS               \
		-DINSTALL_DOCUMENTATION=OFF     \
		-DSWIPL_PACKAGES=ON             \
		-DUSE_GMP=OFF                   \
		-DBUILD_TESTING=ON              \
		-DSWIPL_SHARED_LIB=OFF          \
		-DSWIPL_PACKAGES_BDB=OFF        \
		-DSWIPL_PACKAGES_ODBC=OFF       \
		-DSWIPL_PACKAGES_QT=OFF         \
		-DSWIPL_PACKAGES_X=OFF
	ninja

	unset LDFLAGS
	unset CFLAGS
	unset CXXFLAGS
}

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_make_install() {
	# Remove host build because future builds may be
	# of a different word size (e.g. 32bit or 64bit)
	rm -rf "$NEOTERM_PKG_HOSTBUILD_DIR"
}
