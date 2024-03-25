NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/libgcrypt/
NEOTERM_PKG_DESCRIPTION="General purpose cryptographic library based on the code from GnuPG"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1, BSD 3-Clause, MIT, Public Domain"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.LIB, LICENSES"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.3
NEOTERM_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=8b0870897ac5ac67ded568dcfadf45969cfa8a6beb0fd60af2a9eadc2a3272aa
NEOTERM_PKG_DEPENDS="libgpg-error"
NEOTERM_PKG_BUILD_DEPENDS="binutils-cross"
NEOTERM_PKG_BREAKS="libgcrypt-dev"
NEOTERM_PKG_REPLACES="libgcrypt-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-jent-support
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=20

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^LIBGCRYPT_'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done

	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi

	neoterm_setup_no_integrated_as
	if [ "$NEOTERM_ARCH" = arm ]; then
		# See http://marc.info/?l=gnupg-devel&m=139136972631909&w=3
		CFLAGS+=" -mno-unaligned-access"
		# Avoid text relocations:
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" gcry_cv_gcc_inline_asm_neon=no"
	elif [ "$NEOTERM_ARCH" = i686 ] || [ "$NEOTERM_ARCH" = x86_64 ]; then
		# Fix i686 android build, also in https://bugzilla.gnome.org/show_bug.cgi?id=724050
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi

	# Fix build with lld 17, for more information, see the following links:
	# https://github.com/juic3b0x/neoterm-packages/issues/18761#issuecomment-1868896237
	# https://github.com/juic3b0x/neoterm-packages/issues/18810
	LDFLAGS+=" -Wl,--undefined-version"
}
