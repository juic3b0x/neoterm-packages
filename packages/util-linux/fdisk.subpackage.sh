NEOTERM_SUBPKG_DESCRIPTION="Utilities to manipulate disk partition tables"
NEOTERM_SUBPKG_DEPENDS="libfdisk, libmount, ncurses, readline, libsmartcols"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_INCLUDE="
share/man/man8/cfdisk.8.gz
share/man/man8/fdisk.8.gz
share/man/man8/sfdisk.8.gz
share/bash-completion/completions/sfdisk
share/bash-completion/completions/fdisk
share/bash-completion/completions/cfdisk
bin/sfdisk
bin/fdisk
bin/cfdisk
"
