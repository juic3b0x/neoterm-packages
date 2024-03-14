NEOTERM_PKG_HOMEPAGE="https://github.com/Y2Z/monolith"
NEOTERM_PKG_DESCRIPTION="CLI tool for saving complete web pages as a single HTML file"
NEOTERM_PKG_LICENSE="CC0-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.8.1"
NEOTERM_PKG_SRCURL="https://github.com/Y2Z/monolith/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=16bc9010f6a425ffa6cc71e01ab72bb3c9029f736c30918bff70157115b3ae9c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="openssl"

neoterm_step_pre_configure() {
	rm -f Makefile
}
