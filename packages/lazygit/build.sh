NEOTERM_PKG_HOMEPAGE=https://github.com/jesseduffield/lazygit
NEOTERM_PKG_DESCRIPTION="Simple terminal UI for git commands"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="0.40.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jesseduffield/lazygit/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=146bd63995fcf2f2373bbc2143b3565b7a2be49a1d4e385496265ac0f69e4128
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_RECOMMENDS=git

neoterm_step_make() {
        neoterm_setup_golang

        cd "$NEOTERM_PKG_SRCDIR"

        mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/jesseduffield"
        cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"
        cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"

        go get -d -v
        go build
}

neoterm_step_make_install() {
        mkdir -p $NEOTERM_PREFIX/share/doc/lazygit

        install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/lazygit \
                $NEOTERM_PREFIX/bin/lazygit

        cp -a ${NEOTERM_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/docs/* \
                $NEOTERM_PREFIX/share/doc/lazygit/

}
