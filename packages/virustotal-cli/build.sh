NEOTERM_PKG_HOMEPAGE=https://github.com/VirusTotal/vt-cli
NEOTERM_PKG_DESCRIPTION="Command line interface for VirusTotal"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.0"
NEOTERM_PKG_SRCURL=https://github.com/VirusTotal/vt-cli/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=8fab50202ce3a3f8128e94565cb58cdc2cbf5f816fd7b0855d897a379c9cfaf6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="vt-cli"
NEOTERM_PKG_REPLACES="vt-cli"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/VirusTotal
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/VirusTotal/vt-cli

	cd "$GOPATH"/src/github.com/VirusTotal/vt-cli

	go build \
		-ldflags "-X github.com/VirusTotal/vt-cli/cmd.Version=$NEOTERM_PKG_VERSION" \
		-o "$NEOTERM_PREFIX"/bin/vt-cli \
		./vt/main.go
}

neoterm_step_make_install() {
	ln -sfr "$NEOTERM_PREFIX"/bin/vt-cli "$NEOTERM_PREFIX"/bin/vt
}
