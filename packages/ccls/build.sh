NEOTERM_PKG_HOMEPAGE=https://github.com/MaskRay/ccls
NEOTERM_PKG_DESCRIPTION="C/C++/ObjC language server"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.20220729
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/MaskRay/ccls/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=af19be36597c2a38b526ce7138c72a64c7fb63827830c4cff92256151fc7a6f4
# clang is for libclang-cpp.so
NEOTERM_PKG_DEPENDS="clang, libc++, libllvm"
NEOTERM_PKG_BUILD_DEPENDS="rapidjson, libllvm-static"

neoterm_step_pre_configure() {
	touch $NEOTERM_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}

neoterm_step_post_make_install() {
	rm $NEOTERM_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}
