NEOTERM_PKG_HOMEPAGE=https://linux-nfs.org/
NEOTERM_PKG_DESCRIPTION="Linux NFS userland utilities"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/nfs/nfs-utils-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=3fbbca61d00318a8ff1028a6f7f6fe81d15cf70811c3eb0c4709f4039e36695a
NEOTERM_PKG_DEPENDS="keyutils, libblkid, libcap, libdevmapper, libevent, libmount, libsqlite, libtirpc, libuuid, openldap"
NEOTERM_PKG_BUILD_DEPENDS="libxml2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_resolv___res_querydomain=yes
libsqlite3_cv_is_recent=yes
--disable-gss
--disable-sbin-override
--with-modprobedir=$NEOTERM_PREFIX/lib/modprobe.d
--with-mountfile=$NEOTERM_PREFIX/etc/nfsmounts.conf
--with-nfsconfig=$NEOTERM_PREFIX/etc/nfs.conf
--with-start-statd=$NEOTERM_PREFIX/bin/start-statd
--with-statedir=$NEOTERM_PREFIX/var/lib/nfs
"
NEOTERM_PKG_RM_AFTER_INSTALL="
lib/udev
"

neoterm_step_pre_configure() {
	autoreconf -fi

	CPPFLAGS+=" -D__USE_GNU"

	local _lib="$NEOTERM_PKG_BUILDDIR/_lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"
	local f
	for f in strverscmp versionsort; do
		$CC $CFLAGS $CPPFLAGS "$NEOTERM_PKG_BUILDER_DIR/${f}.c" \
			-fvisibility=hidden -c -o "./${f}.o"
	done
	$AR cru libversionsort.a strverscmp.o versionsort.o
	echo '!<arch>' > libresolv.a
	popd

	LDFLAGS+=" -L${_lib} -l:libversionsort.a"
}
