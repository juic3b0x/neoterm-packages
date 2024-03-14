NEOTERM_PKG_HOMEPAGE="https://www.shellcheck.net/"
NEOTERM_PKG_DESCRIPTION="Shell script analysis tool"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Aditya Alok <alok@neoterm.dev>"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://hackage.haskell.org/package/ShellCheck-${NEOTERM_PKG_VERSION}/ShellCheck-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=62080e8a59174b12ecd2d753af3e6b9fed977e6f5f7301cde027a54aee555416
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="libffi"
NEOTERM_PKG_BUILD_DEPENDS="ghc-libs"

neoterm_step_pre_configure() {
	./striptests
}
