NEOTERM_PKG_HOMEPAGE=https://www.gnupg.org/related_software/gpgme/
NEOTERM_PKG_DESCRIPTION="Library designed to make access to GnuPG easier"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1, MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.LESSER, LICENSES"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.23.2"
NEOTERM_PKG_SRCURL=ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=9499e8b1f33cccb6815527a1bc16049d35a6198a6c5fae0185f2bd561bce5224
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gnupg (>= 2.2.9-1), libassuan, libgpg-error"
NEOTERM_PKG_BREAKS="gpgme-dev"
NEOTERM_PKG_REPLACES="gpgme-dev"
# Use "--disable-gpg-test" to avoid "No rule to make target `../../src/libgpgme-pthread.la":
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gpg-test
--enable-languages=cpp
--with-gpg=$NEOTERM_PREFIX/bin/gpg2
--without-g13
--without-gpgconf
--without-gpgsm
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
