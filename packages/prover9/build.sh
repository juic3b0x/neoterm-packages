NEOTERM_PKG_HOMEPAGE=https://www.cs.unm.edu/~mccune/prover9/
NEOTERM_PKG_DESCRIPTION="An automated theorem prover for first-order and equational logic"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2009-11A
NEOTERM_PKG_SRCURL=https://www.cs.unm.edu/~mccune/mace4/download/LADR-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c32bed5807000c0b7161c276e50d9ca0af0cb248df2c1affb2f6fc02471b51d0
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e all"
NEOTERM_MAKE_PROCESSES=1

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
}
