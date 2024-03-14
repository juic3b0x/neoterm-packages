NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/libidn/
NEOTERM_PKG_DESCRIPTION="GNU Libidn library, implementation of IETF IDN specifications"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.41
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/libidn/libidn-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=884d706364b81abdd17bee9686d8ff2ae7431c5a14651047c68adf8b31fd8945
NEOTERM_PKG_DEPENDS="libiconv"
NEOTERM_PKG_BREAKS="libidn-dev"
NEOTERM_PKG_REPLACES="libidn-dev"

# Remove the idn tool for now, add it as subpackage if desired::
NEOTERM_PKG_RM_AFTER_INSTALL="bin/idn share/man/man1/idn.1 share/emacs"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-ld-version-script"
