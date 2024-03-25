NEOTERM_PKG_HOMEPAGE="https://www.nongnu.org/simulavr"
NEOTERM_PKG_DESCRIPTION="Simulator for Microchip AVR (formerly Atmel) microcontrollers"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_VERSION_MAJOR=1
_VERSION_MINOR=1
_VERSION_PATCH=0
NEOTERM_PKG_VERSION=1:${_VERSION_MAJOR}.${_VERSION_MINOR}.${_VERSION_PATCH}
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="git+https://git.savannah.nongnu.org/git/simulavr"
NEOTERM_PKG_GIT_BRANCH=release-${NEOTERM_PKG_VERSION#*:}
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS='
-DBUILD_TCL=OFF
-DBUILD_PYTHON=OFF
-DBUILD_VERILOG=OFF
-DCHECK_VALGRIND=OFF
'

neoterm_step_post_get_source() {
	echo "Applying hardcode-version.diff"
	sed \
		-e "s|@VERSION_MAJOR@|${_VERSION_MAJOR}|g" \
		-e "s|@VERSION_MINOR@|${_VERSION_MINOR}|g" \
		-e "s|@VERSION_PATCH@|${_VERSION_PATCH}|g" \
		$NEOTERM_PKG_BUILDER_DIR/hardcode-version.diff \
		| patch --silent -p1
}

neoterm_step_post_make_install() {
	mv "$NEOTERM_PREFIX/share/doc/common" "$NEOTERM_PREFIX/share/doc/simulavr"
	# Headers are moved into their own subdirectory to prevent conflicts.
	# Might cause issues when using them.
	mv "$NEOTERM_PREFIX/include" "$NEOTERM_PREFIX/include-simulavr"
	mkdir "$NEOTERM_PREFIX/include"
	mv "$NEOTERM_PREFIX/include-simulavr" "$NEOTERM_PREFIX/include/simulavr"
}
