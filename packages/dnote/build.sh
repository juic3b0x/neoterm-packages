NEOTERM_PKG_HOMEPAGE=https://www.getdnote.com/
NEOTERM_PKG_DESCRIPTION="A simple command line notebook for programmers"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Ravener <ravener.anime@gmail.com>"
NEOTERM_PKG_VERSION="1:0.15.1"
NEOTERM_PKG_SRCURL=https://github.com/dnote/dnote/archive/refs/tags/cli-v${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=257d5f2374507b2790b31a314d7434bfe84b3178724ef73fdc4775c391220f93
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_BREAKS=dnote-client
NEOTERM_PKG_REPLACES=dnote-client

neoterm_step_pre_configure() {
	neoterm_setup_golang
	go mod download
}

neoterm_step_make() {
	cd "$NEOTERM_PKG_SRCDIR"
	go build -o dnote -ldflags "-X main.versionTag=${NEOTERM_PKG_VERSION:2}" -tags fts5 pkg/cli/main.go
}

neoterm_step_make_install() {
	install -Dm700 $NEOTERM_PKG_SRCDIR/dnote $NEOTERM_PREFIX/bin/dnote
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/pkg/cli/dnote-completion.bash \
		"$NEOTERM_PREFIX"/share/bash-completion/completions/dnote
	install -Dm600 "$NEOTERM_PKG_SRCDIR"/pkg/cli/dnote-completion.zsh \
		"$NEOTERM_PREFIX"/share/zsh/site-functions/_dnote
}

neoterm_step_install_license() {
	install -Dm600 -t "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PKG_SRCDIR}/licenses/GPLv3.txt"
	install -Dm600 -t "${NEOTERM_PREFIX}/share/doc/${NEOTERM_PKG_NAME}" \
		"${NEOTERM_PKG_SRCDIR}/LICENSE"
}

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	if grep -qP "^cli-v${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a CLI release($tag)"
	fi
}
