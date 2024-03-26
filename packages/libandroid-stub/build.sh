NEOTERM_PKG_HOMEPAGE=https://android.googlesource.com/platform/frameworks/base/+/main/native/android
NEOTERM_PKG_DESCRIPTION="Stub libandroid.so for non-Android certified environment"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=26c
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=6d6e659834d28bb24ba7ae66148ad05115ebbad7dabed1af9b3265674774fcf6
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_CONFLICTS="libandroid"
NEOTERM_PKG_REPLACES="libandroid"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	install -v -Dm644 \
		"toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${NEOTERM_HOST_PLATFORM}/${NEOTERM_PKG_API_LEVEL}/libandroid.so" \
		"${NEOTERM_PREFIX}/lib/libandroid.so"
}

# Please do NOT depend on this package; do NOT include this package in
# NEOTERM_PKG_{DEPENDS,RECOMMENDS} of other packages.
#
# This package is useful for:
# 1. filling missing libandroid.so in environments like NeoTerm Docker
# 2. workaround package issues caused by pulling system libs that
#    conflict NeoTerm libs as a result of pulling system libandroid.so
