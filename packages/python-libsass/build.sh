NEOTERM_PKG_HOMEPAGE=https://github.com/sass/libsass-python
NEOTERM_PKG_DESCRIPTION="A straightforward binding of libsass for Python"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.22.0
NEOTERM_PKG_SRCURL=https://github.com/sass/libsass-python/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f26d466918496fbce0890a3c388c78ee25ef9165a7affc591f846d0f8f1a671e
NEOTERM_PKG_DEPENDS="libsass, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export SYSTEM_SASS=1
}
