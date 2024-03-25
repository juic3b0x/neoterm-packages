NEOTERM_PKG_HOMEPAGE=http://www.dest-unreach.org/socat/
NEOTERM_PKG_DESCRIPTION="Relay for bidirectional data transfer between two independent data channels"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.0.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=http://www.dest-unreach.org/socat/download/socat-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=6010f4f311e5ebe0e63c77f78613d264253680006ac8979f52b0711a9a231e82
NEOTERM_PKG_DEPENDS="openssl, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-posixmq
ac_header_resolv_h=no
ac_cv_c_compiler_gnu=yes
ac_compiler_gnu=yes
sc_cv_getprotobynumber_r=
" # sc_cv_sys_crdly_shift=9 sc_cv_sys_csize_shift=4 sc_cv_sys_tabdly_shift=11"
NEOTERM_PKG_BUILD_IN_SRC=true
