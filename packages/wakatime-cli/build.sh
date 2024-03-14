NEOTERM_PKG_HOMEPAGE=https://wakatime.com/plugins/
NEOTERM_PKG_DESCRIPTION="Command line interface used by all WakaTime text editor plugins"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.89.1"
NEOTERM_PKG_SRCURL=https://github.com/wakatime/wakatime-cli/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0bb2f9dc84280dbd80a683ded6699305b7ea9b28c1b84b556cf13d613b910a9a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
        rm -f Makefile
        neoterm_setup_golang

        local _REPO=github.com/wakatime/wakatime-cli
        local _COMMIT=$(git ls-remote https://github.com/wakatime/wakatime-cli refs/tags/v$NEOTERM_PKG_VERSION | head -c 7)
        local _DATE=$(date -u '+%Y-%m-%dT%H:%M:%S %Z')
        CGO_ENABLED=0 go build -o wakatime-cli -ldflags="-s -w -X '${_REPO}/pkg/version.BuildDate=${_DATE}' -X '${_REPO}/pkg/version.Commit=${_COMMIT}' -X '${_REPO}/pkg/version.Version=${NEOTERM_PKG_VERSION}' -X '${_REPO}/pkg/version.OS=android' -X '${_REPO}/pkg/version.Arch=$(go env GOARCH)'" 
}

neoterm_step_make_install() {
        install -Dm755 -t "${NEOTERM_PREFIX}"/bin ${NEOTERM_PKG_SRCDIR}/wakatime-cli
}
