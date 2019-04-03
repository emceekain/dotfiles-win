$SOURCE=$env:appdata
$DEST="H:\.dotfiles"

Copy-Item $SOURCE\doublecmd\doublecmd.xml -Destination $DEST\doublecmd\
