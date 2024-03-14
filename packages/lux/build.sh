NEOTERM_PKG_HOMEPAGE=https://github.com/iawia002/lux
NEOTERM_PKG_DESCRIPTION="CLI tool to download videos from various websites"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="0.23.0"
NEOTERM_PKG_SRCURL="https://github.com/iawia002/lux/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=89554ef1eaa02705833ca76dfaed1c40a2ccae8d8e4aeb5221f6ffabb1592960
NEOTERM_PKG_RECOMMENDS="ffmpeg"
NEOTERM_PKG_SUGGESTS="aria2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	mkdir bin
	go build -o ./bin -trimpath
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
