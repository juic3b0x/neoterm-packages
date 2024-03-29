NEOTERM_PKG_HOMEPAGE=https://apr.apache.org/
NEOTERM_PKG_DESCRIPTION="Apache Portable Runtime Library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.7.4
NEOTERM_PKG_SRCURL=https://dlcdn.apache.org/apr/apr-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=fc648de983f3a2a6c9e78dea1f180639bd2fad6c06d556d4367a701fe5c35577
NEOTERM_PKG_DEPENDS="libuuid"
# libcrypt build-dependency is needed to build apache2.
NEOTERM_PKG_BUILD_DEPENDS="libcrypt"
NEOTERM_PKG_BREAKS="apr-dev"
NEOTERM_PKG_REPLACES="apr-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-installbuilddir=$NEOTERM_PREFIX/share/apr-1/build
ac_cv_func_getrandom=no
ac_cv_have_decl_SYS_getrandom=no
ap_cv_atomic_builtins=yes
apr_cv_mutex_recursive=yes
apr_cv_epoll=yes
apr_cv_epoll_create1=yes
apr_cv_dup3=yes
apr_cv_accept4=yes
apr_cv_sock_cloexec=yes
ac_cv_file__dev_zero=yes
ac_cv_strerror_r_rc_int=yes
ac_cv_func_setpgrp_void=yes
ac_cv_struct_rlimit=yes
ac_cv_func_sem_open=no
apr_cv_process_shared_works=yes
apr_cv_mutex_robust_shared=no
ac_cv_o_nonblock_inherited=no
apr_cv_tcp_nodelay_with_cork=yes
apr_cv_gai_addrconfig=yes
ac_cv_sizeof_pid_t=4
ac_cv_sizeof_ssize_t=$(( NEOTERM_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_size_t=$(( NEOTERM_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_off_t=$(( NEOTERM_ARCH_BITS==32 ? 4 : 8 ))
ac_cv_sizeof_struct_iovec=$(( NEOTERM_ARCH_BITS==32 ? 8 : 16 ))
"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/apr.exp"

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
