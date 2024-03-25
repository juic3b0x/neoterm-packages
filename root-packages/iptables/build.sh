NEOTERM_PKG_HOMEPAGE=https://www.netfilter.org/projects/iptables
NEOTERM_PKG_DESCRIPTION="Program used to configure the Linux 2.4 and later kernel packet filtering ruleset"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.8.10"
NEOTERM_PKG_SRCURL=https://www.netfilter.org/projects/iptables/files/iptables-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5cc255c189356e317d070755ce9371eb63a1b783c34498fb8c30264f3cc59c9c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libmnl, libnftnl, libandroid-spawn"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-xt-lock-name=$NEOTERM_PREFIX/var/run/xtables.lock
"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/syslog-names.h ./extensions/
}

neoterm_step_pre_configure() {
	export CFLAGS+=" -Dindex=strchr -Drindex=strrchr -D__STDC_FORMAT_MACROS=1"
}
