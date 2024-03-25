NEOTERM_PKG_HOMEPAGE=https://unbound.net/
NEOTERM_PKG_DESCRIPTION="A validating, recursive, caching DNS resolver"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.19.2"
NEOTERM_PKG_SRCURL=https://nlnetlabs.nl/downloads/unbound/unbound-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cc560d345734226c1b39e71a769797e7fdde2265cbb77ebce542704bba489e55
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libevent, libnghttp2, openssl, resolv-conf"
NEOTERM_PKG_BUILD_DEPENDS="swig"
NEOTERM_PKG_BREAKS="unbound (<< 1.17.1-1)"
NEOTERM_PKG_REPLACES="unbound (<< 1.17.1-1)"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_PYTHON_BUILD_DEPS="swig"

# `pythonmodule` makes core lib/libunbound.so depend on python. Do not enable it.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_chown=no
ac_cv_func_chroot=no
ac_cv_func_getpwnam=no
--enable-event-api
--enable-ipsecmod
--enable-linux-ip-local-port-range
--enable-tfo-server
--with-libevent=$NEOTERM_PREFIX
--with-libexpat=$NEOTERM_PREFIX
--without-libhiredis
--without-libmnl
--with-pyunbound
--without-pythonmodule
--with-libnghttp2=$NEOTERM_PREFIX
--with-ssl=$NEOTERM_PREFIX
--with-pidfile=$NEOTERM_PREFIX/var/run/unbound.pid
--with-username=
"

neoterm_step_post_massage() {
	mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/run"
}
