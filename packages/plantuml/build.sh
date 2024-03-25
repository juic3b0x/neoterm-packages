NEOTERM_PKG_HOMEPAGE=https://plantuml.com/
NEOTERM_PKG_DESCRIPTION="Draws UML diagrams, using a simple and human readable text description"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2024.3"
NEOTERM_PKG_SRCURL=https://github.com/plantuml/plantuml/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a6ceab469754ec747785bdb46516bec529a29a9104bec5f30f7b833121dafbff
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	$NEOTERM_PKG_SRCDIR/gradlew --no-daemon --parallel --stacktrace assemble
}

neoterm_step_make_install() {
	mkdir -p $NEOTERM_PREFIX/share/java
	install -Dm600 build/libs/plantuml-${NEOTERM_PKG_VERSION}.jar $NEOTERM_PREFIX/share/java/plantuml.jar
	install -Dm700 plantuml $NEOTERM_PREFIX/bin/
}
