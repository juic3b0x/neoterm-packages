NEOTERM_PKG_HOMEPAGE=http://openfec.org
NEOTERM_PKG_DESCRIPTION="Application-Level Forward Erasure Correction implementation library"
NEOTERM_PKG_LICENSE="CeCILL-C"
NEOTERM_PKG_LICENSE_FILE="LICENCE_CeCILL-C_V1-en.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.2.9"
NEOTERM_PKG_SRCURL=https://github.com/roc-project/openfec/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=237b7af72eab7bd6e1314c4aaacd38bf318bdac762ae30c0d3cee3bb23ed8934
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libopenfec-dev"
NEOTERM_PKG_REPLACES="libopenfec-dev"

neoterm_step_make_install() {
	install -Dm600 "$NEOTERM_PKG_SRCDIR/bin/Release/libopenfec.so" "$NEOTERM_PREFIX/lib/libopenfec.so"

	cd $NEOTERM_PKG_SRCDIR/src
	local include; for include in $(find . -type f -iname \*.h | sed 's@^\./@@'); do
		install -Dm600 "$include" "$NEOTERM_PREFIX"/include/openfec/"$include"
	done
}
