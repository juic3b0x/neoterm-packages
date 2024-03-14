NEOTERM_PKG_HOMEPAGE=https://www.getdnote.com/
NEOTERM_PKG_DESCRIPTION="This package contains the Dnote server. It comprises of the web interface, the web API, and the background jobs."
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="Ravener <ravener.anime@gmail.com>"
NEOTERM_PKG_VERSION=2.1.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/dnote/dnote/archive/refs/tags/server-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5326694dd4c1721e52b871cebc3b99f9172d5e27c8eb71234cdf529bdcd14eee
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_SUGGESTS="postgresql"

neoterm_step_pre_configure() {
	neoterm_setup_nodejs
	neoterm_setup_golang

	go mod download

	# build assets for dnote-server:
	cd "$NEOTERM_PKG_SRCDIR/pkg/server/assets"
	npm i
	./js/build.sh
	./styles/build.sh
}

neoterm_step_make() {
	cd "$NEOTERM_PKG_SRCDIR"

	# build binary
	moduleName="github.com/dnote/dnote"
	ldflags="-X '$moduleName/pkg/server/buildinfo.CSSFiles=main.css' -X '$moduleName/pkg/server/buildinfo.JSFiles=main.js' -X '$moduleName/pkg/server/buildinfo.Version=$NEOTERM_PKG_VERSION' -X '$moduleName/pkg/server/buildinfo.Standalone=true'"

	go build -o dnote-server -ldflags "$ldflags" pkg/server/main.go
}

neoterm_step_make_install() {
	install -Dm700 $NEOTERM_PKG_SRCDIR/dnote-server $NEOTERM_PREFIX/bin/dnote-server
}

neoterm_step_install_license() {
	install -Dm600 -t "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PKG_SRCDIR}/licenses/AGPLv3.txt"
	install -Dm600 -t "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PKG_SRCDIR}/LICENSE"
}

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	if grep -qP "^server-v${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a SERVER release($tag)"
	fi
}
