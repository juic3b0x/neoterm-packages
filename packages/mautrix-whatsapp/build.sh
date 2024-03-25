NEOTERM_PKG_HOMEPAGE=https://maunium.net/go/mautrix-whatsapp/
NEOTERM_PKG_DESCRIPTION="A Matrix-WhatsApp puppeting bridge"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.5"
NEOTERM_PKG_SRCURL=https://github.com/mautrix/whatsapp/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4346ace8da9107d4d11b8fc8f63cf1e835d6813768a3535993404986a65b1699
NEOTERM_PKG_DEPENDS="libolm"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -ldflags "-X 'main.BuildTime=$(date '+%b %_d %Y, %H:%M:%S')'"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin mautrix-whatsapp
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME example-config.yaml
}
