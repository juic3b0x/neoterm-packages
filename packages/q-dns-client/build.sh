NEOTERM_PKG_HOMEPAGE=https://github.com/natesales/q
NEOTERM_PKG_DESCRIPTION="A tiny command line DNS client with support for UDP, TCP, DoT, DoH, DoQ and ODoH"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="kay9925@outlook.com"
NEOTERM_PKG_VERSION="0.19.1"
NEOTERM_PKG_SRCURL="git+https://github.com/natesales/q"
NEOTERM_PKG_SHA256=aee90d5e8421a9e64e4958bb967a9c6b2e31ff7bca4b8b03e278d559f813e076
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${NEOTERM_PKG_SHA256}  "* ]] ; then
		neoterm_error_exit "Checksum mismatch for source files."
	fi
}

neoterm_step_make() {
	neoterm_setup_golang

	local _builtAt=$(date +'%FT%T%Z')

	local ldflags="\
	-w -s \
	-X 'main.version=${NEOTERM_PKG_VERSION}' \
	-X 'main.commit=$(git log -1 --format=%H)' \
	-X 'main.date=${_builtAt}' \
	"

	export CGO_ENABLED=1

	go build -o "${NEOTERM_PKG_NAME}" -ldflags="$ldflags"
}

neoterm_step_make_install() {
	install -Dm700 ${NEOTERM_PKG_NAME} ${NEOTERM_PREFIX}/bin/q
}
