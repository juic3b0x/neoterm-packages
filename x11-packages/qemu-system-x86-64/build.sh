NEOTERM_PKG_HOMEPAGE=https://www.qemu.org
NEOTERM_PKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:8.0.2
NEOTERM_PKG_SRCURL=https://download.qemu.org/qemu-${NEOTERM_PKG_VERSION:2}.tar.xz
NEOTERM_PKG_SHA256=f060abd435fbe6794125e2c398568ffc3cfa540042596907a8b18edca34cf6a5
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libbz2, libcairo, libcurl, libepoxy, libgmp, libgnutls, libiconv, libjpeg-turbo, liblzo, libnettle, libnfs, libpixman, libpng, libslirp, libspice-server, libssh, libusb, libusbredir, libx11, mesa, ncurses, pulseaudio, qemu-common, resolv-conf, sdl2, sdl2-image, virglrenderer, zlib, zstd"

# Required by configuration script, but I can't find any binary that uses it.
NEOTERM_PKG_BUILD_DEPENDS="libtasn1"

# Remove files already present in qemu-utils and qemu-common.
NEOTERM_PKG_RM_AFTER_INSTALL="
bin/elf2dmp
bin/qemu-edid
bin/qemu-ga
bin/qemu-img
bin/qemu-io
bin/qemu-nbd
bin/qemu-pr-helper
bin/qemu-storage-daemon
include/*
libexec/qemu-bridge-helper
libexec/virtfs-proxy-helper
share/applications
share/doc
share/icons
share/man/man1/qemu-img.1*
share/man/man1/qemu-storage-daemon.1*
share/man/man1/qemu.1*
share/man/man1/virtfs-proxy-helper.1*
share/man/man7
share/man/man8/qemu-ga.8*
share/man/man8/qemu-nbd.8*
share/man/man8/qemu-pr-helper.8*
share/qemu
"

NEOTERM_PKG_CONFLICTS="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
NEOTERM_PKG_REPLACES="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
NEOTERM_PKG_PROVIDES="qemu-system-x86_64"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	# Workaround for https://github.com/neoterm/neoterm-packages/issues/12261.
	if [ $NEOTERM_ARCH = "aarch64" ]; then
		rm -f $NEOTERM_PKG_BUILDDIR/_lib
		mkdir -p $NEOTERM_PKG_BUILDDIR/_lib

		cd $NEOTERM_PKG_BUILDDIR
		mkdir -p _setjmp-aarch64
		pushd _setjmp-aarch64
		mkdir -p private
		local s
		for s in $NEOTERM_PKG_BUILDER_DIR/setjmp-aarch64/{setjmp.S,private-*.h}; do
			local f=$(basename ${s})
			cp ${s} ./${f/-//}
		done
		$CC $CFLAGS $CPPFLAGS -I. setjmp.S -c
		$AR cru $NEOTERM_PKG_BUILDDIR/_lib/libandroid-setjmp.a setjmp.o
		popd

		LDFLAGS+=" -L$NEOTERM_PKG_BUILDDIR/_lib -l:libandroid-setjmp.a"
	fi
}

neoterm_step_configure() {
	neoterm_setup_ninja

	if [ "$NEOTERM_ARCH" = "i686" ]; then
		LDFLAGS+=" -latomic"
	fi

	local QEMU_TARGETS=""

	# System emulation.
	QEMU_TARGETS+="aarch64-softmmu,"
	QEMU_TARGETS+="arm-softmmu,"
	QEMU_TARGETS+="i386-softmmu,"
	QEMU_TARGETS+="m68k-softmmu,"
	QEMU_TARGETS+="ppc64-softmmu,"
	QEMU_TARGETS+="ppc-softmmu,"
	QEMU_TARGETS+="riscv32-softmmu,"
	QEMU_TARGETS+="riscv64-softmmu,"
	QEMU_TARGETS+="x86_64-softmmu"

	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-shmem -llog"

	# Note: using --disable-stack-protector since stack protector
	# flags already passed by build scripts but we do not want to
	# override them with what QEMU configure provides.
	./configure \
		--prefix="$NEOTERM_PREFIX" \
		--cross-prefix="${NEOTERM_HOST_PLATFORM}-" \
		--host-cc="gcc" \
		--cc="$CC" \
		--cxx="$CXX" \
		--objcc="$CC" \
		--disable-stack-protector \
		--smbd="$NEOTERM_PREFIX/bin/smbd" \
		--enable-coroutine-pool \
		--audio-drv-list=pa,sdl \
		--enable-trace-backends=nop \
		--disable-guest-agent \
		--enable-gnutls \
		--enable-nettle \
		--enable-sdl \
		--enable-sdl-image \
		--enable-gtk \
		--enable-opengl \
		--enable-virglrenderer \
		--disable-vte \
		--enable-curses \
		--enable-iconv \
		--enable-vnc \
		--disable-vnc-sasl \
		--enable-vnc-jpeg \
		--enable-png \
		--disable-xen \
		--disable-xen-pci-passthrough \
		--enable-virtfs \
		--enable-curl \
		--enable-fdt \
		--enable-kvm \
		--disable-hax \
		--disable-hvf \
		--disable-whpx \
		--enable-libnfs \
		--enable-lzo \
		--disable-snappy \
		--enable-bzip2 \
		--disable-lzfse \
		--disable-seccomp \
		--enable-libssh \
		--enable-bochs \
		--enable-cloop \
		--enable-dmg \
		--enable-parallels \
		--enable-qed \
		--enable-slirp \
		--enable-spice \
		--enable-libusb \
		--enable-usb-redir \
		--disable-vhost-user \
		--disable-vhost-user-blk-server \
		--target-list="$QEMU_TARGETS"
}

neoterm_step_post_make_install() {
	local i
	for i in aarch64 arm i386 m68k ppc ppc64 riscv32 riscv64 x86_64; do
		ln -sfr \
			"${NEOTERM_PREFIX}"/share/man/man1/qemu.1 \
			"${NEOTERM_PREFIX}"/share/man/man1/qemu-system-${i}.1
	done
}
