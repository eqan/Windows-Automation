; Auto-execute section
#Requires AutoHotkey v1.1.37+

VimScriptPath := A_LineFile
Vim := new VimAhk()
Return

#Include %A_LineFile%\..\lib\vim_ahk.ahk
