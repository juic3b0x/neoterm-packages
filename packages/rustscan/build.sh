NEOTERM_PKG_HOMEPAGE=https://rustscan.github.io/RustScan
NEOTERM_PKG_DESCRIPTION="The modern,fast,smart and effective port scanner"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="2.1.1"
NEOTERM_PKG_DEPENDS="nmap"
NEOTERM_PKG_SRCURL=https://github.com/RustScan/RustScan/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=51244a5bde278b25de030bd91e4ebe1d4b87269b2d0f7f601565caef4fb5749a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -r Makefile
}
