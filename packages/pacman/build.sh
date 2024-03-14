NEOTERM_PKG_HOMEPAGE=https://archlinux.org/pacman/
NEOTERM_PKG_DESCRIPTION="A library-based package manager with dependency support"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@Maxython <mixython@gmail.com>"
NEOTERM_PKG_VERSION=6.0.2
NEOTERM_PKG_REVISION=13
NEOTERM_PKG_SRCURL=https://sources.archlinux.org/other/pacman/pacman-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7d8e3e8c5121aec0965df71f59bedf46052c6cf14f96365c4411ec3de0a4c1a5
NEOTERM_PKG_DEPENDS="bash, curl, gpgme, libandroid-glob, libarchive, libcurl, openssl, neoterm-licenses"
NEOTERM_PKG_BUILD_DEPENDS="doxygen, asciidoc, nettle"
NEOTERM_PKG_RECOMMENDS="neoterm-keyring"
NEOTERM_PKG_GROUPS="base-devel"
#NEOTERM_PKG_CONFFILES="etc/pacman.conf, etc/pacman.d/serverlist, etc/makepkg.conf, var/log/pacman.log"
NEOTERM_PKG_CONFFILES="etc/pacman.d/serverlist, etc/makepkg.conf, var/log/pacman.log"

neoterm_step_pre_configure() {
	rm -f ./scripts/libmakepkg/executable/sudo.sh.in
	rm -f ./scripts/libmakepkg/executable/fakeroot.sh.in

	sed -i "s/@NEOTERM_ARCH@/${NEOTERM_ARCH}/" ./etc/*
}

neoterm_step_post_configure() {
	sed -i 's/$ARGS -o $out $in $LINK_ARGS/$ARGS -o $out $in $LINK_ARGS -landroid-glob/' ${NEOTERM_TOPDIR}/pacman/build/build.ninja
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/etc/pacman.d
	{
		echo '# Official services Termux-Pacman'
		echo
		echo '# US'
		echo 'Server = https://service.neoterm-pacman.dev/$repo/$arch'
		echo 'Server = https://s3.amazonaws.com/neoterm-pacman.us/$repo/$arch'
	} > $NEOTERM_PREFIX/etc/pacman.d/serverlist
}

neoterm_step_create_debscripts() {
	echo "#!$NEOTERM_PREFIX/bin/bash" > postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/lib/pacman/sync" >> postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/lib/pacman/local" >> postinst
	echo "mkdir -p $NEOTERM_PREFIX/var/cache/pacman/pkg" >> postinst
	chmod 755 postinst
}
