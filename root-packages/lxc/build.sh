NEOTERM_PKG_HOMEPAGE=https://linuxcontainers.org/
NEOTERM_PKG_DESCRIPTION="Linux Containers"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
# v3.1.0 is the last version confirmed to work.
# Do not update it unless you tested it on your device.
NEOTERM_PKG_VERSION=1:3.1.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://linuxcontainers.org/downloads/lxc/lxc-${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=4d8772c25baeaea2c37a954902b88c05d1454c91c887cb6a0997258cfac3fdc5
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="gnupg, libcap, libseccomp, rsync, wget"
NEOTERM_PKG_BREAKS="lxc-dev"
NEOTERM_PKG_REPLACES="lxc-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-distro=neoterm
--with-runtime-path=$NEOTERM_PREFIX/var/run
--disable-apparmor
--disable-selinux
--enable-seccomp
--enable-capabilities
--disable-examples
--disable-werror
"

neoterm_step_post_make_install() {
	# Simple helper script for mounting cgroups.
	install -Dm755 "$NEOTERM_PKG_BUILDER_DIR"/lxc-setup-cgroups.sh \
		"$NEOTERM_PREFIX"/bin/lxc-setup-cgroups
	sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|" "$NEOTERM_PREFIX"/bin/lxc-setup-cgroups
}
