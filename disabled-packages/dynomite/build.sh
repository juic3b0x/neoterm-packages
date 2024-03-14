NEOTERM_PKG_HOMEPAGE=https://github.com/Netflix/dynomite
NEOTERM_PKG_DESCRIPTION="A thin, distributed dynamo layer for different storage engines and protocols"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.22
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/Netflix/dynomite/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9c3c60d95b39939f3ce596776febe8aa00ae8614ba85aa767e74d41e302e704a
NEOTERM_PKG_DEPENDS="libyaml, openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_epoll_works=yes
ac_cv_evports_works=no
ac_cv_header_execinfo_h=no
ac_cv_kqueue_works=no
"
NEOTERM_PKG_ENABLE_CLANG16_PORTING=false

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -Wl,-z,muldefs"
}
