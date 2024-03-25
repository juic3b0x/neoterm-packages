NEOTERM_PKG_HOMEPAGE=https://gitea.com/gitea/tea
NEOTERM_PKG_DESCRIPTION="The official CLI for Gitea"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.2"
NEOTERM_PKG_SRCURL=https://gitea.com/gitea/tea/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=b5a944de8db7d5af4aa87e9640261c925f094d2b6d26c4faf2701773acab219b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang
}

neoterm_step_make() {
	go mod vendor

	local SDK_VER=$(go list -f '{{.Version}}' -m code.gitea.io/sdk/gitea)
	go build \
		-ldflags "-X 'main.Version=${NEOTERM_PKG_VERSION}' -X 'main.SDK=${SDK_VER}'" \
		-o tea
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin ./tea
}
