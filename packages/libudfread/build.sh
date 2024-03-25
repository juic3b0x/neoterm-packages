NEOTERM_PKG_HOMEPAGE=https://code.videolan.org/videolan/libudfread/
NEOTERM_PKG_DESCRIPTION="A library for reading UDF"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.2
NEOTERM_PKG_SRCURL=https://code.videolan.org/videolan/libudfread/-/archive/${NEOTERM_PKG_VERSION}/libudfread-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2bf16726ac98d093156195bb049a663e07d3323e079c26912546f4e05c77bac5

neoterm_step_pre_configure() {
	autoreconf -fi
}
