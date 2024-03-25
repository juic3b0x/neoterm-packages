NEOTERM_PKG_HOMEPAGE=https://github.com/mstorsjo/fdk-aac
NEOTERM_PKG_DESCRIPTION="Fraunhofer FDK AAC Codec Library"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@DLC01"
NEOTERM_PKG_VERSION="2.0.3"
NEOTERM_PKG_SRCURL=https://github.com/mstorsjo/fdk-aac/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e25671cd96b10bad896aa42ab91a695a9e573395262baed4e4a2ff178d6a3a78
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_LICENSE_FILE=NOTICE

neoterm_step_pre_configure() {
	./autogen.sh
}
