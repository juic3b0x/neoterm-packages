NEOTERM_PKG_HOMEPAGE=https://busybox.net/
NEOTERM_PKG_DESCRIPTION="Tiny versions of many common UNIX utilities into a single small executable"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.36.1
NEOTERM_PKG_SRCURL=https://busybox.net/downloads/busybox-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=b8cc24c9574d809e7279c3be349795c5d5ceb6fdf19ca709f80cde50e47de314
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_SERVICE_SCRIPT=(
	"telnetd" 'exec busybox telnetd -F'
	"ftpd" "exec busybox tcpsvd -vE 0.0.0.0 8021 busybox ftpd -w $NEOTERM_ANDROID_HOME"
	"busybox-httpd" "exec busybox httpd -f -p 0.0.0.0:8080 -h $NEOTERM_PREFIX/srv/www/ 2>&1"
)

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi
}

neoterm_step_configure() {
	# Prevent spamming logs with useless warnings to make them more readable.
	CFLAGS+=" -Wno-ignored-optimization-argument -Wno-unused-command-line-argument"

	sed -e "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" \
		-e "s|@NEOTERM_SYSROOT@|$NEOTERM_STANDALONE_TOOLCHAIN/sysroot|g" \
		-e "s|@NEOTERM_HOST_PLATFORM@|${NEOTERM_HOST_PLATFORM}|g" \
		-e "s|@NEOTERM_CFLAGS@|$CFLAGS|g" \
		-e "s|@NEOTERM_LDFLAGS@|$LDFLAGS|g" \
		-e "s|@NEOTERM_LDLIBS@|log|g" \
		$NEOTERM_PKG_BUILDER_DIR/busybox.config > .config
	unset CFLAGS LDFLAGS
	make oldconfig
}

neoterm_step_make_install() {
	# Using unstripped variant. The post-massage step will strip binaries anyway.
	install -Dm700 ./0_lib/busybox_unstripped $NEOTERM_PREFIX/bin/busybox
	install -Dm700 ./0_lib/libbusybox.so.${NEOTERM_PKG_VERSION}_unstripped $NEOTERM_PREFIX/lib/libbusybox.so.${NEOTERM_PKG_VERSION}
	ln -sfr $NEOTERM_PREFIX/lib/libbusybox.so.${NEOTERM_PKG_VERSION} $NEOTERM_PREFIX/lib/libbusybox.so

	# Install busybox man page.
	install -Dm600 -t $NEOTERM_PREFIX/share/man/man1 $NEOTERM_PKG_SRCDIR/docs/busybox.1
}
