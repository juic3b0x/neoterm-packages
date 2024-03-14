NEOTERM_PKG_HOMEPAGE=http://sophia.systems/
NEOTERM_PKG_DESCRIPTION="Advanced transactional MVCC key-value/row storage library"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2
NEOTERM_PKG_SRCURL=git+https://github.com/pmwkaa/sophia
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	install -Dm600 -t $NEOTERM_PREFIX/lib libsophia.a
	install -Dm600 -t $NEOTERM_PREFIX/lib libsophia.so.2.2.0
	ln -sfT libsophia.so.2.2.0 $NEOTERM_PREFIX/lib/libsophia.so.2.2
	ln -sfT libsophia.so.2.2.0 $NEOTERM_PREFIX/lib/libsophia.so
}
