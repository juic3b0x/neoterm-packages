NEOTERM_PKG_HOMEPAGE=https://hub.github.com/
NEOTERM_PKG_DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14.2
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://github.com/github/hub/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="git"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	neoterm_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"

	cd "${GOPATH}/src/github.com/github/hub"
	make man-pages
}

neoterm_step_pre_configure() {
	neoterm_setup_golang

	cd "$NEOTERM_PKG_SRCDIR"

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"
}

neoterm_step_make() {
	cd "${GOPATH}/src/github.com/github/hub"
	make bin/hub "prefix=$NEOTERM_PREFIX"
}

neoterm_step_make_install() {
	cd "${GOPATH}/src/github.com/github/hub"
	install -Dm700 ./bin/hub "$NEOTERM_PREFIX"/bin/hub

	install -D -m 600 -t "$NEOTERM_PREFIX"/share/man/man1 \
		"$NEOTERM_PKG_HOSTBUILD_DIR"/gopath/src/github.com/github/hub/share/man/man1/*.1
}
