NEOTERM_PKG_HOMEPAGE=https://syncthing.net/
NEOTERM_PKG_DESCRIPTION="Decentralized file synchronization"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# NOTE: as of 1.12.0 compilation fails when package zstd is
# present in NEOTERM_PREFIX.
NEOTERM_PKG_VERSION="1.27.3"
NEOTERM_PKG_SRCURL=https://github.com/syncthing/syncthing/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fa2edae90c7999a6f667bba26a6c63c7165647f77c02c83860237c6d08ee4bbd
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	# The build.sh script doesn't with our compiler
	# so small adjustments to file locations are needed
	# so the build.go is fine.
	mkdir -p go/src/github.com/syncthing
	ln -sf "${NEOTERM_PKG_SRCDIR}" go/src/github.com/syncthing/syncthing

	# Set gopath so dependencies are built as in go get etc.
	export GOPATH="$(pwd)/go"

	cd go/src/github.com/syncthing/syncthing

	# Unset GOARCH so building build.go works.
	export GO_ARCH="${GOARCH}"
	export _CC="${CC}"
	export GO_OS="${GOOS}"
	unset GOOS GOARCH CC

	rm -rf vendor # syncthing has vendored dependencies, which fails with our compiler.
	# Now file structure is same as go get etc.
	go run build.go -goos "${GO_OS}" -goarch "${GO_ARCH}" \
		-cc "${_CC}" -version "v${NEOTERM_PKG_VERSION}" -no-upgrade build
}

neoterm_step_make_install() {
	cp "${GOPATH}"/src/github.com/syncthing/syncthing/syncthing $NEOTERM_PREFIX/bin/

	for section in 1 5 7; do
		local MANDIR=$NEOTERM_PREFIX/share/man/man$section
		mkdir -p $MANDIR
		cp $NEOTERM_PKG_SRCDIR/man/*.$section $MANDIR
	done
}
