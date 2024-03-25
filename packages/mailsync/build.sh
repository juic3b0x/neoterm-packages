NEOTERM_PKG_HOMEPAGE=https://mailsync.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A way of synchronizing a collection of mailboxes"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.2.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://master.dl.sourceforge.net/project/mailsync/mailsync/${NEOTERM_PKG_VERSION}/mailsync_${NEOTERM_PKG_VERSION}-1.tar.gz
NEOTERM_PKG_SHA256=041bff09050d7c57134b53455e9dc7f858c1f8ba968e0cee6c73a226793aa833
NEOTERM_PKG_DEPENDS="libc++, libc-client"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-c-client=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	autoreconf -fi
}
