NEOTERM_PKG_HOMEPAGE=https://gohugo.io/
NEOTERM_PKG_DESCRIPTION="A fast and flexible static site generator"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.123.8"
NEOTERM_PKG_SRCURL=https://github.com/gohugoio/hugo/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=12eaeaa260037d88526fb5eb56348f0d781f415f3cd2cf265ea3508a66b33c48
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	cd $NEOTERM_PKG_SRCDIR
	go build \
		-o "$NEOTERM_PREFIX/bin/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$NEOTERM_PKG_BUILDDIR/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/{bash-completion/completions,zsh/site-functions,fish/vendor_completions.d,man/man1}

	$NEOTERM_PKG_BUILDDIR/hugo completion bash > $NEOTERM_PREFIX/share/bash-completion/completions/hugo
	$NEOTERM_PKG_BUILDDIR/hugo completion zsh > $NEOTERM_PREFIX/share/zsh/site-functions/_hugo
	$NEOTERM_PKG_BUILDDIR/hugo completion fish > $NEOTERM_PREFIX/share/fish/vendor_completions.d/hugo.fish

	$NEOTERM_PKG_BUILDDIR/hugo gen man \
		--dir=$NEOTERM_PREFIX/share/man/man1/
}
