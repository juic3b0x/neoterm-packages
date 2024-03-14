NEOTERM_PKG_HOMEPAGE=https://traceroute.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A new modern implementation of traceroute(8) utility for Linux systems"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.3"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-${NEOTERM_PKG_VERSION}/traceroute-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=05ebc7aba28a9100f9bbae54ceecbf75c82ccf46bdfce8b5d64806459a7e0412
NEOTERM_PKG_CONFLICTS="tracepath (<< 20221126-1)"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="prefix=$NEOTERM_PREFIX -e"

neoterm_step_configure() {
	:
}
