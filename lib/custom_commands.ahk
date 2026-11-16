#MenuMaskKey vkFF

; Toggle desktop icons: hidden by default, reveal temporarily when needed.
^!d::
  RegRead, HideIcons, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideIcons
  if (HideIcons = 1)
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideIcons, 0
  else
    RegWrite, REG_DWORD, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideIcons, 1
  DllCall("Shell32\SHChangeNotify", "UInt", 0x08000000, "UInt", 0, "Ptr", 0, "Ptr", 0)
Return

; Open Keypirinha directly; its built-in Everything package provides fast file search.
#s::
  Run, "C:\Users\eqan\AppData\Local\Keypirinha\keypirinha.exe" --show,, Hide
Return

#+s::
  Run, "C:\Program Files\Flameshot\bin\flameshot.exe" gui --clipboard,, Hide
Return

; Function to run vscode as admin and in maximized form

#v::
  try {
    Run code, , Hide
  } catch {
    MsgBox, Could not obtain admin privileges.
  }
Return

; Function to run WezTerm as admin and in maximized form

#x::
  weztermPath := "C:\Program Files\WezTerm\wezterm-gui.exe"
  if !FileExist(weztermPath) {
    MsgBox, WezTerm was not found at %weztermPath%.
    Return
  }
  Run *RunAs "%weztermPath%", , max
Return

; Function to Call Live Draw

#\::
  Run,"D:\Softwares\Live Draw\LiveDraw.exe"
return

; Function to Call the Zen Browser

#b::
  Run, zen.exe
return

; Function to Call the word
#w::
  try {
    Run *RunAs winword, , max
  } catch {
    MsgBox, Could not open winword.
  }
Return

; Function to Call the Color Picker
#i::
  Run,"C:\Users\Eqan Ahmad\Desktop\jcpicker.exe"
return

; Restart the complete elevated Komorebi stack without opening a console window.
#o::
  Run, powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\eqan\.config\dotfiles-windows\komorebi\restart-komorebi.ps1", , Hide
return

; Function to Call the task manager
#t::
  Run,"C:\WINDOWS\system32\Taskmgr.exe"
return

; Keys for windows navigation
; !h:: Send !{Left}
; !l:: Send !{Right}

; Change Brightness
!;::RUN C:\Users\eqana\nircmd\nircmd.exe changebrightness 5
!'::RUN C:\Users\eqana\nircmd\nircmd.exe changebrightness -5


; Function returns list of windows
Unique_Alt_Tab_Windows()
{
  alt_tab_list := Array()
  class_list := ""
  WinGet, window_list, List
  Loop % window_list
  {
    this_hwnd := window_list%A_Index%

    WinGet, this_style, Style, ahk_id %this_hwnd%
    if (this_style & 0x10000000) && (this_style & 0x10000) ; 0x10000000 is WS_VISIBLE. 0x10000 is WS_MAXIMIZEBOX
    {
      WinGetTitle, this_title, ahk_id %this_hwnd%
      if((this_title = "") || (this_title = "Start"))
        continue
      else
      {
        WinGetClass, this_class, ahk_id %this_hwnd%
        if !InStr(class_list, this_class)
        {
          alt_tab_list.Insert(this_hwnd)
          class_list .= this_class . "|"
        }
      }
    }
  }
  return alt_tab_list
}

; Function to hide and show hidden files

^+2::GoSub,CheckActiveWindow
CheckActiveWindow:
  ID := WinExist("A")
  WinGetClass,Class, ahk_id %ID%
  WClasses := "CabinetWClass ExploreWClass"
  IfInString, WClasses, %Class%
    GoSub, Toggle_HiddenFiles_Display
Return

Toggle_HiddenFiles_Display:
  RootKey = HKEY_CURRENT_USER
  SubKey = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

  RegRead, HiddenFiles_Status, % RootKey, % SubKey, Hidden

  if HiddenFiles_Status = 2
    RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 1
  else
    RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 2
  PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

; Function for a quick google search
^+c::
  {
    Send, ^c
    Sleep 50
    Run, https://www.google.com/search?q=%clipboard%
    Return
  }


  ; Functions for volume keys

  !\::Send {Volume_Mute}
  ![::Send {Volume_Up}
  !]::Send {Volume_Down}
return

; Functions for maximizing, minimzing application
#f::WinMaximize, A
#m::WinMinimize, A

; Suspend/restart
#If
^!+s::
  Vim.State.ToggleEnabled()
Return
