NEOTERM_PKG_HOMEPAGE=https://jfrog.com/getcli
NEOTERM_PKG_DESCRIPTION="A CLI for JFrog products"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.53.2"
NEOTERM_PKG_SRCURL=https://github.com/jfrog/jfrog-cli/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=4630f31595b54b43d1bcbfa4e5a016625a188ea48cfdd94a54b517aa404db9ae
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	cd $NEOTERM_PKG_SRCDIR
	go mod init || :
	go mod tidy

	go build \
		-o "$NEOTERM_PREFIX/bin/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$NEOTERM_PKG_BUILDDIR/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/bash-completion/completions
	export JFROG_CLI_HOME_DIR=$NEOTERM_PKG_BUILDDIR/.jfrog
	mkdir -p $JFROG_CLI_HOME_DIR
	$NEOTERM_PKG_BUILDDIR/jfrog completion bash \
		> $JFROG_CLI_HOME_DIR/jfrog_bash_completion
	cp $JFROG_CLI_HOME_DIR/jfrog_bash_completion \
		$NEOTERM_PREFIX/share/bash-completion/completions/jfrog

}
