#Persistent
SetCapsLockState, AlwaysOff

#include VA.ahk
#include AppVolume.ahk

Capslock & z::SelectVolumeApp() ; select master volume
Capslock & x::SelectVolumeApp("Spotify.exe")
Capslock & c::SelectVolumeApp("Discord.exe")
Capslock & v::SelectVolumeApp("chrome.exe")
Capslock & b::SelectVolumeApp("stardewvalley.exe")


; toggle mute
Capslock & /::
ToggleAppVolumeMute() {
    global AV
    static lastApp
    if !AV {
        lastApp := AppVolume.App
        AV := AppVolume(AppVolume.App)
    } else if AV && (lastApp != AppVolume.App) {
        lastApp := AppVolume.App
        AV := AppVolume(AppVolume.App)
    }
    if (AppVolume.App) {                         ; if AppVolume.App is not empty
        ProcessName := AppVolume.App             ; set processName to AppVolume.App
        if AV.ToggleMute() ; toggle volume mute, ToggleMute() returns 1 if muted
            level := "mute"
        else
            level := Round(AV.GetVolume())
    } else {
        ProcessName := "Master Volume"
        VA_SetMasterMute(!VA_GetMasterMute()) ; toggle master volume mute
        if VA_GetMasterMute()
            level := "mute"
        else
            level := Round(VA_GetMasterVolume())
    }
    VolumeAppGui(ProcessName, level)
}
Return

; increase or decrease volume
Capslock & .::
Capslock & ,::
AdjustVolumeApp() {
    global AV
    static lastApp
    if InStr(A_ThisHotkey, "Capslock & .")       ; if A_ThisHotkey is NumpadAdd
        amount := 2
    else if InStr(A_ThisHotkey, "Capslock & ,")  ; if A_ThisHotkey is NumpadSub
        amount := -2

    if !AV {
        lastApp := AppVolume.App
        AV := AppVolume(AppVolume.App)
    } else if AV && (lastApp != AppVolume.App) {
        lastApp := AppVolume.App
        AV := AppVolume(AppVolume.App)
    }

    if (AppVolume.App) {                                  ; if AppVolume.App is not blank, adjust app volume,
        ProcessName := AppVolume.App
        level := AV.AdjustVolume(amount)
        AV.GetMute() && AV.SetMute(0)                     ; unmute if muted
    } else {
        VA_SetMasterVolume(VA_GetMasterVolume() + amount) ; else adjust master volume
        ProcessName := "Master Volume"
        level := VA_GetMasterVolume()
        VA_GetMasterMute() && VA_SetMasterMute(0)         ; unmute if muted
    }
    VolumeAppGui(ProcessName, Round(level > 100 ? 100 : level < 0 ? 0 : level)) ; limit to 0 - 100
}
Return

SelectVolumeApp(ProcessName:="") {
    if !ProcessName {
        AppVolume.App := ""
        ProcessName := "Master Volume"
        level := VA_GetMasterVolume()
    } else {
        AppVolume.App := ProcessName
        level := AppVolume(ProcessName).GetVolume()
    }
    VolumeAppGui(ProcessName, Round(level))
}

VolumeAppGui(ProcessName, volumeLevel) {
    global AV
    static initGui := 0, Icon, Meter, Text, Level, Mute, lastApp
    Gui, AppVolumeGui:Default
    if !initGui {
        Gui, -Caption +ToolWindow +AlwaysOnTop +Border -DPIScale +E0x20 +E0x2080000 +LastFound
        WinSet, Transparent, 255
        Gui, Color, 0x1a1a1a
        Gui, Margin, 15, 15
        Gui, Add, Picture, vMute w48 h-1 BackgroundTrans Icon132, C:\WINDOWS\System32\Shell32.dll ; X icon
        Gui, Add, Picture, vIcon w48 h-1 xp yp ; process icon
        Gui, Font, s16, SegoeUI SemiBold
        Gui, Add, Text, x+15 vText cWhite w200 ; name of process
        Gui, Add, Progress, w200 h9 c0084de background3b3b3b vMeter ; volume meter
        Gui, Font, s12, SegoeUI
        Gui, Add, Text, w30 x+10 yp-6 vLevel cWhite       ; current volume
        Gui, Show, Hide
        SysGet, P, MonitorPrimary                         ; get primary monitor number
        SysGet, Mon, MonitorWorkArea, % P                 ; get size of primary monitor
        WinGetPos, X, Y, W, H                             ; get pos of gui
        WinMove, % MonRight - W - 10, % MonTop + 10       ; move gui to bottom right
        initGui := 1
    }
    Gui, Show, NA
    if (ProcessName = "Master Volume")
        ProcessPath := "C:\WINDOWS\System32\mmres.dll" ; speaker icon
    else
        WinGet, ProcessPath, ProcessPath, % "ahk_exe " ProcessName ; get path of exe

    if (lastApp != ProcessName) {
        if (WinExist("ahk_exe" ProcessName) || ProcessName = "Master Volume")
            GuiControl,,Icon, % ProcessPath ; set icon if process exist or master volume
        else
            GuiControl,,Icon, *Icon1 C:\WINDOWS\System32\imageres.dll ; blank icon if process doesn't exist
        GuiControl,,Text, % ProcessName
    }
    lastApp := ProcessName
    GuiControl,, Meter, % volumeLevel ; volume bar
    GuiControl, % (volumeLevel = "mute") ? "Show" : "Hide", Mute ; show X icon if mute
    (volumeLevel = "mute") && volumeLevel := 0
    GuiControl,, Level, % volumeLevel ; current volume
    SetTimer, GuiHide, -2000 ; hide gui in 2 seconds
    Return

    GuiHide:
        Gui, AppVolumeGui:Hide
        AV := ""
    Return
}




#InstallKeybdHook

; Author: Jarvis Prestidge
; Description: Simulates my preferred keyboard layout, similiar to that of the Pok3r 60% keyboard
; on any keyboard without programmable keys. i.e. my laptop ^^
;Con modificaciones

; <COMPILER: v1.1.22.00>


; =========================
; Pok3r Layout Marcos
; =========================




 
; Capslock + 'J, K, L, I' or 'W, A S, D' equals "left, down, up, right"

Capslock & j::Send {Blind}{Left DownTemp}
Capslock & j up::Send {Blind}{Left Up}

Capslock & k::Send {Blind}{Down DownTemp}
Capslock & k up::Send {Blind}{Down Up}

Capslock & i::Send {Blind}{Up DownTemp}
Capslock & i up::Send {Blind}{Up Up}

Capslock & l::Send {Blind}{Right DownTemp}
Capslock & l up::Send {Blind}{Right Up}


Capslock & a::Send {Blind}{Left DownTemp}
Capslock & a up::Send {Blind}{Left Up}

Capslock & s::Send {Blind}{Down DownTemp}
Capslock & s up::Send {Blind}{Down Up}

Capslock & w::Send {Blind}{Up DownTemp}
Capslock & w up::Send {Blind}{Up Up}

Capslock & d::Send {Blind}{Right DownTemp}
Capslock & d up::Send {Blind}{Right Up}


; Capslock + 'U, O, H, I' or ';' equivalent to 'PGup, PGdown, HOME, END'
; Make Capslock & semicolon (;) equivalent to 'end' , Alternative to 'N'

Capslock & h::SendInput {Blind}{PgUp Down}
Capslock & h up::SendInput {Blind}{PgUp Up}

Capslock & n::SendInput {Blind}{PgDn Down}
Capslock & n up::SendInput {Blind}{PgDn Up}

Capslock & u::SendInput {Blind}{Home Down}
Capslock & u up::SendInput {Blind}{Home Up}

Capslock & o::SendInput {Blind}{End Down}
Capslock & o up::SendInput {Blind}{End Up}

;Capslock & ;::SendInput {End Down}
;Capslock & ; up::SendInput {End Up}


; Make Capslock & Backspace equivalent to 'delete'
Capslock & BS::SendInput {Del Down}
Capslock & BS up::SendInput {Del Up}

; Make Capslock & p equivalent to 'PrintScreen'
Capslock & p::SendInput {PrintScreen}

; Make CapsLock & Right Shift the 'application menu key'
CapsLock & RShift::SendInput {AppsKey}




; MultimediaMedia Hotkeys

; Make CapsLock & q the 'previous media key'
CapsLock & q::SendInput {Media_Prev}

; Make CapsLock & e the 'next media key'
CapsLock & e::SendInput {Media_Next}

; Make CapsLock & t the 'pause media key'
CapsLock & t::SendInput {Media_Play_Pause}

; Make CapsLock & f the 'VolumeDown media key'
CapsLock & f::SendInput {Volume_Down}

; Make CapsLock & r the 'VolumeUp media key'
CapsLock & r::SendInput {Volume_Up}

; Make CapsLock & m the 'mute media key'
CapsLock & m::SendInput {Volume_Mute}



; Capslock + number keys equal 'function keys (F1-F12)'

Capslock & 1::SendInput {Blind}{F1}
Capslock & 2::SendInput {Blind}{F2}
Capslock & 3::SendInput {Blind}{F3}
Capslock & 4::SendInput {Blind}{F4}
Capslock & 5::SendInput {Blind}{F5}
Capslock & 6::SendInput {Blind}{F6}
Capslock & 7::SendInput {Blind}{F7}
Capslock & 8::SendInput {Blind}{F8}
Capslock & 9::SendInput {Blind}{F9}
Capslock & 0::SendInput {Blind}{F10}
Capslock & -::SendInput {Blind}{F11}
Capslock & =::SendInput {Blind}{F12}




; Comandos personalizados varios lalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalala

; Make CapsLock & y open the 'Windows Calculator'
CapsLock & y::Run calc.exe






; Comentados porque no los quiero lalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalala
	
; Make Capslock & n equivalent to WinKey+m (show Desktop)
;Capslock & n::SendInput {LWin Down}{m}{LWin UP}


; Make Capslock & Enter equivalent to Control+Enter
;Capslock & Enter::SendInput {Ctrl down}{Enter}{Ctrl up}


; Make Capslock & Space equivalent to Control+Space
;Capslock & Space::SendInput {Ctrl down}{Space}{Ctrl up}



; No funciona

; Make Win Key + Capslock work like Capslock
;#Capslock:
;If GetKeyState("CapsLock", "T") = 1
;    SetCapsLockState, AlwaysOff
;Else 
;    SetCapsLockState, AlwaysOn
;Return

;SetCapsLockState(AlwaysOff)
;Capslock & g::
 ; 	SetCapsLockState(on)