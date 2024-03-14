NEOTERM_PKG_HOMEPAGE=https://algernon.roboticoverlords.org/
NEOTERM_PKG_DESCRIPTION="Small self-contained web server with Lua, Markdown, QUIC, Redis and PostgreSQL support"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.16.0"
NEOTERM_PKG_SRCURL="https://github.com/xyproto/algernon/archive/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=68a14413df39f78d8e3baeffdac4e3829f0a49f4f32af5efa4a233d7dd25eaa7
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}"/src/github.com/xyproto
	ln -sf "${NEOTERM_PKG_SRCDIR}" "${GOPATH}"/src/github.com/xyproto/algernon

	cd "${GOPATH}"/src/github.com/xyproto/algernon || exit 1

	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"${GOPATH}"/src/github.com/xyproto/algernon/algernon \
		"${NEOTERM_PREFIX}"/bin/

	# Offline samples may be useful to get started with Algernon.
	rm -rf "${NEOTERM_PREFIX}"/share/doc/algernon
	mkdir -p "${NEOTERM_PREFIX}"/share/doc/algernon
	cp -a "${GOPATH}"/src/github.com/xyproto/algernon/samples \
		"${NEOTERM_PREFIX}"/share/doc/algernon/
}
