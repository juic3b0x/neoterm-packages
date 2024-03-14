NEOTERM_PKG_HOMEPAGE=https://theunarchiver.com/command-line
NEOTERM_PKG_DESCRIPTION="Command line tools for archive and file unarchiving and extraction"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=()
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_VERSION+=(1.10.7)
NEOTERM_PKG_VERSION+=(1.1)
NEOTERM_PKG_SRCURL=(https://github.com/MacPaw/XADMaster/archive/v${NEOTERM_PKG_VERSION}/XADMaster-${NEOTERM_PKG_VERSION}.tar.gz
                   https://github.com/MacPaw/universal-detector/archive/${NEOTERM_PKG_VERSION[1]}/universal-detector-${NEOTERM_PKG_VERSION[1]}.tar.gz)
NEOTERM_PKG_SHA256=(3d766dc1856d04a8fb6de9942a6220d754d0fa7eae635d5287e7b1cf794c4f45
                   8e8532111d0163628eb828a60d67b53133afad3f710b1967e69d3b8eee28a811)
NEOTERM_PKG_DEPENDS="libbz2, libc++, libgnustep-base, libicu, libwavpack, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e -f Makefile.linux"

neoterm_step_post_get_source() {
	mv universal-detector-${NEOTERM_PKG_VERSION[1]} UniversalDetector
	cp $NEOTERM_PKG_BUILDER_DIR/sys_time.c ./
}

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	export OBJCC="$CC"
	export OBJCFLAGS="$CFLAGS -fobjc-nonfragile-abi"
	LD="$CXX"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin lsar unar
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 Extra/*.1
	mkdir -p $NEOTERM_PREFIX/share/bash-completion/completions
	for c in lsar unar; do
		install -Dm600 Extra/${c}.bash_completion \
			$NEOTERM_PREFIX/share/bash-completion/completions/${c}
	done
}
