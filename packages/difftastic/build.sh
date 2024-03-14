NEOTERM_PKG_HOMEPAGE="https://github.com/Wilfred/difftastic"
NEOTERM_PKG_DESCRIPTION="difft: A structural diff that understands syntax"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.56.1"
NEOTERM_PKG_SRCURL="https://github.com/Wilfred/difftastic/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=54e4f3326be3c8fdd2263fd3ac9b31ea114c3c8d03efa6b928de33515ac41f24
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
# needed for MIME database (optional in upstream)
NEOTERM_PKG_RECOMMENDS="file"
