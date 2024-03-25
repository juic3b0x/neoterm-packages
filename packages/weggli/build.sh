NEOTERM_PKG_HOMEPAGE="https://github.com/googleprojectzero/weggli"
NEOTERM_PKG_DESCRIPTION="A fast and robust semantic search tool for C and C++ codebases"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.4"
NEOTERM_PKG_SRCURL="https://github.com/googleprojectzero/weggli/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=12fde9a0dca2852d5f819eeb9de85c4d11c5c384822f93ac66b2b7b166c3af78
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
}
