NEOTERM_PKG_HOMEPAGE=https://powdertoy.co.uk/
NEOTERM_PKG_DESCRIPTION="The Powder Toy is a free physics sandbox game"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=97.0.352
NEOTERM_PKG_SRCURL=https://github.com/ThePowderToy/The-Powder-Toy/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3ab27e1b9a84db1da7342e61232ad5be981ca1ddf001c4924fd08b61cc8d287a
NEOTERM_PKG_DEPENDS="fftw, jsoncpp, libbz2, libc++, libcurl, libluajit, libpng, sdl2"
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dworkaround_elusive_bzip2_lib_dir=$NEOTERM_PREFIX/lib
-Dworkaround_elusive_bzip2_include_dir=$NEOTERM_PREFIX/include
-Db_pie=true
"

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin powder
	ln -sf powder $NEOTERM_PREFIX/bin/the-powder-toy
}
