NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/Vulkan-Utility-Libraries
NEOTERM_PKG_DESCRIPTION="Utility Libraries for Vulkan"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.280"
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/Vulkan-Utility-Libraries/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ef34cb7e7f446a49920217d9bb44449b3ed2ae615081b58a63ce52d5853fc3a2
NEOTERM_PKG_BUILD_DEPENDS="libc++, vulkan-headers (=${NEOTERM_PKG_VERSION}), vulkan-loader-generic (=${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
