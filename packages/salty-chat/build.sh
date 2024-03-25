NEOTERM_PKG_HOMEPAGE=https://salty.im/
NEOTERM_PKG_DESCRIPTION="A secure, easy, self-hosted messaging"
NEOTERM_PKG_LICENSE="MIT, WTFPL"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.0.22
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://git.mills.io/saltyim/saltyim/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fdc4dd8c0547f87f3c04022eb4558420eb07b136cc4de8b0d75b8b8cf47a0040
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy 
}


