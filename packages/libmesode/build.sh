NEOTERM_PKG_HOMEPAGE=https://github.com/boothj5/libmesode
NEOTERM_PKG_DESCRIPTION="Minimal XMPP library written for use with Profanity XMPP client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_VERSION=0.10.1
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
NEOTERM_PKG_SRCURL=https://github.com/boothj5/libmesode/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c9dd90648e73d92b90f2b0ae41a75d8f469b116d3e6aa297c14cd57be937d99e
NEOTERM_PKG_DEPENDS="openssl,libexpat"
NEOTERM_PKG_BREAKS="libmesode-dev"
NEOTERM_PKG_REPLACES="libmesode-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
./bootstrap.sh
}
