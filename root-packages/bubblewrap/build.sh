NEOTERM_PKG_HOMEPAGE="https://github.com/containers/bubblewrap"
NEOTERM_PKG_DESCRIPTION="Unprivileged sandboxing tool"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_SRCURL="https://github.com/containers/bubblewrap/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=8ede2b605d5aaf68aaa6ef1a5264ba7a31108c98417a8f88d289d0b5fa820c1b
NEOTERM_PKG_DEPENDS="libcap, bash-completion"
NEOTERM_PKG_BUILD_DEPENDS="docbook-xsl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS='
-Dselinux=disabled
'
# patch was based on v0.6.2
NEOTERM_PKG_AUTO_UPDATE=false
