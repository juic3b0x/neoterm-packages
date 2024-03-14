NEOTERM_PKG_HOMEPAGE=https://github.com/pauldreik/rdfind
NEOTERM_PKG_DESCRIPTION="A tool for finding duplicate files"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.0
NEOTERM_PKG_SRCURL=https://github.com/pauldreik/rdfind/archive/refs/tags/releases/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9198d41c7a14bdf29c347570bab5001a56a4d23c1bc2e962115dccbc2d0d2265
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++, libnettle"

neoterm_step_pre_configure() {
	autoreconf -fi
}
