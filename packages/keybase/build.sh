NEOTERM_PKG_HOMEPAGE=https://keybase.io
NEOTERM_PKG_DESCRIPTION="Key directory that maps social media identities to encryption keys"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.2.8"
NEOTERM_PKG_SRCURL=https://github.com/keybase/client/releases/download/v$NEOTERM_PKG_VERSION/keybase-v$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=a17f9b987a20753922d1237e28ca6f1147af3e89e9c1d2dd22a11b5b083fdc33
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_REPLACES="kbfs"
NEOTERM_PKG_CONFLICTS="kbfs"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	cd go
	go mod init || :
	go mod tidy -compat=1.17
	mkdir .bin
	go build -v -tags 'production' -o ./.bin/keybase ./keybase
	go build -v -tags 'production' -o ./.bin/git-remote-keybase \
		./kbfs/kbfsgit/git-remote-keybase
	go build -v -tags 'production' -o ./.bin/kbfsfuse ./kbfs/kbfsfuse
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin \
		./go/.bin/{keybase,git-remote-keybase,kbfsfuse}
}
