NEOTERM_PKG_HOMEPAGE=https://github.com/docker/compose
NEOTERM_PKG_DESCRIPTION="Compose is a tool for defining and running multi-container Docker applications."
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.24.7"
NEOTERM_PKG_SRCURL="https://github.com/docker/compose/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=f671c42b2189372e2128a0abf218c04cc92693ef8960c3d26aab60bf7ca4febf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS=docker

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR
	cd $NEOTERM_PKG_SRCDIR
	mkdir bin/
	if ! [ -z "$GOOS" ];then export GOOS=android;fi
	go build -o bin/docker-compose -ldflags="-s -w -X github.com/docker/compose/v2/internal.Version=${NEOTERM_PKG_VERSION}" ./cmd
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin "${NEOTERM_PKG_SRCDIR}"/bin/docker-compose
}
