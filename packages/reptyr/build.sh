NEOTERM_PKG_HOMEPAGE="https://github.com/nelhage/reptyr"
NEOTERM_PKG_DESCRIPTION="Tool for reparenting a running program to a new terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.10.0
NEOTERM_PKG_SRCURL=https://github.com/nelhage/reptyr/archive/refs/tags/reptyr-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c6ffbc34a511ac00d072219bda30699e51f2f4eb483cbae9e32e981d49e8b380
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_BUILD_DEPENDS="bash-completion"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
