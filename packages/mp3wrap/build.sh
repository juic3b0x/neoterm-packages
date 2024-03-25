NEOTERM_PKG_HOMEPAGE=https://mp3wrap.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A command-line utility that wraps quickly two or more mp3 files in one single large playable mp3"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/mp3wrap/mp3wrap-${NEOTERM_PKG_VERSION}-src.tar.gz
NEOTERM_PKG_SHA256=1b4644f6b7099dcab88b08521d59d6f730fa211b5faf1f88bd03bf61fedc04e7

neoterm_step_pre_configure() {
	rm -f config.status
	autoreconf -fi
}
