NEOTERM_PKG_HOMEPAGE=https://rclone.org/
NEOTERM_PKG_DESCRIPTION="rsync for cloud storage"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.66.0"
NEOTERM_PKG_SRCURL=https://github.com/rclone/rclone/releases/download/v${NEOTERM_PKG_VERSION}/rclone-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6d623f0fac370b54152399de17aaf49835a2703db0f59a40e411e3a1559a065d
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	cd $NEOTERM_PKG_SRCDIR

	neoterm_setup_golang

	mkdir -p .gopath/src/github.com/rclone
	ln -sf "$PWD" .gopath/src/github.com/rclone/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -ldflags "-X github.com/rclone/rclone/fs.Version=v${NEOTERM_PKG_VERSION}-neoterm" -tags noselfupdate -o rclone

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $NEOTERM_PREFIX/bin/rclone
	mkdir -p $NEOTERM_PREFIX/share/man/man1/
	cp rclone.1 $NEOTERM_PREFIX/share/man/man1/
}
