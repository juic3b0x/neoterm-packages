NEOTERM_PKG_HOMEPAGE=https://github.com/theworkjoy/command-not-found-neoterm
NEOTERM_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=v0.3.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/theworkjoy/command-not-found-neoterm/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4c5d01cb93488c6ef62bee58fd470673a9cac7291224304cf3aa74b70cbaf7ea
NEOTERM_PKG_BREAKS="command-not-found"
NEOTERM_PKG_CONFLICTS="command-not-found"
neoterm_step_make_install() {
# Define the destination prefix
export prefix = /data/data/io.neoterm/files/usr

# Define the directories to be installed
export dirs = bin etc lib sbin share doc man python3

# Define the installation directory for each directory
export bin_PROGRAMS = $(prefix)/bin/command-not-found
export sbin_PROGRAMS = $(prefix)/sbin/update-command-not-found
export man8_MANS = $(prefix)/share/man/man8/update-command-not-found.8.gz
export doc_DATA = $(prefix)/share/doc/command-not-found/README.md
export python3_DATA = $(prefix)/share/python3/runtime.d/command-not-found.rtupdate

	mkdir -p $(DESTDIR)$(prefix)/share/command-not-found
	cp -r share/command-not-found/* $(DESTDIR)$(prefix)/share/command-not-found/
	cp -r lib/* $(DESTDIR)$(prefix)/lib/
	mkdir -p $(DESTDIR)$(prefix)/etc/apt/apt.conf.d
	cp -r etc/apt/apt.conf.d/* $(DESTDIR)$(prefix)/etc/apt/apt.conf.d/
	cp -r etc/* $(DESTDIR)$(prefix)/etc/
	mkdir -p $(DESTDIR)$(prefix)/share/doc/command-not-found
	cp -r share/doc/command-not-found/* $(DESTDIR)$(prefix)/share/doc/command-not-found/
	mkdir -p $(DESTDIR)$(prefix)/share/man/man8
	cp -r share/man/man8/* $(DESTDIR)$(prefix)/share/man/man8/
	cp -r bin/* $(DESTDIR)$(prefix)/bin/
	chmod 755 $(DESTDIR)$(prefix)/bin/command-not-found
	mkdir -p $(DESTDIR)$(prefix)/sbin
	cp -r sbin/* $(DESTDIR)$(prefix)/sbin/
	chmod 755 $(DESTDIR)$(prefix)/sbin/update-command-not-found
	@echo "Installation completed successfully."
}
