NEOTERM_PKG_HOMEPAGE=https://ssdeep-project.github.io/ssdeep/
NEOTERM_PKG_DESCRIPTION="A program for computing context triggered piecewise hashes (CTPH)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/ssdeep-project/ssdeep/archive/refs/tags/release-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d96f667a8427ad96da197884574c7ca8c7518a37d9ac8593b6ea77e7945720a4
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-auto-search
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
