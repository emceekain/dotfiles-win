$SOURCE="H:\.dotfiles"
$DEST=$env:appdata

Copy-Item $SOURCE\doublecmd\doublecmd.xml -Destination $DEST\doublecmd\
Copy-Item $SOURCE\doublecmd\shortcuts.scf -Destination $DEST\doublecmd\
# WinMerge: Manually import/export the .ini file.
