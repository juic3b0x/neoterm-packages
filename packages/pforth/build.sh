NEOTERM_PKG_HOMEPAGE=https://www.softsynth.com/pforth/
NEOTERM_PKG_DESCRIPTION="Portable Forth in C"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_LICENSE_FILE="license.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:2.0.1
NEOTERM_PKG_SRCURL=https://github.com/philburk/pforth/archive/refs/tags/v${NEOTERM_PKG_VERSION#*:}.tar.gz
NEOTERM_PKG_SHA256=f4c417d7d1f2c187716263484bdc534d3224b6d159e049d00828a89fa5d6894d
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_host_build() {
	neoterm_setup_cmake

	cp -a $NEOTERM_PKG_SRCDIR/* .

	mkdir -p 32bit
	# Add -Wno-shift-count-overflow to ignore:
	# /home/builder/.neoterm-build/pforth/src/csrc/pf_save.c:223:34: error: right shift count >= width of type [-Werror=shift-count-overflow
	#   223 |         *addr++ = (uint8_t) (data>>56);
	#       |                                  ^~
	CC="gcc -m32" CFLAGS="-Wno-shift-count-overflow" cmake .
	make
	install -m700 fth/pforth 32bit/
	install -m600 csrc/pfdicdat.h 32bit/

	rm -rf CMakeCache.txt CMakeFiles

	mkdir -p 64bit
	cmake .
	make
	install -m700 fth/pforth 64bit/
	install -m600 csrc/pfdicdat.h 64bit/
}

neoterm_step_post_configure() {
	if [ $NEOTERM_ARCH_BITS = "32" ]; then
		local folder=32bit
	else
		local folder=64bit
	fi
	cp $NEOTERM_PKG_HOSTBUILD_DIR/$folder/pforth fth/
	cp $NEOTERM_PKG_HOSTBUILD_DIR/$folder/pfdicdat.h csrc/
}

neoterm_step_make_install() {
	install -m700 fth/pforth_standalone $NEOTERM_PREFIX/bin/pforth
}
