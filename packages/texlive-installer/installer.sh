#!@NEOTERM_PREFIX@/bin/bash
set -e
export PREFIX=@NEOTERM_PREFIX@
export TMPDIR=@NEOTERM_PREFIX@/tmp

echo ""
echo "You will now be shown texlive's install-tl text gui."
echo "You can customize settings, but you have to use the"
echo "default TEXDIR and custom binaries or else texlive"
echo "is unable to find and run the binaries."
echo ""
echo "Press 'c' to continue"

read -n 1 -s -r ANSWER
case $ANSWER in
    c|C)
        ;;
    *)
        echo '[!] Aborting...'
        exit 1
esac

echo ""
echo "[*] Loading..."

# Update path to make sure the binaries are found
source $PREFIX/etc/profile.d/texlive.sh

$PREFIX/opt/texlive/install-tl/install-tl \
    -custom-bin $PREFIX/bin/texlive \
    -init-from-profile $PREFIX/opt/texlive/neoterm.profile \
    "$@"

echo "[*] Installation done."
echo ""
echo "    Some scripts need to be fixed before they will work in neoterm."
echo "    The script neoterm-patch-texlive will now be run to try to fix"
echo "    known problems. If your texlive breaks in the future after running"
echo "    tlmgr update --all"
echo "    then you might be able to fix it by running this script."
echo ""
echo "Press 'c' to continue"

read -n 1 -s -r ANSWER
case $ANSWER in
    c|C)
        ;;
    *)
        echo '[!] Aborting...'
        exit 1
esac

$PREFIX/bin/neoterm-patch-texlive

echo "[*] Generating format pdflatex with fmtutil"
fmtutil-sys --quiet --byfmt pdflatex

echo "[*] Running updmap"
updmap-sys --quiet

if command texlinks; then
    echo "[*] Setting up symlinks"
    texlinks
else
    echo "[!] texlive-scripts-extra is not installed, skipping to run texlinks"
fi

echo "[*] All done. Restart the shell or source"
echo "    $PREFIX/etc/profile.d/texlive.sh"
echo "    to add the texlive programs to \$PATH."

exit 0
