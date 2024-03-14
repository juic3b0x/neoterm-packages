NEOTERM_PKG_HOMEPAGE=https://kubernetes.io/
NEOTERM_PKG_DESCRIPTION="Kubernetes.io client binary"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.29.2"
NEOTERM_PKG_SRCURL=https://dl.k8s.io/v$NEOTERM_PKG_VERSION/kubernetes-src.tar.gz
NEOTERM_PKG_SHA256=9169db94d43558ced700d5e8d323bdfca5707daf8317a7de85f9c4501ae5b9c0
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_get_source() {
	mkdir -p "$NEOTERM_PKG_CACHEDIR"
	mkdir -p "$NEOTERM_PKG_SRCDIR"

	neoterm_download "$NEOTERM_PKG_SRCURL" "$NEOTERM_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		"$NEOTERM_PKG_SHA256"

	tar xf "$NEOTERM_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		-C "$NEOTERM_PKG_SRCDIR"
}

neoterm_step_make() {
	neoterm_setup_golang

	# Needed to generate manpages.
	#(
	#	export GOPATH="$NEOTERM_PKG_BUILDDIR/host"
	#	unset GOOS GOARCH CGO_LDFLAGS
	#	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	#	cd "$NEOTERM_PKG_SRCDIR"
	#	./hack/update-generated-docs.sh
	#)

	export GOPATH="$NEOTERM_PKG_BUILDDIR/target"
	#chmod +w "$NEOTERM_PKG_SRCDIR"/_output
	#rm -rf "$NEOTERM_PKG_SRCDIR"/_output

	cd "$NEOTERM_PKG_SRCDIR"/cmd/kubectl
	go build .
}

neoterm_step_make_install() {
	install -Dm700 "$NEOTERM_PKG_SRCDIR"/cmd/kubectl/kubectl \
		"$NEOTERM_PREFIX"/bin/kubectl

	#mkdir -p "$NEOTERM_PREFIX"/share/man/man1
	#cp -f "$NEOTERM_PKG_SRCDIR"/docs/man/man1/kubectl-*.1 \
	#	"$NEOTERM_PREFIX"/share/man/man1/
}
