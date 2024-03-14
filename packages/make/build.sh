NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/make/
NEOTERM_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Update both make and make-guile to the same version in one PR.
NEOTERM_PKG_VERSION=4.4.1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dd16fb1d67bfab79a72f5e8390735c49e3e8e70b4945a15ab1f81ddb78658fb3
NEOTERM_PKG_BREAKS="make-dev"
NEOTERM_PKG_REPLACES="make-dev"
NEOTERM_PKG_GROUPS="base-devel"
# Prevent linking against libelf:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"
# Prevent linking against libiconv:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" am_cv_func_iconv=no"

NEOTERM_PKG_CONFLICTS="make-guile"
# Prevent linking against guile:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --without-guile"

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = arm ]; then
		# Fix issue with make on arm hanging at least under cmake:
		# https://github.com/neoterm/neoterm-packages/issues/2983
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
	fi
}

neoterm_step_make() {
	# Allow to bootstrap make if building on device without make installed.
	if $NEOTERM_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./build.sh
	else
		make -j $NEOTERM_MAKE_PROCESSES
	fi
}

neoterm_step_make_install() {
	if $NEOTERM_ON_DEVICE_BUILD && [ -z "$(command -v make)" ]; then
		./make -j 1 install
	else
		make -j 1 install
	fi
}
