Function ll { ls | sort -Descending LastWriteTime }
Function b { Set-Location ".." }

Function touch { 
    Param(
        [Parameter(Position = 0)]
        [String[]]
        $newFile
    )
    New-Item -ItemType "file" -Path $newFile
}
