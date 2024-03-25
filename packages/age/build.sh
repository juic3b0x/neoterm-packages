NEOTERM_PKG_HOMEPAGE=https://github.com/FiloSottile/age
NEOTERM_PKG_DESCRIPTION="A simple, modern and secure encryption tool with small explicit keys, no config options, and UNIX-style composability"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:1.1.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/FiloSottile/age/archive/v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=f1f3dbade631976701cd295aa89308681318d73118f5673cced13f127a91178c

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	cd $NEOTERM_PKG_SRCDIR
	go build ./cmd/age
	go build ./cmd/age-keygen
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin \
		"${NEOTERM_PKG_SRCDIR}"/age \
		"${NEOTERM_PKG_SRCDIR}"/age-keygen
}
