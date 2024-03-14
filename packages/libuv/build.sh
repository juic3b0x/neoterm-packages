NEOTERM_PKG_HOMEPAGE=https://libuv.org
NEOTERM_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
NEOTERM_PKG_LICENSE="MIT, BSD 2-Clause, ISC, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.48.0"
NEOTERM_PKG_SRCURL=https://dist.libuv.org/dist/v${NEOTERM_PKG_VERSION}/libuv-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7f1db8ac368d89d1baf163bac1ea5fe5120697a73910c8ae6b2fffb3551d59fb
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libuv-dev"
NEOTERM_PKG_REPLACES="libuv-dev"

neoterm_step_pre_configure() {
	export PLATFORM=android
	sh autogen.sh
}
