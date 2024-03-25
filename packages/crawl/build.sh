NEOTERM_PKG_HOMEPAGE=https://crawl.develz.org/
NEOTERM_PKG_DESCRIPTION="Roguelike adventure through dungeons filled with dangerous monsters"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.30.1
NEOTERM_PKG_SRCURL=https://github.com/crawl/crawl/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f7f793271eab06822b9cb3936da54a1cbe759b471347088a4d76052ac8947597
NEOTERM_PKG_DEPENDS="libc++, liblua51, libsqlite, ncurses, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
FHS=yes
--debug
"

neoterm_step_post_get_source() {
	echo "Applying util-gen_ver.pl.diff"
	sed "s|@VERSION@|${NEOTERM_PKG_VERSION#*:}|g" \
		$NEOTERM_PKG_BUILDER_DIR/util-gen_ver.pl.diff \
		| patch --silent -p1
	pushd crawl-ref/source
	local f
	for f in initfile.cc main.cc syscalls.cc; do
		sed -i 's|\(__ANDROID_\)_|\1_NO_NEOTERM__|g' "${f}"
	done
	popd
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/crawl-ref/source"
	NEOTERM_PKG_BUILDDIR=$NEOTERM_PKG_SRCDIR

	export DEFINES_L="-DHAVE_STAT"
	export LIBS="-llog -Wl,--rpath=$NEOTERM_PREFIX/lib"
}
