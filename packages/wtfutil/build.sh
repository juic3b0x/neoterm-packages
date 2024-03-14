NEOTERM_PKG_HOMEPAGE=https://wtfutil.com/
NEOTERM_PKG_DESCRIPTION="The personal information dashboard for your terminal"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.43.0
NEOTERM_PKG_REVISION=2
# Need metadata in Git repository
NEOTERM_PKG_SRCURL=git+https://github.com/wtfutil/wtf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build -o wtfutil
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin wtfutil
}
