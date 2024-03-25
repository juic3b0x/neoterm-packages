NEOTERM_PKG_HOMEPAGE=https://wren.io/
NEOTERM_PKG_DESCRIPTION="Small, fast, class-based concurrent scripting language interpreter"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/wren-lang/wren-cli/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=fafdc5d6615114d40de3956cd3a255e8737dadf8bd758b48bac00db61563cb4c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libuv"
NEOTERM_PKG_BUILD_IN_SRC=true

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
	install -Dm700 "$NEOTERM_PKG_SRCDIR"/bin/wren_cli \
		"$NEOTERM_PREFIX"/bin/wren
}
