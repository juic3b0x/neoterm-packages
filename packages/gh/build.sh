NEOTERM_PKG_HOMEPAGE=https://cli.github.com/
NEOTERM_PKG_DESCRIPTION="GitHub’s official command line tool"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="2.45.0"
NEOTERM_PKG_SRCURL=https://github.com/cli/cli/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=61363c109487a17fad44dff3a55f0c7dd36c8d6e4d7b630755705bd3aa34a323
NEOTERM_PKG_RECOMMENDS="openssh"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"
	(
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go run ./cmd/gen-docs --man-page --doc-path $NEOTERM_PREFIX/share/man/man1/
	)
	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/cli/
	mkdir -p "$NEOTERM_PREFIX"/share/doc/gh
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/cli/cli
	cd "$GOPATH"/src/github.com/cli/cli/cmd/gh
	go get -d -v
	go build -ldflags="-X github.com/cli/cli/v${NEOTERM_PKG_VERSION%%.*}/internal/build.Version=$NEOTERM_PKG_VERSION"
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/cli/cli/cmd/gh/gh
	install -Dm600 -t "$NEOTERM_PREFIX"/share/doc/gh/ "$NEOTERM_PKG_SRCDIR"/docs/*

	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/bash-completion/completions/gh.bash
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/zsh/site-functions/_gh
	install -Dm644 /dev/null "$NEOTERM_PREFIX"/share/fish/vendor_completions.d/gh.fish
}

neoterm_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		gh completion -s bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/gh.bash
		gh completion -s zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_gh
		gh completion -s fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/gh.fish
	EOF
}
