NEOTERM_PKG_HOMEPAGE=https://github.com/haiwen/libsearpc
NEOTERM_PKG_DESCRIPTION="A simple C language RPC framework (mainly for seafile)"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:3.2.0
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://github.com/haiwen/libsearpc/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=cd00197fcc40b45b1d5e892b2d08dfa5947f737e0d80f3ef26419334e75b0bff
NEOTERM_PKG_DEPENDS="glib, libjansson, python"
NEOTERM_PKG_BREAKS="libsearpc-dev"
NEOTERM_PKG_REPLACES="libsearpc-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-compile-demo=no
"

neoterm_step_post_get_source() {
	./autogen.sh
	export PYTHON="python${NEOTERM_PYTHON_VERSION}"
}
