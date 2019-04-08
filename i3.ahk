#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; The Auto-Execute Section.  Everything before the first 'Return' gets executed when the script is first run.
; Note: Commas are optional after 
;DetectHiddenWindows, on
GroupAdd web, ahk_exe firefox.exe           ;Firefox
GroupAdd mail, ahk_exe outlook.exe          ;Outlook
GroupAdd mail, ahk_exe thunderbird.exe      ;Thunderbird
GroupAdd chat, ahk_exe pidgin.exe           ;Pidgin
GroupAdd chat, Conversations                ;Jabber
GroupAdd chat, Telegram Web
GroupAdd sql, ahk_exe ssms.exe              ;SQL Server Management Studio
GroupAdd ide, ahk_exe devenv.exe            ;Visual Studio
GroupAdd editor, ahk_exe gvim.exe           ;gVim
GroupAdd editor, ahk_exe notepad++.exe      ;Notepad++ 
GroupAdd editor, ahk_exe WinMergeU.exe      ;WinMerge
GroupAdd files, ahk_exe doublecmd.exe       ;Double Commander
GroupAdd files, ahk_class CabinetWClass     ;Windows Explorer
GroupAdd documents, ahk_exe AcroRd32.exe    ;Acrobat Reader
GroupAdd documents, ahk_exe winword.exe     ;Word
GroupAdd documents, ahk_exe EXCEL.exe       ;Excel
GroupAdd console, ahk_exe conemu64.exe      ;ConEmu

GroupAdd grouped, ahk_group web
GroupAdd grouped, ahk_group mail
GroupAdd grouped, ahk_group chat
GroupAdd grouped, ahk_group sql
GroupAdd grouped, ahk_group ide
GroupAdd grouped, ahk_group editor
GroupAdd grouped, ahk_group files
GroupAdd grouped, ahk_group documents
GroupAdd grouped, ahk_group console
Return

; Application launching and media control.
#Enter::
If !WinExist("ahk_exe conemu64.exe")
    Run C:\Program Files\ConEmu\conemu64.exe
	;Run C:\tools\cmder\cmder.exe
Else 
    GroupActivate console 
Return

#e::
    Run gvim.exe
Return

#p::
    Send {Media_Play_Pause}
Return    

#1::
If !WinExist("ahk_exe firefox.exe")
    Run firefox.exe
;GroupAdd web, ahk_exe firefox.exe
GroupActivate web, R
Return

#2::
If !WinExist("ahk_exe OUTLOOK.exe")
    Run outlook.exe
Else
    GroupActivate mail, R
Return

#3::
If !WinExist("ahk_exe pidgin.exe")
    Run pidgin.exe
;If !WinExist("ahk_exe CiscoJabber.exe")
    ;Run "C:\Program Files (x86)\Cisco Systems\Cisco Jabber\CiscoJabber.exe"
Else
    GroupActivate chat
Return

#4::
If !WinExist("ahk_exe ssms.exe")
    Run "C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Ssms.exe"
Else
    GroupActivate sql, R
Return

#5::
If !WinExist("ahk_exe devenv.exe")
    Run "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
Else
    GroupActivate ide, R
Return

#6::
If !WinExist("ahk_exe gvim.exe")
    Run gvim.exe
Else
    GroupActivate editor
Return

#7::
If !WinExist("ahk_exe doublecmd.exe")
    Run C:\Program Files\Double Commander\doublecmd.exe
Else
    GroupActivate files, R
Return

#8::GroupActivate documents, R

; Cycles through misc applications that don't belong to a group (yet).
#9::GroupDeactivate grouped, R
;WinGet pid, PID, A
;MsgBox "%pid%"
;Return

; To make Windows 7 behave like my i3 config
#+q::
    WinGetTitle, title, A
    WinClose, %title%
Return

#+r::Reload
;#+q::!F4
