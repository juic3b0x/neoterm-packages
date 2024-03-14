NEOTERM_PKG_HOMEPAGE=https://etsh.nl
NEOTERM_PKG_DESCRIPTION="An enhanced, backward-compatible port of Thompson Shell"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.4.0
NEOTERM_PKG_SRCURL=https://etsh.nl/src/etsh_${NEOTERM_PKG_VERSION}/etsh-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fd4351f50acbb34a22306996f33d391369d65a328e3650df75fb3e6ccacc8dce
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	sh ./mkconfig
}
