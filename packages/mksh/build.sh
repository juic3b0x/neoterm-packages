NEOTERM_PKG_HOMEPAGE=http://www.mirbsd.org/mksh.htm
NEOTERM_PKG_DESCRIPTION="The MirBSD Korn Shell - an enhanced version of the public domain ksh"
NEOTERM_PKG_LICENSE="Public Domain"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=59c
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R${NEOTERM_PKG_VERSION/./}.tgz
NEOTERM_PKG_SHA256=77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	sh Build.sh -r
}

neoterm_step_make_install() {
	install -Dm700 mksh "$NEOTERM_PREFIX"/bin/mksh
	install -Dm600 mksh.1 "$NEOTERM_PREFIX"/share/man/man1/mksh.1
}
