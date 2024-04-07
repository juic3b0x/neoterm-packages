NEOTERM_PKG_HOMEPAGE=https://github.com/juic3b0x/neoterm-apt-repo
NEOTERM_PKG_DESCRIPTION="Script to create NeoTerm apt repositories"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5
NEOTERM_PKG_SRCURL=https://github.com/juic3b0x/neoterm-apt-repo/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=bf9a244bdd791f9766ae9daff2be9a77e379661a5bf4a7d532f00087796b68ef
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
# binutils for ar:
NEOTERM_PKG_DEPENDS="binutils-is-llvm | binutils, python, tar"
