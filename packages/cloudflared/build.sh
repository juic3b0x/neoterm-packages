NEOTERM_PKG_HOMEPAGE=https://github.com/cloudflare/cloudflared
NEOTERM_PKG_DESCRIPTION="A tunneling daemon that proxies traffic from the Cloudflare network to your origins"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2024.2.1"
NEOTERM_PKG_SRCURL=https://github.com/cloudflare/cloudflared/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c4a741ee532b8544a65a598e739e002ec04cfffb202119e3e2315e9ecc7dc07a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	local _DATE=$(date -u '+%Y.%m.%d-%H:%M UTC')
	go build -v -ldflags "-X \"main.Version=$NEOTERM_PKG_VERSION\" -X \"main.BuildTime=$_DATE\"" \
		./cmd/cloudflared
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin cloudflared
}
