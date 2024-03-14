NEOTERM_PKG_HOMEPAGE=https://unix4lyfe.org/darkhttpd
NEOTERM_PKG_DESCRIPTION="A simple webserver, implemented in a single .c file."
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="David Paskevic @casept"
NEOTERM_PKG_VERSION="1.16"
NEOTERM_PKG_SRCURL=https://github.com/emikulic/darkhttpd/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ab97ea3404654af765f78282aa09cfe4226cb007d2fcc59fe1a475ba0fef1981
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" $LDFLAGS"
}
