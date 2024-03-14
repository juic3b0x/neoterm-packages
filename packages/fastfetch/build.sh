NEOTERM_PKG_HOMEPAGE=https://github.com/fastfetch-cli/fastfetch
NEOTERM_PKG_DESCRIPTION="A neofetch-like tool for fetching system information and displaying them in a pretty way"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.8.8"
NEOTERM_PKG_SRCURL=https://github.com/fastfetch-cli/fastfetch/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=179c4a4d9e725104ebabd5932b1d659a99dbdfc225a1ee0261944d168abccf05
NEOTERM_PKG_DEPENDS="vulkan-loader"
NEOTERM_PKG_BUILD_DEPENDS="freetype, libandroid-wordexp-static, vulkan-headers, vulkan-loader-android"
NEOTERM_PKG_ANTI_BUILD_DEPENDS="vulkan-loader"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DTARGET_DIR_HOME=${NEOTERM_ANDROID_HOME}
-DTARGET_DIR_ROOT=${NEOTERM_PREFIX}
-DTARGET_DIR_USR=${NEOTERM_PREFIX}
"
