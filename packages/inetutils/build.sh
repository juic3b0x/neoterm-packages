NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/inetutils/
NEOTERM_PKG_DESCRIPTION="Collection of common network programs"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/inetutils/inetutils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1789d6b1b1a57dfe2a7ab7b533ee9f5dfd9cbf5b59bb1bb3c2612ed08d0f68b2
NEOTERM_PKG_DEPENDS="readline"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-glob"
NEOTERM_PKG_SUGGESTS="whois"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/whois share/man/man1/whois.1"
# These are old cruft / not suited for android
# (we --disable-traceroute as it requires root
# in favour of tracepath, which sets up traceroute
# as a symlink to tracepath):
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ifconfig
--disable-ping
--disable-ping6
--disable-rcp
--disable-rexec
--disable-rexecd
--disable-rlogin
--disable-rsh
--disable-traceroute
--disable-uucpd
ac_cv_lib_crypt_crypt=no
gl_cv_have_weak=no
"

neoterm_step_pre_configure() {
	CFLAGS+=" -DNO_INLINE_GETPASS=1"
	CPPFLAGS+=" -DNO_INLINE_GETPASS=1 -DLOGIN_PROCESS=6 -DDEAD_PROCESS=8 -DLOG_NFACILITIES=24 -fcommon"
	LDFLAGS+=" -landroid-glob"
	touch -d "next hour" ./man/whois.1
}

neoterm_step_post_configure() {
	cp $NEOTERM_PKG_BUILDER_DIR/malloc.h $NEOTERM_PKG_BUILDDIR/lib/
}
