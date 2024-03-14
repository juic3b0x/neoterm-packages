NEOTERM_PKG_HOMEPAGE=https://www.freshports.org/devel/libexecinfo
NEOTERM_PKG_DESCRIPTION="A quick-n-dirty BSD licensed clone of backtrace facility found in the GNU libc"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1
NEOTERM_PKG_SRCURL=http://distcache.FreeBSD.org/ports-distfiles/libexecinfo-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=c9a21913e7fdac8ef6b33250b167aa1fc0a7b8a175145e26913a4c19d8a59b1f

# Apparently not working for these arches:
NEOTERM_PKG_BLACKLISTED_ARCHES="i686, x86_64"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/LICENSE ./
}

neoterm_step_pre_configure() {
	CFLAGS+=" -fvisibility=hidden -fno-strict-aliasing"
	LDFLAGS+=" -lm"
}

neoterm_step_make() {
	local objs="execinfo.o stacktraverse.o"
	local f
	for f in $objs; do
		$CC $CFLAGS $CPPFLAGS "$NEOTERM_PKG_SRCDIR/${f%.o}.c" -c
	done
	$CC $CFLAGS $objs -shared $LDFLAGS -o libexecinfo.so
	$AR cru libexecinfo.a $objs
}

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib libexecinfo.{a,so}
	install -Dm600 -t $NEOTERM_PREFIX/include $NEOTERM_PKG_SRCDIR/execinfo.h
}
