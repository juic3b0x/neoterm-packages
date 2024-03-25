NEOTERM_PKG_HOMEPAGE=https://ant.apache.org/
NEOTERM_PKG_DESCRIPTION="Java based build tool like make"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.14
NEOTERM_PKG_SRCURL=https://dlcdn.apache.org//ant/binaries/apache-ant-${NEOTERM_PKG_VERSION}-bin.tar.bz2
NEOTERM_PKG_SHA256=4c19450831001e6e9d5d2a94c3350f542f04f44f070085759c24f39d3cda928d
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make_install() {
	mv ./bin/ant .
	rm -f ./bin/*
	mv ./ant ./bin/
	rm -rf manual
	rm -rf $NEOTERM_PREFIX/opt/ant
	mkdir -p $NEOTERM_PREFIX/opt/ant
	cp -r ./* $NEOTERM_PREFIX/opt/ant
	ln -sfr $NEOTERM_PREFIX/opt/ant/bin/ant $NEOTERM_PREFIX/bin/ant
}
