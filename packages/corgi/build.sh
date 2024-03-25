NEOTERM_PKG_HOMEPAGE=https://github.com/DrakeW/corgi
NEOTERM_PKG_DESCRIPTION="CLI workflow manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.4"
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/DrakeW/corgi/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=783fa88c29aecfbd8a557c186cee4d2f41927a3147464d4ccabb99600e3a02e6
NEOTERM_PKG_RECOMMENDS="fzf"
NEOTERM_PKG_SUGGESTS="peco"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go mod init main.go
	go get
	chmod +w $GOPATH -R
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go build -o corgi
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/corgi
}

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/etc/profile.d
	cat <<- EOF > "$NEOTERM_PREFIX"/etc/profile.d/corgi.sh
	#!$NEOTERM_PREFIX/bin/sh
	export HISTFILE=\$SHELL
	EOF
}
