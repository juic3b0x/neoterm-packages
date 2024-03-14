NEOTERM_SUBPKG_DESCRIPTION="Utilities for (un)mounting filesystems"
NEOTERM_SUBPKG_DEPENDS="libblkid, libsmartcols, libmount"
NEOTERM_SUBPKG_DEPEND_ON_PARENT="no"
NEOTERM_SUBPKG_BREAKS="neoterm-tools (<= 1.34.1)"
NEOTERM_SUBPKG_INCLUDE="
bin/findmnt
bin/fstrim
bin/lslocks
bin/mount
bin/swapoff
bin/swapon
bin/umount
share/bash-completion/completions/findmnt
share/bash-completion/completions/fstrim
share/bash-completion/completions/lslocks
share/bash-completion/completions/mount
share/bash-completion/completions/swapoff
share/bash-completion/completions/swapon
share/bash-completion/completions/umount
share/man/man8/findmnt.8.gz
share/man/man8/fstrim.8.gz
share/man/man8/lslocks.8.gz
share/man/man8/mount.8.gz
share/man/man8/swapoff.8.gz
share/man/man8/swapon.8.gz
share/man/man8/umount.8.gz
"
