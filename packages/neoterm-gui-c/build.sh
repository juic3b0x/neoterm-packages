NEOTERM_PKG_HOMEPAGE="https://github.com/tareksander/neoterm-gui-c-bindings"
NEOTERM_PKG_DESCRIPTION="A C library for the NeoTerm:GUI plugin"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@tareksander"
NEOTERM_PKG_VERSION="0.1.2"
NEOTERM_PKG_BUILD_DEPENDS="protobuf-static"
NEOTERM_PKG_SRCURL="https://github.com/tareksander/neoterm-gui-c-bindings/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=5588ae548473e98cfe39854207edd12a2c55909275f2461e7b52954aec7081cc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_pre_configure() {
	neoterm_setup_protobuf
}
