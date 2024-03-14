NEOTERM_PKG_HOMEPAGE=https://github.com/hetznercloud/cli
NEOTERM_PKG_DESCRIPTION="Hetzner Cloud command line client"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.42.0"
NEOTERM_PKG_SRCURL=https://github.com/hetznercloud/cli/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b99ec2b89d1485c3b14d6db2966cc355c9173ca98fe29754216b70f72317d8ad
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	# Below are taken from github.com/hetznercloud/cli@v1.30.1/.goreleaser.yml
	local CGO_ENABLED=0
	local LD_FLAGS="-s -w -X 'github.com/hetznercloud/cli/internal/version.Version=v${NEOTERM_PKG_VERSION}'"
	go build -ldflags "${LD_FLAGS}" -o hcloud  cmd/hcloud/main.go 
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin hcloud
}
