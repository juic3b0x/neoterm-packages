NEOTERM_PKG_HOMEPAGE=https://www.pureftpd.org/project/pure-ftpd
NEOTERM_PKG_DESCRIPTION="Pure-FTPd is a free (BSD), secure, production-quality and standard-conformant FTP server"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.51
NEOTERM_PKG_SRCURL=https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4160f66b76615eea2397eac4ea3f0a146b7928207b79bc4cc2f99ad7b7bd9513
NEOTERM_PKG_DEPENDS="libcrypt, openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_elf_elf_begin=no
ac_cv_lib_sodium_crypto_pwhash_scryptsalsa208sha256_str=no
--with-ftpwho
--with-nonroot
--with-puredb
--with-tls
"
NEOTERM_PKG_CONFFILES="etc/pure-ftpd.conf"
