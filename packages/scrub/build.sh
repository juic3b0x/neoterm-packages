NEOTERM_PKG_HOMEPAGE=https://github.com/chaos/scrub
NEOTERM_PKG_DESCRIPTION="Iteratively writes patterns on files or disk devices to make retreiving the data more difficult"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/chaos/scrub/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=838b061b2e1932b342fb9695c5579cdff5d2d72506cb41d6d8032eba18aed969
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	./autogen.sh
}
