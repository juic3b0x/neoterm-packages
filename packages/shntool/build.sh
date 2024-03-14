NEOTERM_PKG_HOMEPAGE=http://shnutils.freeshell.org/shntool/
NEOTERM_PKG_DESCRIPTION="A multi-purpose WAVE data processing and reporting utility"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.10
NEOTERM_PKG_SRCURL=http://shnutils.freeshell.org/shntool/dist/src/shntool-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=74302eac477ca08fb2b42b9f154cc870593aec8beab308676e4373a5e4ca2102

neoterm_step_pre_configure() {
	autoreconf -fi
}
