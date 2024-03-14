NEOTERM_PKG_HOMEPAGE=https://lfortran.org/
NEOTERM_PKG_DESCRIPTION="A modern open-source interactive Fortran compiler"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.19.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/lfortran/lfortran
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="clang, libandroid-complex-math, libc++, ncurses, zlib, zstd"
NEOTERM_PKG_BUILD_DEPENDS="libllvm-static"
NEOTERM_PKG_SUGGESTS="libkokkos"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DWITH_LLVM=yes
-DLLVM_DIR=$NEOTERM_PREFIX/lib/cmake/llvm
"
NEOTERM_PKG_HOSTBUILD=true

# ```
# [...]/src/lfortran/parser/parser_stype.h:97:1: error: static_assert failed
# due to requirement
# 'sizeof(LFortran::YYSTYPE) == sizeof(LFortran::Vec<LFortran::AST::ast_t *>)'
# static_assert(sizeof(YYSTYPE) == sizeof(Vec<AST::ast_t*>));
# ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ```
# Furthermore libkokkos does not support ILP32
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_host_build() {
	neoterm_setup_cmake

	( cd $NEOTERM_PKG_SRCDIR && sh build0.sh )
	cmake $NEOTERM_PKG_SRCDIR
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	PATH=$NEOTERM_PKG_HOSTBUILD_DIR/src/bin:$PATH
	echo "Applying CMakeLists.txt.diff"
	sed "s|@NEOTERM_PKG_HOSTBUILD_DIR@|${NEOTERM_PKG_HOSTBUILD_DIR}|g" \
		$NEOTERM_PKG_BUILDER_DIR/CMakeLists.txt.diff \
		| patch --silent -p1

	( cd $NEOTERM_PKG_SRCDIR && sh build0.sh )

	LDFLAGS+=" -landroid-complex-math -lm"
}
