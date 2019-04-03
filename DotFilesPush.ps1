$SOURCE=$env:appdata
$DEST="H:\.dotfiles"

Copy-Item $SOURCE\doublecmd\doublecmd.xml -Destination $DEST\doublecmd\ -Confirm
Copy-Item $SOURCE\doublecmd\shortcuts.scf -Destination $DEST\doublecmd\ -Confirm
# WinMerge: Manually import/export the .ini file.

# PowerShell
Copy-Item $profile -Destination $DEST\Profile.ps1 -Confirm
