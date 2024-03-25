NEOTERM_PKG_HOMEPAGE=https://chrony-project.org/
NEOTERM_PKG_DESCRIPTION="chrony is an implementation of the Network Time Protocol (NTP)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@marek22k"
NEOTERM_PKG_VERSION="4.5"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://chrony-project.org/releases/chrony-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=19fe1d9f4664d445a69a96c71e8fdb60bcd8df24c73d1386e02287f7366ad422
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-glob, libandroid-shmem, libcap, libgnutls, libnettle, libnss, libtomcrypt, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--chronyvardir=${NEOTERM_PREFIX}/var/lib/chrony"

neoterm_step_pre_configure() {
	LDFLAGS="${LDFLAGS/-Wl,--as-needed/} -landroid-glob -landroid-shmem"
}
