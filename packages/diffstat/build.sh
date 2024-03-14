NEOTERM_PKG_HOMEPAGE=https://invisible-island.net/diffstat/diffstat.html
NEOTERM_PKG_DESCRIPTION="Displays a histogram of changes to a file"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.66"
NEOTERM_PKG_SRCURL=https://github.com/ThomasDickey/diffstat-snapshots/archive/refs/tags/v${NEOTERM_PKG_VERSION/./_}.tar.gz
# invisible-mirror.net is not suitable for CI due to bad responsiveness.
#NEOTERM_PKG_SRCURL=https://invisible-mirror.net/archives/diffstat/diffstat-${NEOTERM_PKG_VERSION}.tgz
#NEOTERM_PKG_SRCURL=https://invisible-island.net/datafiles/release/diffstat.tar.gz
NEOTERM_PKG_SHA256=51570ed05b8c13ca2163ce301fc1418545baf05881e18bcd21e4af5ff1bd14eb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
