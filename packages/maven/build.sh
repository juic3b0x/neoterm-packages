NEOTERM_PKG_HOMEPAGE=https://maven.apache.org/
NEOTERM_PKG_DESCRIPTION="A Java software project management and comprehension tool"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@masterjavaofficial"
NEOTERM_PKG_VERSION="3.9.6"
NEOTERM_PKG_SRCURL=https://dlcdn.apache.org/maven/maven-3/${NEOTERM_PKG_VERSION}/binaries/apache-maven-${NEOTERM_PKG_VERSION}-bin.tar.gz
NEOTERM_PKG_SHA256=6eedd2cae3626d6ad3a5c9ee324bd265853d64297f07f033430755bd0e0c3a4b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libjansi (>= 2.4.0-1), openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make_install() {
	# Remove starter scripts for Windows
	rm -f bin/*.cmd
	# Remove DLL for Windows
	rm -rf lib/jansi-native/Windows
	ln -sf $NEOTERM_PREFIX/lib/jansi/libjansi.so lib/jansi-native/
	rm -rf $NEOTERM_PREFIX/opt/maven
	mkdir -p $NEOTERM_PREFIX/opt
	cp -a $NEOTERM_PKG_SRCDIR $NEOTERM_PREFIX/opt/maven/
	# Symlink only starter scripts for Linux
	for i in mvn mvnDebug mvnyjp; do
		ln -sfr $NEOTERM_PREFIX/opt/maven/bin/$i $NEOTERM_PREFIX/bin/$i
	done
}
