$SOURCE="H:\.dotfiles"
$DEST=$env:appdata

Copy-Item $SOURCE\doublecmd\doublecmd.xml -Destination $DEST\doublecmd\ -Confirm
Copy-Item $SOURCE\doublecmd\shortcuts.scf -Destination $DEST\doublecmd\ -Confirm
# WinMerge: Manually import/export the .ini file.

# PowerShell
Copy-Item $SOURCE\Profile.ps1 -Destination $profile -Confirm
