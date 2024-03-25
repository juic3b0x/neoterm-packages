NEOTERM_SUBPKG_INCLUDE="
bin/fetchmailconf
lib/python*
share/man/man1/fetchmailconf.1.gz
"
NEOTERM_SUBPKG_DESCRIPTION="A GUI configurator for generating fetchmail configuration files"
NEOTERM_SUBPKG_DEPENDS="python, python-tkinter"
NEOTERM_SUBPKG_PLATFORM_INDEPENDENT=true
NEOTERM_SUBPKG_CONFLICTS="fetchmail (<< 6.4.33)"
NEOTERM_SUBPKG_REPLACES="fetchmail (<< 6.4.33)"
