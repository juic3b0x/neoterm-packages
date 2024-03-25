NEOTERM_PKG_HOMEPAGE=https://proot-me.github.io/
NEOTERM_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
# Just bump commit and version when needed:
_COMMIT=4af79603dae7a12d8767b61937d9e7e41e517701
NEOTERM_PKG_VERSION=5.1.107
NEOTERM_PKG_REVISION=62
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/proot/archive/${_COMMIT}.zip
NEOTERM_PKG_SHA256=6b53a57bbe8a48fe9d2964955074949db044097e95e29ee24edaf58f739eda3d
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libtalloc"
NEOTERM_PKG_SUGGESTS="proot-distro"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C src"

# Install loader in libexec instead of extracting it every time
export PROOT_UNBUNDLE_LOADER=$NEOTERM_PREFIX/libexec/proot

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DARG_MAX=131072"
}

neoterm_step_post_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/man/man1
	install -m600 $NEOTERM_PKG_SRCDIR/doc/proot/man.1 $NEOTERM_PREFIX/share/man/man1/proot.1

	sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		$NEOTERM_PKG_BUILDER_DIR/neoterm-chroot \
		> $NEOTERM_PREFIX/bin/neoterm-chroot
	chmod 700 $NEOTERM_PREFIX/bin/neoterm-chroot
}
