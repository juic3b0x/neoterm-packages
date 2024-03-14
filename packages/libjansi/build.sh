NEOTERM_PKG_HOMEPAGE=https://fusesource.github.io/jansi/
NEOTERM_PKG_DESCRIPTION="A small java library that allows you to use ANSI escape codes to format your console output"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.1"
NEOTERM_PKG_SRCURL=git+https://github.com/fusesource/jansi
NEOTERM_PKG_GIT_BRANCH=jansi-${NEOTERM_PKG_VERSION}
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	neoterm_download https://raw.githubusercontent.com/openjdk/jdk/jdk-11%2B28/src/java.base/unix/native/include/jni_md.h \
	    ${NEOTERM_PKG_CACHEDIR}/jni_md.h 48888b52ef525a8c92985b501162b2e4ca7bb2a742456e4c053c1417e8ccfff2
}

neoterm_step_make() {
    local s=$NEOTERM_PKG_SRCDIR/src/main/native/jansi
    ${CC} -o ${NEOTERM_PKG_SRCDIR}/libjansi.so \
        ${s}.c ${s}_isatty.c ${s}_structs.c ${s}_ttyname.c \
        ${CFLAGS} -fPIC -I${NEOTERM_PKG_CACHEDIR} ${LDFLAGS} -shared
}

neoterm_step_make_install() {
	install -Dm700 -t ${NEOTERM_PREFIX}/lib/jansi ${NEOTERM_PKG_SRCDIR}/libjansi.so
}
