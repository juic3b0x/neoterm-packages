NEOTERM_PKG_HOMEPAGE=https://www.videolan.org/developers/x264.html
NEOTERM_PKG_DESCRIPTION="Library for encoding video streams into the H.264/MPEG-4 AVC format"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_COMMIT=b093bbe7d9bc642c8f24067cbdcc73bb43562eab
NEOTERM_PKG_VERSION=1:0.164.3101 # X264_BUILD from x264.h; commit count
NEOTERM_PKG_SRCURL=https://code.videolan.org/videolan/x264/-/archive/$_COMMIT/x264-$_COMMIT.tar.bz2
NEOTERM_PKG_SHA256=8a943822d761c302da647399582354fa8788802570ce3b865edd44b1aa77e9b0
NEOTERM_PKG_BREAKS="libx264-dev"
NEOTERM_PKG_REPLACES="libx264-dev"
# Avoid linking against ffmpeg libraries to avoid circular dependency:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-swscale
--disable-lavf"

neoterm_step_pre_configure() {
	#if [ $NEOTERM_ARCH = "i686" -o $NEOTERM_ARCH = "x86_64" ]; then
	if [ $NEOTERM_ARCH = "i686" ]; then
		# Avoid text relocations on i686, see:
		# https://mailman.videolan.org/pipermail/x264-devel/2016-March/011589.html
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
		# Avoid errors such as "relocation R_386_GOTOFF against preemptible symbol
		# x264_significant_coeff_flag_offset cannot be used when making a shared object":
		LDFLAGS+=" -fuse-ld=bfd"
	elif [ $NEOTERM_ARCH = "x86_64" ]; then
		# Avoid requiring nasm for now:
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}

neoterm_step_post_make_install() {
	mkdir -p ${NEOTERM_PREFIX}/share/bash-completion/completions
	install -m 644 ${NEOTERM_PKG_SRCDIR}/tools/bash-autocomplete.sh ${NEOTERM_PREFIX}/share/bash-completion/completions/x264
}
