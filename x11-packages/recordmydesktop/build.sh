NEOTERM_PKG_HOMEPAGE=https://github.com/Enselic/recordmydesktop
NEOTERM_PKG_DESCRIPTION="Produces a OGG encapsulated Theora/Vorbis recording of your desktop"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_SRCURL=https://github.com/Enselic/recordmydesktop/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=69602d32c1be82cd92083152c7c44c0206ca0d6419d76a6144ffcfe07b157a72
NEOTERM_PKG_DEPENDS="libandroid-shmem, libice, libogg, libpopt, libsm, libtheora, libvorbis, libx11, libxdamage, libxext, libxfixes, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pthread_pthread_mutex_lock=yes
--enable-oss=no
--enable-jack=no
"

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+="/recordmydesktop"
}

neoterm_step_pre_configure() {
	autoreconf -fi

	export LIBS="-landroid-shmem"
}
