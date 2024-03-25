NEOTERM_PKG_HOMEPAGE=https://github.com/hashicorp/hcl
NEOTERM_PKG_DESCRIPTION="A toolkit for creating structured configuration languages"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.20.0"
NEOTERM_PKG_SRCURL=https://github.com/hashicorp/hcl/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7918d30a5c847c90f6eaeef35f327a986befd99131e1b5cd94b58295963fbb34
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

_HCL_TOOLS="hcldec hclfmt hclspecsuite"

neoterm_step_pre_configure() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

neoterm_step_make() {
	for f in $_HCL_TOOLS; do
		go install ./cmd/$f
	done
}

neoterm_step_make_install() {
	for f in $_HCL_TOOLS; do
		install -Dm700 -t $NEOTERM_PREFIX/bin $GOPATH/bin/*/$f
	done
}
