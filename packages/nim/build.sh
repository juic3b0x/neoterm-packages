NEOTERM_PKG_HOMEPAGE=https://nim-lang.org/
NEOTERM_PKG_DESCRIPTION="Nim programming language compiler"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="copying.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.2
NEOTERM_PKG_SRCURL=https://nim-lang.org/download/nim-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=64f51d3bf56de9d0ee79e2ca6a9ce94454af9a63a141a6969ce8c59a60b82ccf
NEOTERM_PKG_DEPENDS="clang, git, libandroid-glob, openssl"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true

_NIM_TOOLS="
koch
dist/nimble/src/nimble
nimpretty/nimpretty
nimsuggest/nimsuggest
testament/testament
tools/nimgrep
"

neoterm_step_host_build() {
	cp -r ../src/* ./
	make -j $NEOTERM_MAKE_PROCESSES CC=gcc LD=gcc
}

neoterm_step_make() {
	if [ $NEOTERM_ARCH = "x86_64" ]; then
		export	NIM_ARCH=amd64
	elif [ $NEOTERM_ARCH = "i686" ]; then
		export	NIM_ARCH=i386
	elif [ $NEOTERM_ARCH = "aarch64" ]; then
		export NIM_ARCH=arm64
	else
		export NIM_ARCH=arm
	fi
	LDFLAGS+=" -landroid-glob"
	sed -i "s%\@CC\@%${CC}%g"  config/nim.cfg
	sed -i "s%\@CFLAGS\@%${CFLAGS}%g" config/nim.cfg
	sed -i "s%\@LDFLAGS\@%${LDFLAGS}%g" config/nim.cfg
	sed -i "s%\@CPPFLAGS\@%${CPPFLAGS}%g" config/nim.cfg

	PATH=$NEOTERM_PKG_HOSTBUILD_DIR/bin:$PATH

	if [ $NIM_ARCH = "amd64" ]; then
		sed -i 's/arm64/amd64/g' makefile
	fi
	export CFLAGS=" $CPPFLAGS $CFLAGS  -w  -fno-strict-aliasing"
	make LD=$CC uos=linux mycpu=$NIM_ARCH myos=android  -j $NEOTERM_MAKE_PROCESSES useShPath=$NEOTERM_PREFIX/bin/sh
	cp config/nim.cfg ../host-build/config

	for cmd in $_NIM_TOOLS; do
		pushd $(dirname $cmd)
		case $cmd in
			koch) nim_flags="--opt:size" ;;
			*) nim_flags= ;;
		esac
		nim --cc:clang --clang.exe=$CC --clang.linkerexe=$CC $nim_flags --define:neoterm -d:release -d:sslVersion=3 --os:android --cpu:$NIM_ARCH  -t:"$CPPFLAGS $CFLAGS" -l:"$LDFLAGS -landroid-glob" -d:tempDir:$NEOTERM_PREFIX/tmp c $(basename $cmd).nim
		popd
	done
}

neoterm_step_make_install() {
	./install.sh $NEOTERM_PREFIX/lib
	ln -sfr $NEOTERM_PREFIX/lib/nim/bin/nim $NEOTERM_PREFIX/bin/
	for cmd in $_NIM_TOOLS; do
		cp $cmd $NEOTERM_PREFIX/lib/nim/bin/
		ln -sfr $NEOTERM_PREFIX/lib/nim/bin/$(basename $cmd) $NEOTERM_PREFIX/bin/
	done
	mkdir -p $NEOTERM_PREFIX/lib/nim/tools
	cp -r tools/dochack $NEOTERM_PREFIX/lib/nim/tools/
}
