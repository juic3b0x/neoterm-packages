NEOTERM_PKG_HOMEPAGE=https://yarnpkg.com/
NEOTERM_PKG_DESCRIPTION="Fast, reliable, and secure dependency management"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.22.19
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://yarnpkg.com/downloads/${NEOTERM_PKG_VERSION}/yarn-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=732620bac8b1690d507274f025f3c6cfdc3627a84d9642e38a07452cc00e0f2e
NEOTERM_PKG_DEPENDS="nodejs | nodejs-lts"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	cp -r . ${NEOTERM_PREFIX}/share/yarn/
	ln -f -s ../share/yarn/bin/yarn ${NEOTERM_PREFIX}/bin/yarn
	ln -f -s ../share/yarn/bin/yarn ${NEOTERM_PREFIX}/bin/yarnpkg
}
