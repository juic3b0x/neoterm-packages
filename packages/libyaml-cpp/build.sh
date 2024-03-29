NEOTERM_PKG_HOMEPAGE=https://github.com/jbeder/yaml-cpp
NEOTERM_PKG_DESCRIPTION="A YAML parser and emitter in C++ matching the YAML 1.2 spec"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_SRCURL=https://github.com/jbeder/yaml-cpp/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fbe74bbdcee21d656715688706da3c8becfd946d92cd44705cc6098bb23b3a16
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DYAML_BUILD_SHARED_LIBS=ON
-DINSTALL_GTEST=OFF
"
