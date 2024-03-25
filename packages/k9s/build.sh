NEOTERM_PKG_HOMEPAGE=https://k9scli.io
NEOTERM_PKG_DESCRIPTION="Kubernetes CLI To Manage Your Clusters In Style!"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="0.32.3"
NEOTERM_PKG_SRCURL=https://github.com/derailed/k9s/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1b22781ff5f1f5ab0f8c831fe68609411627406198b7de71ac5ea80b7100700e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_DEPEDNS="mesa"

neoterm_step_make() {
        neoterm_setup_golang
        cd "$NEOTERM_PKG_SRCDIR"
        mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/derailed"
        cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/derailed/k9s"
        cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/derailed/k9s"

        go get -d -v
        go build
}

neoterm_step_make_install() {
        install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/derailed/k9s/k9s \
                 $NEOTERM_PREFIX/bin/k9s
}
