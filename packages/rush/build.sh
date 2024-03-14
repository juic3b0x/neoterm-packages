NEOTERM_PKG_HOMEPAGE=https://github.com/shenwei356/rush
NEOTERM_PKG_DESCRIPTION="A cross-platform command-line tool for executing jobs in parallel"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="0.5.4"
NEOTERM_PKG_SRCURL=https://github.com/shenwei356/rush/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fe1d1a453b1ce64f6d27d1e89bef253ef7be2938cb901508d2845d71329b8ec5
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/shenwei356"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/shenwei356/rush"
	cd "${GOPATH}/src/github.com/shenwei356/rush"
	go get -d -v
	go install

	install -Dm700 $NEOTERM_PKG_BUILDDIR/bin/*/rush $NEOTERM_PREFIX/bin/
}
