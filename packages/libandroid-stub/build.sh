NEOTERM_PKG_HOMEPAGE=https://android.googlesource.com/platform/frameworks/base/+/main/native/android
NEOTERM_PKG_DESCRIPTION="Stub libandroid.so for non-Android certified environment"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=26b
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=ad73c0370f0b0a87d1671ed2fd5a9ac9acfd1eb5c43a7fbfbd330f85d19dd632
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
# 1. filling missing libandroid.so in environments like Termux Docker
# 2. workaround package issues caused by pulling system libs that
#    conflict Termux libs as a result of pulling system libandroid.so
