NEOTERM_PKG_HOMEPAGE=https://mruby.org/
NEOTERM_PKG_DESCRIPTION="Lightweight implementation of the Ruby language"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.0"
NEOTERM_PKG_SRCURL=https://github.com/mruby/mruby/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=53088367e3d7657eb722ddfacb938f74aed1f8538b3717fe0b6eb8f58402af65
NEOTERM_PKG_DEPENDS="libandroid-complex-math, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology

neoterm_step_make() {
	export CC_FOR_TARGET="$CC"
	export CFLAGS_FOR_TARGET="$CPPFLAGS $CFLAGS \
		-DMRB_USE_READLINE \
		-DMRB_READLINE_HEADER=\\<readline/readline.h\\> \
		-DMRB_READLINE_HISTORY=\\<readline/history.h\\> \
		"
	export LDFLAGS_FOR_TARGET="$LDFLAGS -lncurses -lreadline"
	LDFLAGS_FOR_TARGET+=" -landroid-complex-math"
	unset CPPFLAGS CFLAGS LDFLAGS
	export CC="$CC_FOR_BUILD"
	export LD="$CC_FOR_BUILD"

	export ANDROID_NDK_HOME="$NDK"
	export MRUBY_CONFIG=android-neoterm
	rake
}

neoterm_step_make_install() {
	cd "$NEOTERM_PKG_BUILDDIR/build/android-neoterm"
	for f in bin/*; do
		install -Dm700 -t $NEOTERM_PREFIX/bin $f
	done
	for f in lib/*.a; do
		install -Dm600 -t $NEOTERM_PREFIX/lib $f
	done
	cp -a "$NEOTERM_PKG_SRCDIR/include" $NEOTERM_PREFIX/
}
