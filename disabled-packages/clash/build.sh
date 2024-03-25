NEOTERM_PKG_HOMEPAGE=https://github.com/Dreamacro/clash
NEOTERM_PKG_DESCRIPTION="A rule-based tunnel in Go"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Philipp Schmitt <philipp@schmitt.co>"
NEOTERM_PKG_VERSION="1.18.0"
NEOTERM_PKG_SRCURL="https://github.com/Dreamacro/clash/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=139794f50d3d94f438bab31a993cf25d7cbdf8ca8e034f3071e0dd0014069692
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"

	GOBUILD=CGO_ENABLED=0 \
		go build \
			-trimpath \
			-ldflags "-X 'github.com/Dreamacro/clash/constant.Version=${NEOTERM_PKG_VERSION}'
								-X 'github.com/Dreamacro/clash/constant.BuildTime=$(date -u)'
								-w -s -buildid='" \
			-o "clash.bin" \
			main.go
}

neoterm_step_make_install() {
	mv ./clash.bin "${NEOTERM_PREFIX}/bin/clash"
}
