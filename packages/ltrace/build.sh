NEOTERM_PKG_HOMEPAGE=http://www.ltrace.org/
NEOTERM_PKG_DESCRIPTION="Tracks runtime library calls in dynamically linked programs"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:0.7.9"
NEOTERM_PKG_SRCURL=https://github.com/dkogan/ltrace/archive/82c66409c7a93ca6ad2e4563ef030dfb7e6df4d4.tar.gz
NEOTERM_PKG_SHA256=4aecf69e4a33331aed1e50ce4907e73a98cbccc4835febc3473863474304d547
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libc++, libelf, libdw"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-werror
--without-libunwind
ac_cv_host=$NEOTERM_ARCH-generic-linux-gnu
"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" == "arm" ]; then
		CFLAGS+=" -DSHT_ARM_ATTRIBUTES=0x70000000+3"
	fi

	./autogen.sh
}
