NEOTERM_PKG_HOMEPAGE=https://www.tug.org/texlive/
NEOTERM_PKG_DESCRIPTION="TeX Live is a distribution of the TeX typesetting system. This package contains architecture dependent binaries."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=20230313
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/TeX-Live/texlive-source/archive/refs/heads/tags/texlive-${NEOTERM_PKG_VERSION:0:4}.0.tar.gz
NEOTERM_PKG_SHA256=b14ec8c6873ae04d77cd1de239b660e30f3d6f0e97449aee67e3300ea4a259fd
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="freetype, harfbuzz, harfbuzz-icu, libc++, libcairo, libgd, libgmp, libgraphite, libiconv, libicu, liblua52, libmpfr, libpaper, libpixman, libpng, teckit, zlib, zziplib"
# libpcre, glib, fonconfig are dependencies to libcairo. pkg-config gives an error if they are missing
# libuuid, libxml2 are needed by fontconfig
NEOTERM_PKG_BUILD_DEPENDS="icu-devtools, pcre, glib, fontconfig, libuuid, libxml2"
NEOTERM_PKG_BREAKS="texlive (<< 20180414), texlive-bin-dev"
NEOTERM_PKG_REPLACES="texlive (<< 20170524-3), texlive-bin-dev"
NEOTERM_PKG_RECOMMENDS="texlive-installer"
NEOTERM_PKG_HOSTBUILD=true

TL_ROOT=$NEOTERM_PREFIX/share/texlive
TL_BINDIR=$NEOTERM_PREFIX/bin/texlive

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
RANLIB=ranlib
--bindir=$TL_BINDIR
--build=$NEOTERM_BUILD_TUPLE
--datarootdir=$TL_ROOT
--disable-dialog
--disable-gregorio
--disable-luajittex
--disable-makejvf
--disable-mendexk
--disable-mflua
--disable-mfluajit
--disable-multiplatform
--disable-musixtnt
--disable-native-texlive-build
--disable-pmx
--disable-ps2pk
--disable-psutils
--disable-seetexk
--disable-t1utils
--disable-ttfdump
--disable-xz
--enable-dvisvgm
--enable-luatex
--enable-makeindexk
--infodir=$NEOTERM_PREFIX/share/info
--mandir=$NEOTERM_PREFIX/share/man
--with-system-cairo
--with-system-gd
--with-system-gmp
--with-system-graphite2
--with-system-harfbuzz
--with-system-icu
--with-system-libpaper
--with-system-lua
--with-system-mpfr
--with-system-teckit
--with-system-zlib
--with-system-zziplib
--without-texi2html
--without-texinfo
--without-x
--without-xdvipdfmx
--with-banner-add=/Termux"

# These files are provided by texlive:
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/a2ping
bin/tlmgr
bin/man
share/texlive/texmf-dist/web2c/mktex.opt
share/texlive/texmf-dist/web2c/mktexdir.opt
share/texlive/texmf-dist/web2c/mktexnam.opt
share/texlive/texmf-dist/web2c/fmtutil.cnf
share/texlive/texmf-dist/web2c/mktexdir
share/texlive/texmf-dist/web2c/mktexnam
share/texlive/texmf-dist/web2c/mktexupd
share/texlive/texmf-dist/web2c/texmf.cnf
share/texlive/texmf-dist/fonts
share/texlive/texmf-dist/doc
share/texlive/texmf-dist/dvips
share/texlive/texmf-dist/dvipdfmx
share/texlive/texmf-dist/texconfig
share/texlive/texmf-dist/bibtex
share/texlive/texmf-dist/scripts
share/texlive/texmf-dist/ttf2pk
share/texlive/texmf-dist/source
share/texlive/texmf-dist/chktex
share/texlive/texmf-dist/hbf2gf
"

neoterm_step_host_build() {
	mkdir -p auxdir/auxsub
	mkdir -p texk/kpathsea
	mkdir -p texk/web2c

	cd $NEOTERM_PKG_HOSTBUILD_DIR/auxdir/auxsub
	$NEOTERM_PKG_SRCDIR/auxdir/auxsub/configure
	make

	cd $NEOTERM_PKG_HOSTBUILD_DIR/texk/kpathsea
	$NEOTERM_PKG_SRCDIR/texk/kpathsea/configure

	cd $NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c
	$NEOTERM_PKG_SRCDIR/texk/web2c/configure --without-x
	make tangle
	make ctangle
	make tie
	make otangle
	make himktables
}

neoterm_step_pre_configure() {
	export TANGLE=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/tangle
	export TANGLEBOOT=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/tangleboot
	export CTANGLE=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/ctangle
	export CTANGLEBOOT=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/ctangleboot
	export TIE=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/tie
	export OTANGLE=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/otangle
	export HIMKTABLES=$NEOTERM_PKG_HOSTBUILD_DIR/texk/web2c/himktables
}
