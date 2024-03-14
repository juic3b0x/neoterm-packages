NEOTERM_PKG_HOMEPAGE=https://gitlab.torproject.org/tpo/core/torsocks
NEOTERM_PKG_DESCRIPTION="Wrapper to safely torify applications"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_SRCURL=https://gitlab.torproject.org/tpo/core/torsocks/-/archive/v${NEOTERM_PKG_VERSION}/torsocks-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c01b471d89eda9f3c8dcb85a448e8066692d0707f9ff8b2ac7e665a602291b87
NEOTERM_PKG_DEPENDS="tor"

neoterm_step_pre_configure() {
	./autogen.sh
}

