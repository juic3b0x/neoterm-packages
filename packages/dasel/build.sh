NEOTERM_PKG_HOMEPAGE=https://github.com/TomWright/dasel
NEOTERM_PKG_DESCRIPTION="Select, put and delete data from JSON, TOML, YAML, XML and CSV files with a single utility"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.6.0"
NEOTERM_PKG_SRCURL=https://github.com/TomWright/dasel/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=1428a0ddbe93175215f25d4dea71fb96f654fc60723b276c296ea82eca26b014
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	mkdir bin
	go build -o ./bin -trimpath ./cmd/dasel
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME README.*
}
