NEOTERM_PKG_HOMEPAGE="https://github.com/antonmedv/fx"
NEOTERM_PKG_DESCRIPTION="Interactive JSON viewer on your terminal"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@flosnvjx"
NEOTERM_PKG_VERSION="32.0.0"
NEOTERM_PKG_SRCURL="https://github.com/antonmedv/fx/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=584c7f1178bedec605a2487abe3f7909b05a9d13eff878edca2be4dab8f489f4
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	mkdir bin
	go build -o ./bin -trimpath
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/*
}
