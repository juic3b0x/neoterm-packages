##
## Since Termux is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

NEOTERM_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
NEOTERM_PKG_DESCRIPTION="Alpine Linux package management tools"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.10.4
NEOTERM_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c08aa725a0437a6a83c5364a1a3a468e4aef5d1d09523369074779021397281c
NEOTERM_PKG_DEPENDS="openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="LUAAPK="
NEOTERM_PKG_CONFFILES="etc/apk/repositories"

neoterm_step_post_make_install() {
    mkdir -p $NEOTERM_PREFIX/etc/apk/
    echo $NEOTERM_ARCH > $NEOTERM_PREFIX/etc/apk/arch

    echo "https://neoterm.net/apk/main" > $NEOTERM_PREFIX/etc/apk/repositories
}

neoterm_step_post_massage() {
    mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/apk/keys"
    mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/apk/protected_paths.d"
    mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/lib/apk/db/"
    mkdir -p "$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/cache/apk"

    ln -sfr \
	"$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/var/cache/apk" \
	"$NEOTERM_PKG_MASSAGEDIR/$NEOTERM_PREFIX/etc/apk/cache"
}

neoterm_step_create_debscripts() {
    {
	echo "#!$NEOTERM_PREFIX/bin/sh"
	echo "touch $NEOTERM_PREFIX/etc/apk/world"
    } > ./postinst
    chmod 755 postinst
}
