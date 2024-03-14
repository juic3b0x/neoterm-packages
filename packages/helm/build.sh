NEOTERM_PKG_HOMEPAGE=https://helm.sh
NEOTERM_PKG_DESCRIPTION="Helm helps you manage Kubernetes applications"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.14.2"
NEOTERM_PKG_SRCURL=https://github.com/helm/helm/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=620384596e7f8513a4cb0462a561364bead1342020bb2b98a1303a5d026ab1c1
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	cd "$NEOTERM_PKG_SRCDIR"
	mkdir -p "${NEOTERM_PKG_BUILDDIR}/src/github.com/helm"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${NEOTERM_PKG_BUILDDIR}/src/github.com/helm/helm"
	cd "${NEOTERM_PKG_BUILDDIR}/src/github.com/helm/helm"
	make
}

neoterm_step_make_install() {
	install -Dm700 ${NEOTERM_PKG_BUILDDIR}/src/github.com/helm/helm/bin/helm \
		$NEOTERM_PREFIX/bin/helm
}
