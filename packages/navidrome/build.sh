NEOTERM_PKG_HOMEPAGE=https://www.navidrome.org/
NEOTERM_PKG_DESCRIPTION="🎧☁️ Modern Music Server and Streamer compatible with Subsonic/Airsonic"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="2096779623 <admin@uneoterm.dev>"
NEOTERM_PKG_VERSION="0.51.1"
NEOTERM_PKG_SRCURL=https://github.com/navidrome/navidrome/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fc962e3acbedfad63934eda016d4e380dd3a06b4636f2b1e61ade9700a2addcd
NEOTERM_PKG_DEPENDS="taglib, ffmpeg"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
        rm -f Makefile

        neoterm_setup_golang
        neoterm_setup_nodejs

        local GO_VERSION=$(grep "^go " $NEOTERM_PKG_SRCDIR/go.mod | cut -f 2 -d ' ')
        local NODE_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/golang/build.sh; echo $NEOTERM_PKG_VERSION)
        local GIT_SHA=$(git ls-remote https://github.com/navidrome/navidrome refs/tags/v$NEOTERM_PKG_VERSION | head -c 7)
        export GIT_TAG="v$NEOTERM_PKG_VERSION"
        # Build frontend
        cd $NEOTERM_PKG_SRCDIR/ui
        npm ci && npm run build

        # Build backend
        cd $NEOTERM_PKG_SRCDIR
        go build -o navidrome -ldflags="-X github.com/navidrome/navidrome/consts.gitSha=$GIT_SHA -X github.com/navidrome/navidrome/consts.gitTag=$GIT_TAG-SNAPSHOT" -tags=netgo
}

neoterm_step_make_install() {
        install -Dm755 -t "${NEOTERM_PREFIX}"/bin ${NEOTERM_PKG_SRCDIR}/navidrome

        install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/bash-completion/completions/navidrome.bash"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/zsh/site-functions/_navidrome"
	install -Dm644 /dev/null "${NEOTERM_PREFIX}/share/fish/vendor_completions.d/navidrome.fish"
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${NEOTERM_PREFIX}/bin/sh
		navidrome completion bash -n > ${NEOTERM_PREFIX}/share/bash-completion/completions/navidrome.bash
		navidrome completion zsh -n > ${NEOTERM_PREFIX}/share/zsh/site-functions/_navidrome
		navidrome completion fish -n > ${NEOTERM_PREFIX}/share/fish/vendor_completions.d/navidrome.fish
	EOF
}
