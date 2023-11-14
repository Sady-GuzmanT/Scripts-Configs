#Persistent
SetCapsLockState, AlwaysOff


; Author: Jarvis Prestidge.
; Description: Script original de Jarvis Prestidge. Tiene varias modificaciones hechas por mi.


; <COMPILER: v1.1.22.00>


; =========================
; Pok3r Layout Marcos - MODIFICADO
; =========================


 
; Capslock + 'J, K, L, I' or 'W, A S, D' equals "left, down, up, right" <><><><><><><><><><><><><><><><><><>

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


; Capslock + 'U, O, H, I' or ';' equivalent to 'PGup, PGdown, HOME, END' <><><><><><><><><><><><><><><><><><>
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




; MultimediaMedia Hotkeys <><><><><><><><><><><><><><><><><><>

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



; Capslock + number keys equal 'function keys (F1-F12)' <><><><><><><><><><><><><><><><><><>

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




; Comandos personalizados varios <><><><><><><><><><><><><><><><><><>

; Make CapsLock & y Abre calculadora
CapsLock & y::Run calc.exe


; Make CapsLock & v hace SELECT ALL line for SQL language
CapsLock & v::SendInput SELECT * FROM{Space}

; Make CapsLock & c build a comment block line for C, Java, SQL language
;CapsLock & c::SendInput /*{Enter}{Enter}*/{Up}{Space}

; Make CapsLock & c build a comment block line for PYTHON
CapsLock & c::SendInput '''

; Make CapsLock & b build a Break line for MarkDown language
;CapsLock & b::SendInput <br>




; Comentados porque no se usan <><><><><><><><><><><><><><><><><><>
	
; Make Capslock & n equivalent to WinKey+m (show Desktop)
;Capslock & n::SendInput {LWin Down}{m}{LWin UP}


; Make Capslock & Enter equivalent to Control+Enter
;Capslock & Enter::SendInput {Ctrl down}{Enter}{Ctrl up}


; Make Capslock & Space equivalent to Control+Space
;Capslock & Space::SendInput {Ctrl down}{Space}{Ctrl up}





; No funciona - Arreglar. <><><><><><><><><><><><><><><><><><>

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