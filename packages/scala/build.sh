NEOTERM_PKG_HOMEPAGE=https://www.scala-lang.org
NEOTERM_PKG_DESCRIPTION="Scala 3 compiler and standard library."
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.4.0"
NEOTERM_PKG_SRCURL=https://github.com/lampepfl/dotty/releases/download/$NEOTERM_PKG_VERSION/scala3-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ec2737b1ed436077d26eda3d02ac49e573011322fc2dcd7fa3ded698a925f416
NEOTERM_PKG_DEPENDS="openjdk-17"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $NEOTERM_PREFIX/opt/scala
	mkdir -p $NEOTERM_PREFIX/opt/scala
	cp -r ./* $NEOTERM_PREFIX/opt/scala/
	for i in $NEOTERM_PREFIX/opt/scala/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $NEOTERM_PREFIX/bin/$(basename $i)
	done
}
