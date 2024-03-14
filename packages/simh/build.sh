NEOTERM_PKG_HOMEPAGE=http://simh.trailing-edge.com/
NEOTERM_PKG_DESCRIPTION="A collection of simulators for computer hardware and software from the past"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
_VERSION=3.12-4
NEOTERM_PKG_VERSION=1:${_VERSION/-/.}
NEOTERM_PKG_SRCURL=http://simh.trailing-edge.com/sources/simhv${_VERSION/.}.zip
NEOTERM_PKG_SHA256=a05a21b1d359498b673c837db224ab37ede0c6ac406bd15af23cca8e7a60e8c4
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="DONT_USE_ROMS=1 TESTS=0"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/LICENSE ./
}

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon -fwrapv"
	LDFLAGS+=" -lm"
}

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		GCC="$CC" CFLAGS_O="$CFLAGS $CPPFLAGS" LDFLAGS="$LDFLAGS" \
		$NEOTERM_PKG_EXTRA_MAKE_ARGS
}

neoterm_step_make_install() {
	shopt -s nullglob
	for f in BIN/*; do
		if [ -f "$f" ]; then
			local b="$(basename "$f")"
			install -Dm700 -T "$f" $NEOTERM_PREFIX/bin/simh-"$b"
		fi
	done
	for f in */*.bin; do
		install -Dm600 -T "$f" $NEOTERM_PREFIX/share/simh/"$f"
	done
	shopt -u nullglob
}
