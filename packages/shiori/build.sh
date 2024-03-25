NEOTERM_PKG_HOMEPAGE=https://github.com/go-shiori/shiori
NEOTERM_PKG_DESCRIPTION="Simple bookmark manager built with Go"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_VERSION="1.5.5"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/go-shiori/shiori/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=979f9b30f7115ffb3374d882b05c45fda2ef52d48507ea4cccad332842189dda
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/go-shiori/
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/go-shiori/shiori
	cd "$GOPATH"/src/github.com/go-shiori/shiori/
	go get -d -v

	# https://github.com/juic3b0x/neoterm-packages/issues/18395
	# https://gitlab.com/cznic/libc/-/blob/master/libc_linux.go
	if [[ "${NEOTERM_ARCH_BITS}" == "32" ]]; then
		local libc_version=$(grep modernc.org/libc go.mod | awk '{print $2}')
		go mod edit -replace "modernc.org/libc@${libc_version}=./libc"
		rm -fr libc
		cp --no-preserve=mode,ownership -fr "${GOPATH}/pkg/mod/modernc.org/libc@${libc_version}" libc
		sed -e "s|unix.SYS_GETEUID|unix.SYS_GETEUID32|" -i ./libc/libc_linux.go
	fi

	go build
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "$GOPATH"/src/github.com/go-shiori/shiori/shiori
	mkdir -p "${NEOTERM_PREFIX}"/share/doc/shiori
	cp -a "$NEOTERM_PKG_SRCDIR"/docs/ "$NEOTERM_PREFIX"/share/doc/shiori
}
