NEOTERM_PKG_HOMEPAGE=https://alist.nn.ci
NEOTERM_PKG_DESCRIPTION="A file list program that supports multiple storage"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="2096779623 <admin@uneoterm.dev>"
NEOTERM_PKG_VERSION=(3.32.0) # alist version
NEOTERM_PKG_VERSION+=(3.32.0) # alist-web version
NEOTERM_PKG_SRCURL=(https://github.com/alist-org/alist/archive/v${NEOTERM_PKG_VERSION}.tar.gz
		   https://github.com/alist-org/alist-web/releases/download/${NEOTERM_PKG_VERSION[1]}/dist.tar.gz)
NEOTERM_PKG_SHA256=(3a7e17c7106488b769af41ef5058c3cf0bd18665aadce241ba90d1ec5a528d90
		   2af925073e521ffadd99866b65be54d495a4dce0b416446910230cd83b4b121f)
NEOTERM_PKG_BUILD_IN_SRC=true
# neoterm_pkg_upgrade_version couldn't check multiple versions now.
NEOTERM_PKG_AUTO_UPDATE=false

neoterm_step_post_get_source() {
	rm -rf public/dist
	mv -f dist public
}

neoterm_step_make() {
	neoterm_setup_golang

	local ldflags
	local _builtAt=$(date +'%F %T %z')
	local _goVersion=$(go version | sed 's/go version //')
	local _gitAuthor="Andy Hsu <i@nn.ci>"
	local _gitCommit=$(git ls-remote https://github.com/alist-org/alist refs/tags/v$NEOTERM_PKG_VERSION | head -c 7)
	export CGO_ENABLED=1

	ldflags="\
	-w -s \
	-X 'github.com/alist-org/alist/v3/internal/conf.BuiltAt=$_builtAt' \
	-X 'github.com/alist-org/alist/v3/internal/conf.GoVersion=$_goVersion' \
	-X 'github.com/alist-org/alist/v3/internal/conf.GitAuthor=$_gitAuthor' \
	-X 'github.com/alist-org/alist/v3/internal/conf.GitCommit=$_gitCommit' \
	-X 'github.com/alist-org/alist/v3/internal/conf.Version=$NEOTERM_PKG_VERSION' \
	-X 'github.com/alist-org/alist/v3/internal/conf.WebVersion=${NEOTERM_PKG_VERSION[1]}' \
	"
	go build -o "${NEOTERM_PKG_NAME}" -ldflags="$ldflags" -tags=jsoniter
}

neoterm_step_make_install() {
	install -Dm700 ./"${NEOTERM_PKG_NAME}" "${NEOTERM_PREFIX}"/bin

	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/bash-completion/completions/alist.bash"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/zsh/site-functions/_alist"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/fish/vendor_completions.d/alist.fish"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		alist completion bash > ${NEOTERM_PREFIX}/share/bash-completion/completions/alist.bash
		alist completion zsh > ${NEOTERM_PREFIX}/share/zsh/site-functions/_alist
		alist completion fish > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/alist.fish
	EOF
}
