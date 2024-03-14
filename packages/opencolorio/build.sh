NEOTERM_PKG_HOMEPAGE=https://opencolorio.org
NEOTERM_PKG_DESCRIPTION="A color management framework for visual effects and animation"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.1
NEOTERM_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/OpenColorIO/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7196e979a0449ce28afd46a78383476f3b8fc1cc1d3a417192be439ede83437b
NEOTERM_PKG_DEPENDS="imath, libc++, libexpat, libminizip-ng, libyaml-cpp, pystring"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dpystring_INCLUDE_DIR=$NEOTERM_PREFIX/lib
-DOCIO_BUILD_PYTHON=OFF
"
# Command-line apps depend on packages in x11 repo (for OpenGL functionality):
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DOCIO_BUILD_APPS=OFF"

neoterm_step_pre_configure() {
    # error: constant expression evaluates to -1 which cannot be narrowed to type 'char' [-Wc++11-narrowing]
    # also same is used while building apt
    CXXFLAGS+=" -Wno-c++11-narrowing"
    CXXFLAGS+=" -I$PREFIX/include/pystring"
}
