NEOTERM_PKG_HOMEPAGE=https://git-lfs.github.com/
NEOTERM_PKG_DESCRIPTION="Git extension for versioning large files"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.5.1"
NEOTERM_PKG_SRCURL=https://github.com/git-lfs/git-lfs/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=d682a12c0bc48d08d28834dd0d575c91d53dd6c6db63c45c2db7c3dd2fb69ea4
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p "$GOPATH"/github.com/git-lfs
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/github.com/git-lfs/git-lfs

	cd "$GOPATH"/github.com/git-lfs/git-lfs
	! $NEOTERM_ON_DEVICE_BUILD && GOOS=linux GOARCH=amd64 CC=gcc LD=gcc go generate github.com/git-lfs/git-lfs/commands
	go build git-lfs.go
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/github.com/git-lfs/git-lfs/git-lfs \
		"$NEOTERM_PREFIX"/bin/git-lfs
}

neoterm_step_post_make_install() {
	# Remove read-only files generated in build process.
	chmod -R 700 "$NEOTERM_PKG_BUILDDIR"/pkg
	rm -rf "$NEOTERM_PKG_BUILDDIR"/pkg
}
