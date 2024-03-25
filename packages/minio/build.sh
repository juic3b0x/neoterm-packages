NEOTERM_PKG_HOMEPAGE=https://min.io/
NEOTERM_PKG_DESCRIPTION="Multi-Cloud Object Storage"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2024.03.10.02.53.48"
_VERSION=$(sed 's/\./T/3;s/\./-/g' <<< $NEOTERM_PKG_VERSION)
NEOTERM_PKG_SRCURL=https://github.com/minio/minio/archive/refs/tags/RELEASE.${_VERSION}Z.tar.gz
NEOTERM_PKG_SHA256=8ee8fc38029a43d7bf170c14661af6e7541b729466c939a9123914ef8474975e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/T/-/g;s/[^0-9-]//g;s/-/./g'
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang
}

neoterm_step_make() {
	local _COMMITID=$(git ls-remote https://github.com/minio/minio refs/tags/RELEASE.${_VERSION}Z | cut -f1)
	local _SHORTCOMMITID=$(git ls-remote https://github.com/minio/minio refs/tags/RELEASE.${_VERSION}Z | head -c 12)

	MINIOLDFLAGS="\
	-w -s \
	-X 'github.com/minio/minio/cmd.Version=${_VERSION}Z' \
	-X 'github.com/minio/minio/cmd.CopyrightYear=$(date +%Y)' \
	-X 'github.com/minio/minio/cmd.ReleaseTag=RELEASE.${_VERSION}Z'\
	-X 'github.com/minio/minio/cmd.CommitID=${_COMMITID}' \
	-X 'github.com/minio/minio/cmd.ShortCommitID=${_SHORTCOMMITID}' \
	-X 'github.com/minio/minio/cmd.GOPATH=$(go env GOPATH)' \
	-X 'github.com/minio/minio/cmd.GOROOT=$(go env GOROOT)' \
	"
	CGO_ENABLED=0 go build -tags kqueue -trimpath --ldflags="$MINIOLDFLAGS" -o minio
}
neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin minio
}
