NEOTERM_PKG_HOMEPAGE=https://restic.net/
NEOTERM_PKG_DESCRIPTION="Fast, secure, efficient backup program"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.4"
NEOTERM_PKG_SRCURL=https://github.com/restic/restic/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d736a57972bb7ee3398cf6b45f30e5455d51266f5305987534b45a4ef505f965
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SUGGESTS="openssh, rclone, restic-server"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/restic

	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/restic/restic
	cd "$GOPATH"/src/github.com/restic/restic

	(
		# Separately building for host so we can generate manpages.
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go build -ldflags "-X 'main.version=${NEOTERM_PKG_VERSION}'" ./cmd/...
		./restic generate --man doc/man
		rm -f ./restic
	)

	go build -ldflags "-X 'main.version=${NEOTERM_PKG_VERSION}'" ./cmd/...
}

neoterm_step_make_install() {
	cd "$GOPATH"/src/github.com/restic/restic
	install -Dm700 restic "$NEOTERM_PREFIX"/bin/restic
	install -Dm600 -t "$NEOTERM_PREFIX/share/man/man1/" doc/man/*.1
}
