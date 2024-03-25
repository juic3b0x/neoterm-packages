NEOTERM_PKG_HOMEPAGE=https://github.com/charmbracelet/glow
NEOTERM_PKG_DESCRIPTION="Render markdown on the CLI, with pizzazz!"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@charmbracelet"
NEOTERM_PKG_VERSION="1.5.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/charmbracelet/glow/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b4ecf269b7c6447e19591b1d23f398ef2b38a6a75be68458390b42d3efc44b92
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_RECOMMENDS=git

neoterm_step_make() {
        neoterm_setup_golang

        cd "$NEOTERM_PKG_SRCDIR"

        mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/charmbracelet"
        cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"
        cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"

        go get -d -v
        go build
}

neoterm_step_make_install() {
        install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/charmbracelet/glow/glow \
                $NEOTERM_PREFIX/bin/glow
}
