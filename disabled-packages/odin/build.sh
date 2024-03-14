NEOTERM_PKG_HOMEPAGE=https://odin-lang.org/
NEOTERM_PKG_DESCRIPTION="The Odin programming language"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2022.04
NEOTERM_PKG_SRCURL=https://github.com/odin-lang/Odin/archive/refs/tags/dev-${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=42983d411902e837792f3cf4c60871da7be67a0b8c23d92a31ac6a069a8fc5c3
NEOTERM_PKG_DEPENDS="libiconv, libllvm"

# ```
# [...]/src/gb/gb.h:6754:2: error: "gb_rdtsc not supported"
# #error "gb_rdtsc not supported"
#  ^
# ```
NEOTERM_PKG_BLACKLISTED_ARCHES="arm"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_PKG_API_LEVEL" -lt 28 ]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
	LDFLAGS+=" -lLLVM -liconv"
}

neoterm_step_make() {
	for s in src/main.cpp src/libtommath.cpp; do
		$CXX $CPPFLAGS $CXXFLAGS -c $NEOTERM_PKG_SRCDIR/$s
	done
	$CXX $CXXFLAGS main.o libtommath.o -o odin $LDFLAGS
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin odin
}
