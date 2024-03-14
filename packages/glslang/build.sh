NEOTERM_PKG_HOMEPAGE=https://github.com/KhronosGroup/glslang
NEOTERM_PKG_DESCRIPTION="OpenGL and OpenGL ES shader front end and validator"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="14.1.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/KhronosGroup/glslang/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b5e4c36d60eda7613f36cfee3489c6f507156829c707e1ecd7f48ca45b435322
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_DEPENDS="spirv-tools"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DALLOW_EXTERNAL_SPIRV_TOOLS=ON
"

neoterm_step_post_make_install() {
	# build system only build static or shared at a time
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+="
	-DBUILD_SHARED_LIBS=ON
	"
	neoterm_step_configure
	neoterm_step_make
	neoterm_step_make_install
}
