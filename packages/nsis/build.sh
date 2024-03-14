NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/nsis/
NEOTERM_PKG_DESCRIPTION="A professional open source system to create Windows installers"
# Licenses: zlib/libpng, bzip2, CPL-1.0
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.09"
NEOTERM_PKG_SRCURL=https://prdownloads.sourceforge.net/nsis/nsis-${NEOTERM_PKG_VERSION}-src.tar.bz2
NEOTERM_PKG_SHA256=0cd846c6e9c59068020a87bfca556d4c630f2c5d554c1098024425242ddc56e2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libiconv, nsis-stubs, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	scons \
		CC="$(command -v $CC)" \
		CXX="$(command -v $CXX)" \
		APPEND_CCFLAGS="$CFLAGS $CPPFLAGS" \
		APPEND_LINKFLAGS="$LDFLAGS" \
		SKIPSTUBS=all \
		SKIPPLUGINS=all \
		SKIPUTILS=all \
		SKIPMISC=all \
		NSIS_CONFIG_CONST_DATA_PATH=no \
		PREFIX="$NEOTERM_PREFIX/opt/nsis/nsis" \
		install-compiler
}

neoterm_step_post_make_install() {
	ln -sfr $NEOTERM_PREFIX/opt/nsis/nsis/makensis $NEOTERM_PREFIX/bin/

	rm -rf _nsis-stubs
	mkdir -p _nsis-stubs
	pushd _nsis-stubs
	tar xf $NEOTERM_PKG_BUILDER_DIR/nsis-stubs.tar.xz --strip-components=1
	install -Dm600 -t $NEOTERM_PREFIX/opt/nsis/Stubs *
	popd
}
