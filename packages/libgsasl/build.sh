NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gsasl
NEOTERM_PKG_DESCRIPTION="GNU SASL library"
NEOTERM_PKG_LICENSE="LGPL-2.1, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.0
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/gsasl/gsasl-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=79b868e3b9976dc484d59b29ca0ae8897be96ce4d36d32aed5d935a7a3307759
NEOTERM_PKG_DEPENDS="libidn"
NEOTERM_PKG_BREAKS="libgsasl-dev"
NEOTERM_PKG_REPLACES="libgsasl-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_getpass=yes
--without-libgcrypt
"
