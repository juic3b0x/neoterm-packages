NEOTERM_PKG_HOMEPAGE=https://libcxx.llvm.org/
NEOTERM_PKG_DESCRIPTION="C++ Standard Library"
NEOTERM_PKG_LICENSE="NCSA"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Version should be equal to NEOTERM_NDK_{VERSION_NUM,REVISION} in
# scripts/properties.sh
NEOTERM_PKG_VERSION=26c
NEOTERM_PKG_SRCURL=https://dl.google.com/android/repository/android-ndk-r${NEOTERM_PKG_VERSION}-linux.zip
NEOTERM_PKG_SHA256=6d6e659834d28bb24ba7ae66148ad05115ebbad7dabed1af9b3265674774fcf6
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_make_install() {
	install -m700 -t "$NEOTERM_PREFIX"/lib \
		toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/"${NEOTERM_HOST_PLATFORM}"/libc++_shared.so
}
