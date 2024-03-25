NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/binutils/
NEOTERM_PKG_DESCRIPTION="GNU Binutils libraries"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.42
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/binutils/binutils-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=aa54850ebda5064c72cd4ec2d9b056c294252991486350d9a97ab2a6dfdfaf12
NEOTERM_PKG_DEPENDS="zlib, zstd"
NEOTERM_PKG_BREAKS="binutils (<< 2.39), binutils-dev"
NEOTERM_PKG_REPLACES="binutils (<< 2.39), binutils-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--bindir=$NEOTERM_PREFIX/libexec/binutils
--enable-gold
--disable-gprofng
--enable-plugins
--disable-werror
--with-system-zlib
--enable-new-dtags
"
NEOTERM_PKG_EXTRA_MAKE_ARGS="tooldir=$NEOTERM_PREFIX"
NEOTERM_PKG_RM_AFTER_INSTALL="share/man/man1/windmc.1 share/man/man1/windres.1"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_GROUPS="base-devel"

# For binutils-cross:
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--prefix=$NEOTERM_PREFIX/opt/binutils/cross
--target=$NEOTERM_HOST_PLATFORM
--enable-shared
--disable-static
--disable-nls
--with-system-zlib
--disable-gprofng
"

neoterm_step_host_build() {
	$NEOTERM_PKG_SRCDIR/configure $NEOTERM_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS
	make -j $NEOTERM_MAKE_PROCESSES
	make install
	make install-strip
}

# Avoid linking against libfl.so from flex if available:
export LEXLIB=

neoterm_step_pre_configure() {
	# Remove this marker all the time, as binutils is architecture-specific.
	rm -rf $NEOTERM_HOSTBUILD_MARKER

	export CPPFLAGS="$CPPFLAGS -Wno-c++11-narrowing"
	# llvm upgraded a warning to an error, which caused this build (and some
	# others, including the rust toolchain) to fail like so:
	#
	# ld.lld: error: version script assignment of 'LIBCTF_1.0' to symbol 'ctf_label_set' failed: symbol not defined
  	# ld.lld: error: version script assignment of 'LIBCTF_1.0' to symbol 'ctf_label_get' failed: symbol not defined
	# These flags restore it to a warning.
	# https://reviews.llvm.org/D135402
	export LDFLAGS="$LDFLAGS -Wl,--undefined-version"

	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		export LIB_PATH="${NEOTERM_PREFIX}/lib:/system/lib"
	else
		export LIB_PATH="${NEOTERM_PREFIX}/lib:/system/lib64"
	fi
}

neoterm_step_post_make_install() {
	local d=$NEOTERM_PREFIX/share/binutils
	mkdir -p ${d}
	touch ${d}/.placeholder

	mkdir -p $NEOTERM_PREFIX/bin
	cd $NEOTERM_PREFIX/libexec/binutils

	mv ld{.bfd,}
	ln -sf ld{,.bfd}
	ln -sfr $NEOTERM_PREFIX/libexec/binutils/ld $NEOTERM_PREFIX/bin/ld.bfd

	rm -f $NEOTERM_PREFIX/bin/ld.gold
	mv ld.gold $NEOTERM_PREFIX/bin/
	ln -sfr $NEOTERM_PREFIX/bin/{ld.,}gold

	for b in *; do
		ln -sfr $NEOTERM_PREFIX/libexec/binutils/${b} \
			$NEOTERM_PREFIX/bin/${b}
	done

	# Setup symlinks as these are used when building, so used by
	# system setup in e.g. python, perl and libtool:
	local _TOOLS_WITH_HOST_PREFIX="ar ld nm objdump ranlib readelf strip"
	for b in ${_TOOLS_WITH_HOST_PREFIX}; do
		ln -sfr $NEOTERM_PREFIX/libexec/binutils/${b} \
			$NEOTERM_PREFIX/bin/$NEOTERM_HOST_PLATFORM-${b}
	done
}

neoterm_step_post_massage() {
	rm -rf bin
}
