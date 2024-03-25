NEOTERM_PKG_HOMEPAGE=https://wren.io/
NEOTERM_PKG_DESCRIPTION="Small, fast, class-based concurrent scripting language libraries"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/wren-lang/wren/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=23c0ddeb6c67a4ed9285bded49f7c91714922c2e7bb88f42428386bf1cf7b339
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="wren-dev, wren (<< 0.3.0)"
NEOTERM_PKG_REPLACES="wren-dev, wren (<< 0.3.0)"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_make() {
	local QUIET_BUILD=
	if [ "$NEOTERM_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	cd projects/make
	if [ "$NEOTERM_ARCH" = i686 ] || [ "$NEOTERM_ARCH" = arm ]; then
		RELEASE=release_32bit
	else
		RELEASE=release_64bit
	fi
	make -j $NEOTERM_MAKE_PROCESSES $QUIET_BUILD config=${RELEASE}
}

neoterm_step_make_install() {
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/src/include/wren.h \
		"$NEOTERM_PREFIX"/include/wren.h

	install -Dm600 "$NEOTERM_PKG_SRCDIR"/lib/libwren.so \
		"$NEOTERM_PREFIX"/lib/libwren.so

	install -Dm600 "$NEOTERM_PKG_SRCDIR"/lib/libwren.a \
		"$NEOTERM_PREFIX"/lib/libwren.a
}
