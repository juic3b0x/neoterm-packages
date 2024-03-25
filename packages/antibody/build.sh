NEOTERM_PKG_HOMEPAGE=https://github.com/getantibody/antibody
NEOTERM_PKG_DESCRIPTION="The fastest shell plugin manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.1.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/getantibody/antibody/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=87bced5fba8cf5d587ea803d33dda72e8bcbd4e4c9991a9b40b2de4babbfc24f
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/getantibody
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/getantibody/antibody

	cd "$GOPATH"/src/github.com/getantibody/antibody
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/getantibody/antibody/antibody \
		"$NEOTERM_PREFIX"/bin/
}
