NEOTERM_PKG_HOMEPAGE=https://github.com/resurrecting-open-source-projects/dnsmap
NEOTERM_PKG_DESCRIPTION="Subdomain Bruteforcing Tool"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.36
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/resurrecting-open-source-projects/dnsmap/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f52d6d49cbf9a60f601c919f99457f108d51ecd011c63e669d58f38d50ad853c
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	./autogen.sh
}
