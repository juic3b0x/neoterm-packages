##
## Since Termux is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

## TODO: restore fakeroot functionality
NEOTERM_PKG_HOMEPAGE=https://github.com/alpinelinux/abuild
NEOTERM_PKG_DESCRIPTION="Build script to build Alpine packages"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/alpinelinux/abuild/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f6f704e34f9d388a0228b645050dc7db7bf92f15a088835ae2c9b244420b9b61
NEOTERM_PKG_DEPENDS="apk-tools, autoconf, automake, bash, clang, curl, libtool, make, openssl-tool, pkg-config, tar, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="sysconfdir=$NEOTERM_PREFIX/etc"
NEOTERM_PKG_CONFFILES="etc/abuild.conf"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/abuild-adduser
bin/abuild-addgroup
bin/abuild-apk
bin/abuild-sudo
bin/buildlab
"

neoterm_step_post_make_install() {
    install -Dm600 "$NEOTERM_PKG_SRCDIR/abuild.conf" "$NEOTERM_PREFIX/etc/abuild.conf"
}
