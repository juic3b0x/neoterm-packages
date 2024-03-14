NEOTERM_PKG_HOMEPAGE=https://github.com/int128/kubelogin
NEOTERM_PKG_DESCRIPTION="A kubectl plugin for Kubernetes OpenID Connect (OIDC) authentication"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Steeve Chailloux"
NEOTERM_PKG_VERSION="1.28.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/int128/kubelogin/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=04677625f10cb13f240673ae20f62d7866002143351be363c2ffec13737c5883
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
        neoterm_setup_golang
        cd "$NEOTERM_PKG_SRCDIR"
        mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/int128"
        cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/int128/kubelogin"
        cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/int128/kubelogin"

        go build -o kubelogin -ldflags "-X main.version=${NEOTERM_PKG_VERSION}"
}

neoterm_step_make_install() {
        install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/int128/kubelogin/kubelogin \
                 $NEOTERM_PREFIX/bin/kubectl-oidc_login
}
