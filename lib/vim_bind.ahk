#Include %A_LineFile%\..\bind\vim_shortcut.ahk
; Include the generic normal-mode blocker first so the specific Vim
; movement/edit bindings declared below take precedence.
#Include %A_LineFile%\..\bind\vim_disable.ahk
#Include %A_LineFile%\..\bind\vim_enter_normal.ahk
#Include %A_LineFile%\..\bind\vim_enter_insert.ahk
#Include %A_LineFile%\..\bind\vim_repeat.ahk
#Include %A_LineFile%\..\bind\vim_normal.ahk
#Include %A_LineFile%\..\bind\vim_replace.ahk
#Include %A_LineFile%\..\bind\vim_move.ahk
#Include %A_LineFile%\..\bind\vim_ydcxp.ahk
#Include %A_LineFile%\..\bind\vim_visual.ahk
#Include %A_LineFile%\..\bind\vim_search.ahk
#Include %A_LineFile%\..\bind\vim_command.ahk
; Reset the condition
#If
