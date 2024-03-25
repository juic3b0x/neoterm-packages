NEOTERM_PKG_HOMEPAGE=https://www.v2fly.org/
NEOTERM_PKG_DESCRIPTION="A platform for building proxies to bypass network restrictions"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.14.1"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=git+https://github.com/v2fly/v2ray-core
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go get
	chmod +w $GOPATH -R
	rm -rf $NEOTERM_PREFIX/share/v2ray/
	mkdir -p $NEOTERM_PREFIX/share/v2ray/
	neoterm_download https://github.com/v2fly/geoip/releases/download/202306150049/geoip.dat \
		$NEOTERM_PREFIX/share/v2ray/geoip.dat \
		811085edc67057690c783e735182db32e5a4b446ee5f6d70ef9e12960ce910da
	neoterm_download https://github.com/v2fly/domain-list-community/releases/download/20230614081211/dlc.dat \
		$NEOTERM_PREFIX/share/v2ray/geosite.dat \
		bc72217e378cf0c726cb1507126f0d5b563096c42832305523a6c4d1806c15a3
	neoterm_download https://github.com/v2fly/geoip/releases/download/202306150049/geoip-only-cn-private.dat \
		$NEOTERM_PREFIX/share/v2ray/geoip-only-cn-private.dat \
		98f6b3a01e2896e908fc2481d1ebb5da74b204f68ab70ec51c8e525a7ed2515b
}

neoterm_step_make() {
	export GOPATH=$NEOTERM_PKG_SRCDIR/go
	go build -o v2ray ./main
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin v2ray
	install -Dm600 -t $NEOTERM_PREFIX/share/v2ray release/config/*.json
}
