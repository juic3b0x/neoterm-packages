NEOTERM_PKG_HOMEPAGE=http://fossil.instinctive.eu/libsoldout/index
NEOTERM_PKG_DESCRIPTION="Flexible C library and tools for markdown"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION=1.4
NEOTERM_PKG_SRCURL="http://fossil.instinctive.eu/libsoldout-$NEOTERM_PKG_VERSION.tar.bz2"
NEOTERM_PKG_SHA256=92a8cf53f27a6eaa489473c37f6a3c32181ca5b75afea952fd15f4d168a4ffac
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-f GNUmakefile"
#NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology

neoterm_step_configure() {
	true
}

neoterm_step_make_install() {
	install -dm700 "$NEOTERM_PREFIX"/{lib,bin,include/$NEOTERM_PKG_NAME,share/{doc/$NEOTERM_PKG_NAME,man/man{1,3}}}
	install -pm600 -t "$NEOTERM_PREFIX"/share/doc/"$NEOTERM_PKG_NAME" README CHANGES
	install -pm600 -t "$NEOTERM_PREFIX/share/man/man3" *.3
	install -pm600 -t "$NEOTERM_PREFIX/share/man/man1" *.1
	install -pm600 -t "$NEOTERM_PREFIX/include/$NEOTERM_PKG_NAME" *.h
	install -pm700 -t "$NEOTERM_PREFIX/lib" libsoldout.{a,so,so.*}
	install -pm700 -t "$NEOTERM_PREFIX/bin" mkd2{html,latex,man}
}
