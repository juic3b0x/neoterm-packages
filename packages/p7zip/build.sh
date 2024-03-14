NEOTERM_PKG_HOMEPAGE=https://github.com/p7zip-project/p7zip
NEOTERM_PKG_DESCRIPTION="Command-line version of the 7zip compressed file archiver"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="17.05"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/p7zip-project/p7zip/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d2788f892571058c08d27095c22154579dfefb807ebe357d145ab2ddddefb1a6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libiconv"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	export CXXFLAGS="$CXXFLAGS $CPPFLAGS -Wno-c++11-narrowing"
	export LDFLAGS="$LDFLAGS -liconv"
	cp makefile.android_arm makefile.machine
}

neoterm_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		make -j $NEOTERM_MAKE_PROCESSES 7z 7za OPTFLAGS="${CXXFLAGS}" DEST_HOME=$NEOTERM_PREFIX
}

neoterm_step_make_install() {
	chmod +x install.sh
	make install DEST_HOME=$NEOTERM_PREFIX DEST_MAN=$NEOTERM_PREFIX/share/man
}
