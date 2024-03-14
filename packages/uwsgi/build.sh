NEOTERM_PKG_HOMEPAGE=https://projects.unbit.it/uwsgi
NEOTERM_PKG_DESCRIPTION="uWSGI application server container"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0.24"
NEOTERM_PKG_SRCURL=https://github.com/unbit/uwsgi/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6be644f8c36379a97ca1c71c03c146af109983a58eacefbcfdaaff3c62d7edf8
NEOTERM_PKG_DEPENDS="libandroid-glob, libandroid-sysv-semaphore, libcap, libcrypt, libjansson, libuuid, libxml2, openssl, pcre, python"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_get_source() {
	cp $NEOTERM_PKG_BUILDER_DIR/sys_time.c ./core/
}

neoterm_step_pre_configure() {
	export UWSGI_PYTHON_NOLIB=true
	export UWSGI_INCLUDES="$NEOTERM_PREFIX/include"
	export APPEND_CFLAGS="$CPPFLAGS
		-I$NEOTERM_PREFIX/include/python${NEOTERM_PYTHON_VERSION}
		-DOBSOLETE_LINUX_KERNEL
		"
	LDFLAGS+="
		-lpython${NEOTERM_PYTHON_VERSION}
		-landroid-glob
		-landroid-sysv-semaphore
		"
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin "$NEOTERM_PKG_BUILDDIR/uwsgi"
}

