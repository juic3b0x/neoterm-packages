NEOTERM_PKG_HOMEPAGE=https://github.com/StackExchange/blackbox
NEOTERM_PKG_DESCRIPTION="Safely store secrets in Git/Mercurial/Subversion"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.20220610
NEOTERM_PKG_SRCURL=https://github.com/StackExchange/blackbox/archive/refs/tags/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=f1efcca6680159f244eb44fdb78e92b521760b875fa5a36e4c433b93ed0f87c1
NEOTERM_PKG_DEPENDS="gnupg"
NEOTERM_PKG_SUGGESTS="git, subversion"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_MAKE_INSTALL_TARGET="copy-install"
