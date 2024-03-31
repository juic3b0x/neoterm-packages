NEOTERM_PKG_HOMEPAGE=https://github.com/dreamer/scrot
NEOTERM_PKG_DESCRIPTION="Simple command-line screenshot utility for X"
# License: MIT-feh
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10
NEOTERM_PKG_SRCURL=https://github.com/resurrecting-open-source-projects/scrot/releases/download/${NEOTERM_PKG_VERSION}/scrot-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d3fb2fb962c1921030a442448afb1994d77d40192868da1b4cdeade0066bf36f
NEOTERM_PKG_DEPENDS="imlib2, libx11, libxcomposite, libxext, libxfixes, libxinerama"

neoterm_step_pre_configure() {
	local _inc="$NEOTERM_PKG_SRCDIR/_getsubopt/include"
	rm -rf "${_inc}"
	mkdir -p "${_inc}"
	cp "$NEOTERM_PKG_BUILDER_DIR/getsubopt.h" "${_inc}"

	CPPFLAGS+=" -I${_inc} -D__force= -UANDROID"

	local _lib="$NEOTERM_PKG_BUILDDIR/_getsubopt/lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"/..
	$CC $CFLAGS $CPPFLAGS "$NEOTERM_PKG_BUILDER_DIR/getsubopt.c" \
		-fvisibility=hidden -c -o ./getsubopt.o
	$AR cru "${_lib}"/libgetsubopt.a ./getsubopt.o
	popd

	LDFLAGS+=" -L${_lib} -l:libgetsubopt.a"
}
