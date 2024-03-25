NEOTERM_PKG_HOMEPAGE=https://miller.readthedocs.io/
NEOTERM_PKG_DESCRIPTION="Like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.11.0"
NEOTERM_PKG_SRCURL=git+https://github.com/johnkerl/miller
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	local dir="$GOPATH"/src/github.com/johnkerl/miller
	mkdir -p "$(dirname "${dir}")"
	ln -sfT "$NEOTERM_PKG_SRCDIR" "${dir}"
	NEOTERM_PKG_BUILDDIR="${dir}"
	cd "${dir}"
}

neoterm_step_configure() {
	:
}
