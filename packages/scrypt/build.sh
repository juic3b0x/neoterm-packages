NEOTERM_PKG_HOMEPAGE=https://www.tarsnap.com/scrypt.html
NEOTERM_PKG_DESCRIPTION="scrypt KDF library and file encryption tool"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.2"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://www.tarsnap.com/scrypt/scrypt-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=d632c1193420ac6faebf9482e65e33d3a5664eccd643b09a509d21d1c1f29be2
NEOTERM_PKG_DEPENDS="openssl"

neoterm_step_pre_configure() {
	sed -i '/# Detect specific ARM features/,$d' $NEOTERM_PKG_SRCDIR/libcperciva/cpusupport/Build/cpusupport.sh
}
