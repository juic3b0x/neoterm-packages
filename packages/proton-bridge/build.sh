NEOTERM_PKG_HOMEPAGE=https://github.com/ProtonMail/proton-bridge
NEOTERM_PKG_DESCRIPTION="ProtonMail Bridge application"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_VERSION="3.9.1"
NEOTERM_PKG_SRCURL=git+https://github.com/ProtonMail/proton-bridge
NEOTERM_PKG_GIT_BRANCH=v${NEOTERM_PKG_VERSION}
NEOTERM_PKG_MAINTAINER="Radomír Polách <rp@t4d.cz>"
NEOTERM_PKG_DEPENDS=libsecret
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE=latest-release-tag
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
# The go-rfc5322 module cannot currently be compiled for 32-bit OSes:
# https://github.com/ProtonMail/proton-bridge/blob/v2.1.1/BUILDS.md#prerequisites
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	cd "${NEOTERM_PKG_SRCDIR}" || exit 1

	make build-nogui
}

neoterm_step_make_install() {
	install -Dm700 "${NEOTERM_PKG_SRCDIR}"/bridge "${NEOTERM_PREFIX}"/bin/proton-bridge
}
