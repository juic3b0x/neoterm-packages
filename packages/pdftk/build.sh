NEOTERM_PKG_HOMEPAGE=https://gitlab.com/pdftk-java/pdftk
NEOTERM_PKG_DESCRIPTION="A simple tool for doing everyday things with PDF documents"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.3"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.com/pdftk-java/pdftk/-/archive/v${NEOTERM_PKG_VERSION}/pdftk-v${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=c144e0dd388db2f5e8e0b412c0d9be6c54e4db99a4575b6058a209f3603a333d
NEOTERM_PKG_DEPENDS="libbcprov-java, libcommons-lang3-java, openjdk-17"
NEOTERM_PKG_BUILD_DEPENDS="ant"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	mkdir -p lib
	ln -sf $NEOTERM_PREFIX/share/java/commons-lang3.jar lib/
	ln -sf $NEOTERM_PREFIX/share/java/bcprov.jar lib/
}

neoterm_step_make() {
	sh $NEOTERM_PREFIX/bin/ant jar
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/java
	install -Dm600 build/jar/pdftk.jar $NEOTERM_PREFIX/share/java/
	install -Dm700 pdftk $NEOTERM_PREFIX/bin/
}
