NEOTERM_PKG_HOMEPAGE=https://github.com/taviso/ctypes.sh
NEOTERM_PKG_DESCRIPTION="A foreign function interface for bash"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/taviso/ctypes.sh/releases/download/v${NEOTERM_PKG_VERSION}/ctypes-sh-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8896334f5fa88f656057bff807ec6921c8f76fc6de801d996d2057fcb18b3a68
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="bash, libelf, libdw, libffi, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -vif
}
