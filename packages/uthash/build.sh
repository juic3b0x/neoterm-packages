NEOTERM_PKG_HOMEPAGE=https://troydhanson.github.io/uthash/
NEOTERM_PKG_DESCRIPTION="C preprocessor implementations of a hash table and a linked list"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.0
NEOTERM_PKG_SRCURL=https://github.com/troydhanson/uthash/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e10382ab75518bad8319eb922ad04f907cb20cccb451a3aa980c9d005e661acc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	cd src
	install -Dm600 -t $NEOTERM_PREFIX/include *.h
}
