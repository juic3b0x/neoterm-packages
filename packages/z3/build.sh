NEOTERM_PKG_HOMEPAGE=https://github.com/Z3Prover/z3
NEOTERM_PKG_DESCRIPTION="Z3 is a theorem prover from Microsoft Research"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.13.0"
NEOTERM_PKG_SRCURL=https://github.com/Z3Prover/z3/archive/z3-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=01bcc61c8362e37bb89fd2430f7e3385e86df7915019bd2ce45de9d9bd934502
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	chmod +x scripts/mk_make.py
	CXX="$CXX" CC="$CC" python3 scripts/mk_make.py --prefix=$NEOTERM_PREFIX --build=$NEOTERM_PKG_BUILDDIR
	if $NEOTERM_ON_DEVICE_BUILD; then
		sed 's%../../../../../../../../%%g' -i Makefile
	else
		sed 's%../../../../../%%g' -i Makefile
	fi
}
