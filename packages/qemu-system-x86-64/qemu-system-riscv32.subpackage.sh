NEOTERM_SUBPKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
NEOTERM_SUBPKG_DEPEND_ON_PARENT=deps
NEOTERM_SUBPKG_CONFLICTS="qemu-system-riscv32-headless"

NEOTERM_SUBPKG_INCLUDE="
bin/qemu-system-riscv32
share/man/man1/qemu-system-riscv32.1.gz
"
