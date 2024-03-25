NEOTERM_PKG_HOMEPAGE=https://www.sbcl.org/
NEOTERM_PKG_DESCRIPTION="Steel Bank Common Lisp"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.9
NEOTERM_PKG_SRCURL=https://prdownloads.sourceforge.net/sbcl/sbcl-${NEOTERM_PKG_VERSION}-source.tar.bz2
NEOTERM_PKG_SHA256=af0f09d4379113dfd5aa255279cb3df9cb9cac0bcd65369cc43dd857ca51de6e

neoterm_step_pre_configure() {
	local SBCL_HOST_TARFILE=$NEOTERM_PKG_CACHEDIR/sbcl-host-${NEOTERM_PKG_VERSION}.tar.bz2
	if [ ! -f $SBCL_HOST_TARFILE ]; then
		curl -o $SBCL_HOST_TARFILE -L http://downloads.sourceforge.net/project/sbcl/sbcl/${NEOTERM_PKG_VERSION}/sbcl-${NEOTERM_PKG_VERSION}-x86-64-linux-binary.tar.bz2
		cd $NEOTERM_PKG_TMPDIR
		tar xf $SBCL_HOST_TARFILE
		cd sbcl-${NEOTERM_PKG_VERSION}-x86-64-linux
		INSTALL_ROOT=$NEOTERM_PKG_CACHEDIR/sbcl-host sh install.sh
	fi
	export PATH=$PATH:$NEOTERM_PKG_CACHEDIR/sbcl-host/bin
	export SBCL_HOME=$NEOTERM_PKG_CACHEDIR/sbcl-host/lib/sbcl
}

neoterm_step_make_install() {
	cd $NEOTERM_PKG_SRCDIR
	sh make.sh --prefix=$NEOTERM_PREFIX
}
