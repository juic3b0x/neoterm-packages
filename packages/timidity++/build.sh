NEOTERM_PKG_HOMEPAGE=https://timidity.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="MIDI-to-WAVE converter and player"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.15.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/timidity/TiMidity++-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9eaf4fadb0e19eb8e35cd4ac16142d604c589e43d0e8798237333697e6381d39
NEOTERM_PKG_CONFFILES="
share/timidity/timidity.cfg
"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-dynamic
--enable-vt100
--enable-server
--enable-network
--with-module-dir=$NEOTERM_PREFIX/share/timidity
lib_cv_va_copy=yes
lib_cv___va_copy=yes
lib_cv_va_val_copy=yes
ac_cv_header_sys_time_h=yes
"

neoterm_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -DSTDC_HEADERS"
}

neoterm_step_post_configure() {
	mkdir -p _build
	$CC_FOR_BUILD $NEOTERM_PKG_SRCDIR/timidity/calcnewt.c \
		-o _build/calcnewt -lm
	export PATH="$(pwd)/_build:$PATH"

	ln -sf $NEOTERM_PKG_SRCDIR/timidity/resample.c timidity/
}

neoterm_step_post_make_install() {
	sed "s:@NEOTERM_PREFIX@:$NEOTERM_PREFIX:g" \
		$NEOTERM_PKG_BUILDER_DIR/timidity.cfg > timidity.cfg
	install -Dm600 -t $NEOTERM_PREFIX/share/timidity timidity.cfg
}
