NEOTERM_PKG_HOMEPAGE=https://www.terraform.io
NEOTERM_PKG_DESCRIPTION="A tool for building, changing, and versioning infrastructure safely and efficiently"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.4"
NEOTERM_PKG_SRCURL=https://github.com/hashicorp/terraform/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ab9e6d743c0a00be8c6c1a2723f39191e3cbd14517acbc3e6ff2baa753865074
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_ENABLE_CLANG16_PORTING=false
NEOTERM_PKG_DEPENDS="git"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH="${NEOTERM_PKG_BUILDDIR}"

	mkdir -p "${GOPATH}"/src/github.com/hashicorp
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}"/src/github.com/hashicorp/terraform

	cd "${GOPATH}"/src/github.com/hashicorp/terraform || exit 1

	go mod init || :
	go mod tidy

	# Backport of https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c
	neoterm_download "https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c.patch" \
		"${NEOTERM_PKG_TMPDIR}"/patch1 \
		2812df1db9e42473c30cdbc1f42ae4555027a1e56321189be9f50f52125c146c

	for f in "${GOPATH}"/pkg/mod/github.com/lib/pq@*/user_posix.go; do
		chmod 0755 "$(dirname "$f")"
		chmod 0644 "${f}"
		patch --silent -p1 -d "$(dirname "$f")" <"${NEOTERM_PKG_TMPDIR}"/patch1
		# The patch above does not fix build issue for some reason.
		# Alternative workaround:
		rm -f "${f}"
		echo "package pq" > "${f}"
	done

	local GO_LDFLAGS="-X 'github.com/hashicorp/terraform/version.Prerelease='"
	GO_LDFLAGS="${GO_LDFLAGS} -X 'github.com/hashicorp/terraform/version.Version=${NEOTERM_PKG_VERSION}'"

	go build -ldflags "${GO_LDFLAGS}" -o terraform .
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "${GOPATH}"/src/github.com/hashicorp/terraform/terraform
}
