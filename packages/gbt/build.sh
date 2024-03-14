NEOTERM_PKG_HOMEPAGE=https://github.com/jtyr/gbt
NEOTERM_PKG_DESCRIPTION="Highly configurable prompt builder for Bash and ZSH written in Go"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.0
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://github.com/jtyr/gbt/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b324695dc432e8e22bc257f7a6ec576f482ec418fb9c9a8301f47bfdf7766998
NEOTERM_PKG_AUTO_UPDATE=true
_COMMIT=29dc3dac6c06518073a8e879d2b6ec65291ddab2

neoterm_step_make_install() {
	cd $NEOTERM_PKG_SRCDIR

	neoterm_setup_golang

	export GOPATH=$HOME/go
	mkdir -p $GOPATH/{bin,pkg,src/github.com/jtyr}
	ln -fs $NEOTERM_PKG_SRCDIR $GOPATH/src/github.com/jtyr/gbt

	go mod init gbt
	go mod tidy
	go build -ldflags="-s -w -X main.version=$NEOTERM_PKG_VERSION -X main.build=${_COMMIT::6}" -o $NEOTERM_PREFIX/bin/gbt github.com/jtyr/gbt/cmd/gbt

	mkdir -p $NEOTERM_PREFIX/{doc/gbt,share/gbt}
	cp -r $NEOTERM_PKG_SRCDIR/{sources,themes} $NEOTERM_PREFIX/share/gbt/
	cp -r $NEOTERM_PKG_SRCDIR/{LICENSE,README.md} $NEOTERM_PREFIX/doc/gbt/
}
