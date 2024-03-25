NEOTERM_PKG_HOMEPAGE=https://github.com/trentbuck/binutils-is-llvm
NEOTERM_PKG_DESCRIPTION="Use llvm as binutils"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
# The version number is different from the original one.
NEOTERM_PKG_VERSION=0.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="lld, llvm"
NEOTERM_PKG_CONFLICTS="binutils"

neoterm_step_make_install() {
	ln -sf lld $NEOTERM_PREFIX/bin/ld
	local f
	# Please do not include `as`. `llvm-as` is pretty much different from
	# GNU as. Clang's `-fno-integrated-as` will not work as expected when
	# `as` is a symlink to `llvm-as`. `bin/as` is provided by `binutils-bin`
	# package which does not collide with this package.
	for f in addr2line ar dwp nm objcopy objdump ranlib readelf size strings strip; do
		ln -sf llvm-${f} $NEOTERM_PREFIX/bin/${f}
	done
	ln -sf llvm-cxxfilt $NEOTERM_PREFIX/bin/c++filt

	local dir=$NEOTERM_PREFIX/share/$NEOTERM_PKG_NAME
	mkdir -p $dir
	touch $dir/.placeholder

	# Add some arch-prefixed symlinks like binutils.
	for b in ar ld nm objdump ranlib readelf strip; do
		ln -sf $b $NEOTERM_PREFIX/bin/$NEOTERM_HOST_PLATFORM-$b
	done
}

neoterm_step_install_license() {
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME \
		$NEOTERM_PKG_BUILDER_DIR/LICENSE
}
