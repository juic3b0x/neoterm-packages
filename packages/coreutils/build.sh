NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/coreutils/
NEOTERM_PKG_DESCRIPTION="Basic file, shell and text manipulation utilities from the GNU project"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.4
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/coreutils/coreutils-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ea613a4cf44612326e917201bbbcdfbd301de21ffc3b59b6e5c07e040b275e52
NEOTERM_PKG_DEPENDS="libandroid-support, libgmp, libiconv"
NEOTERM_PKG_BREAKS="chroot, busybox (<< 1.30.1-4)"
NEOTERM_PKG_REPLACES="chroot, busybox (<< 1.30.1-4)"
NEOTERM_PKG_ESSENTIAL=true

# pinky has no usage on Android.
# df does not work either, let system binary prevail.
# $PREFIX/bin/env is provided by busybox for shebangs to work directly.
# users and who doesn't work and does not make much sense for Termux.
# uptime is provided by procps.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_host_operating_system=Android
ac_cv_func_getpass=yes
--disable-xattr
--enable-no-install-program=pinky,df,users,who,uptime
--enable-single-binary=symlinks
--with-gmp
"

neoterm_step_pre_configure() {
	# https://android.googlesource.com/platform/bionic/+/master/docs/32-bit-abi.md#is-32_bit-on-lp32-y2038
	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-year2038"
	fi

	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"

	# On device build is unsupported as it removes utility 'ln' (and maybe
	# something else) in the installation process.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}
