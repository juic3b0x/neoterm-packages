NEOTERM_PKG_HOMEPAGE="https://github.com/kubernetes/minikube"
NEOTERM_PKG_DESCRIPTION="minikube implements a local Kubernetes cluster."
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.32.0"
NEOTERM_PKG_SRCURL="https://github.com/kubernetes/minikube/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=d8413766aa8ba81a6eee24d8ca8f2f7862029521630122b83ed892ec4f9b4960
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="docker, kubectl"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	mkdir -p bin
	go build -o bin/minikube ./cmd/minikube
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}"/bin bin/minikube
}
