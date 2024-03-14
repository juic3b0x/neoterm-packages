NEOTERM_PKG_HOMEPAGE=https://github.com/emersion/hydroxide
NEOTERM_PKG_DESCRIPTION="A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.28"
NEOTERM_PKG_SRCURL=https://github.com/emersion/hydroxide/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c860a15617dce7916917ef6e3d906e5728114ec2a54f5c07fb489ee6bdbeb0f4
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	cd $NEOTERM_PKG_SRCDIR
	go build ./cmd/hydroxide
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin "${NEOTERM_PKG_SRCDIR}"/hydroxide
}
