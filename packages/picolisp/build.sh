NEOTERM_PKG_HOMEPAGE=https://picolisp.com/wiki/?home
NEOTERM_PKG_DESCRIPTION="Lisp interpreter and application server framework"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="23.12"
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/p/picolisp/picolisp_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=a0633c191c813ae7e6b595713b68979273ddd68c4b6508a2fdb02f0c7bb60aae
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcrypt, libffi, openssl, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
# For 32-bit archs we nees to build minipicolisp
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_make() {
	sed -i "s|/usr/lib/picolisp/lib.l|${NEOTERM_PREFIX}/lib/picolisp/lib.l|" $NEOTERM_PKG_SRCDIR/bin/pil
	sed -i "s|/usr/lib/picolisp/lib.l|${NEOTERM_PREFIX}/lib/picolisp/lib.l|" $NEOTERM_PKG_SRCDIR/bin/vip
	cd $NEOTERM_PKG_SRCDIR/src
	$CC -O3 -c -emit-llvm base.ll
	$CC -O3 -w -c -D_OS="\"Android\"" -D_CPU="\"$NEOTERM_ARCH\"" `$PKGCONFIG --cflags libffi` -emit-llvm lib.c
	mkdir -p ../bin ../lib
	$CC $CFLAGS $LDFLAGS base.bc lib.bc -o ../bin/picolisp -rdynamic -lutil -lm -ldl -lreadline -lffi
	$STRIP ../bin/picolisp

	$CC -O3 -c -emit-llvm ext.ll
	$CC $CFLAGS $LDFLAGS ext.bc -o ../lib/ext.so -shared
	$STRIP ../lib/ext.so

	$CC -O3 -c -emit-llvm ht.ll
	$CC $CFLAGS $LDFLAGS ht.bc -o ../lib/ht.so -shared
	$STRIP ../lib/ht.so

	$CC -O3 -w $CFLAGS -I$NEOTERM_PREFIX/include -L$NEOTERM_PREFIX/lib $LDFLAGS -o ../bin/balance balance.c
	$CC -O3 -w $CFLAGS -I$NEOTERM_PREFIX/include -L$NEOTERM_PREFIX/lib $LDFLAGS -o ../bin/ssl ssl.c -lssl -lcrypto
	$CC -O3 -w $CFLAGS -I$NEOTERM_PREFIX/include -L$NEOTERM_PREFIX/lib $LDFLAGS -o ../bin/httpGate httpGate.c -lssl -lcrypto

	$CC -O3 -w -D_OS="\"Android\"" -D_CPU="\"$NEOTERM_ARCH\"" $CFLAGS -I$NEOTERM_PREFIX/include -L$NEOTERM_PREFIX/lib $LDFLAGS sysdefs.c -o ../bin/sysdefs-gen

	$STRIP ../bin/balance
	$STRIP ../bin/ssl
	$STRIP ../bin/httpGate
	$STRIP ../bin/sysdefs-gen
}

neoterm_step_make_install() {
	cd $NEOTERM_PKG_SRCDIR/src

	install -Dm755 -t $NEOTERM_PREFIX/bin ../bin/{picolisp,pil}
	install -Dm755 -t $NEOTERM_PREFIX/lib/picolisp/bin ../bin/{balance,httpGate,psh,ssl,sysdefs-gen,vip,watchdog}
	install -Dm644 -t $NEOTERM_PREFIX/lib/picolisp ../{ext.l,lib.css,lib.l}
	install -Dm644 -t $NEOTERM_PREFIX/share/man/man1 ../man/man1/*.1

	install -d -m755 $NEOTERM_PREFIX/lib/picolisp/lib
	cp -r ../lib $NEOTERM_PREFIX/lib/picolisp
	cp -r ../loc $NEOTERM_PREFIX/lib/picolisp
	cp -r ../src $NEOTERM_PREFIX/lib/picolisp
	cp -r ../test $NEOTERM_PREFIX/lib/picolisp
	cp -r ../doc $NEOTERM_PREFIX/lib/picolisp
	cp -r ../img $NEOTERM_PREFIX/lib/picolisp

	install -Dm644 ../lib/bash_completion $NEOTERM_PREFIX/share/bash-completion/completions/pil
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	$NEOTERM_PREFIX/lib/picolisp/bin/sysdefs-gen > $NEOTERM_PREFIX/lib/picolisp/lib/sysdefs
	EOF

	cat <<- EOF > ./prerm
	#!$NEOTERM_PREFIX/bin/sh
	rm -f $NEOTERM_PREFIX/lib/picolisp/lib/sysdefs
	EOF
}
