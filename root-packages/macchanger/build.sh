NEOTERM_PKG_HOMEPAGE=https://github.com/alobbs/macchanger
NEOTERM_PKG_DESCRIPTION="Utility that makes the maniputation of MAC addresses of network interfaces easier"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.7.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/alobbs/macchanger/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1d75c07a626321e07b48a5fe2dbefbdb98c3038bb8230923ba8d32bda5726e4f

neoterm_step_pre_configure() {
	./autogen.sh
}
