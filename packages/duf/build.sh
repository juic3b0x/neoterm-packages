NEOTERM_PKG_HOMEPAGE=https://github.com/muesli/duf
NEOTERM_PKG_DESCRIPTION="Disk usage/free utility"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION=0.8.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/muesli/duf/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ebc3880540b25186ace220c09af859f867251f4ecaef435525a141d98d71a27a
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
        neoterm_setup_golang

        cd "$NEOTERM_PKG_SRCDIR"

        mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/muesli"
        cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/muesli/duf"
        cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/muesli/duf"

        go get -d -v
        go build
}

neoterm_step_make_install() {
        install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/muesli/duf/duf \
                         $NEOTERM_PREFIX/bin/duf
        mkdir -p $NEOTERM_PREFIX/share/doc/duf

        install ${NEOTERM_PKG_BUILDDIR}/src/github.com/muesli/duf/README.md \
                        $NEOTERM_PREFIX/share/doc/duf
}
