NEOTERM_PKG_HOMEPAGE=https://www.open-mpi.org
NEOTERM_PKG_DESCRIPTION="Open source Message Passing Interface implementation"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION=4.1.5
NEOTERM_PKG_SRCURL=https://download.open-mpi.org/release/open-mpi/v${NEOTERM_PKG_VERSION:0:3}/openmpi-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=c018b127619d2a2a30c1931f316fc8a245926d0f5b4ebed4711f9695e7f70925
NEOTERM_PKG_DEPENDS="libandroid-posix-semaphore, libandroid-shmem, libevent, zlib"
NEOTERM_PKG_BREAKS="openmpi-dev"
NEOTERM_PKG_REPLACES="openmpi-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-x
--disable-dlopen
--disable-mpi-fortran
ac_cv_header_ifaddrs_h=no
ac_cv_member_struct_ifreq_ifr_hwaddr=no
"

neoterm_step_pre_configure () {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr -Dbcmp=memcmp"
	LDFLAGS+=" -landroid-posix-semaphore -landroid-shmem"
	if [ $NEOTERM_ARCH == "i686" ]; then
		# fails with "undefined reference to __atomic..."
		LDFLAGS+=" -latomic"
	fi

	./autogen.pl --force
}
