#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input
SetKeyDelay, 100
CoordMode, ToolTip, Screen

#IFWinActive, ahk_exe HogwartsLegacy.exe

execute := False

IniRead, cmdL, settings.ini, Gestures, L
IniRead, cmdR, settings.ini, Gestures, R
IniRead, cmdU, settings.ini, Gestures, U
IniRead, cmdD, settings.ini, Gestures, D
IniRead, cmdLR, settings.ini, Gestures, LR
IniRead, cmdRL, settings.ini, Gestures, RL
IniRead, cmdUD, settings.ini, Gestures, UD
IniRead, cmdDU, settings.ini, Gestures, DU
IniRead, cmdLRL, settings.ini, Gestures, LRL
IniRead, cmdRLR, settings.ini, Gestures, RLR
IniRead, cmdUDU, settings.ini, Gestures, UDU
IniRead, cmdDUD, settings.ini, Gestures, DUD
IniRead, cmdLRLR, settings.ini, Gestures, LRLR
IniRead, cmdRLRL, settings.ini, Gestures, RLR
IniRead, cmdUDUD, settings.ini, Gestures, UDUD
IniRead, cmdDUDU, settings.ini, Gestures, DUDU

If (cmdL = "ERROR") {
  msgbox, 설정 파일이 존재하지 않습니다!
  Exit
}

; ~Ctrl::
~RButton::
If %execute% {
  Return
}
GetMouseGesture(True)
While GetKeyState(LTrim(A_ThisHotkey,"~")){
  MG := GetMouseGesture()
  ToolTip, % ParseGesture(MG), A_ScreenWidth //2 - 100, A_ScreenHeight //2
  Sleep 50
}
if IsFunc(MG) {
  ToolTip
  %MG%()
  Return
}
GetMouseGesture(True)
ToolTip
Return

GetMouseGesture(reset := false){
	Static
	mousegetpos,xpos2, ypos2
	dx:=xpos2-xpos1,dy:=ypos1-ypos2
	,( abs(dy) >= abs(dx) ? (dy > 0 ? (track:="U") : (track:="D")) : (dx > 0 ? (track:="R") : (track:="L")) )	;track is up or down, left or right
	,abs(dy)<4 and abs(dx)<4 ? (track := "") : ""	;not tracking at all if no significant change in x or y
	,xpos1:=xpos2,ypos1:=ypos2
	,track<>SubStr(gesture, 0, 1) ? (gesture := gesture . track) : ""	;ignore track if not changing since previous track
	,gesture := reset ? "" : gesture
	Return gesture
}

ParseGesture(mg) {
  StringReplace, mg, mg, L, ←, All
  StringReplace, mg, mg, R, →, All
  StringReplace, mg, mg, U, ↑, All
  StringReplace, mg, mg, D, ↓, All
  return mg
}

1::
Send, {F1}
Sleep, 100
Send, {1}
return

2::
Send, {F1}
Sleep, 100
Send, {2}
return

3::
Send, {F1}
Sleep, 100
Send, {3}
return

4::
Send, {F1}
Sleep, 100
Send, {4}
return


L() {
  global
  execute := True
  Send, %cmdL%
  Sleep 200
  execute := False
}
R() {
  global
  execute := True
  Send, %cmdR%
  Sleep 200
  execute := False
}
U() {
  global
  execute := True
  Send, %cmdU%
  Sleep 200
  execute := False
}
D() {
  global
  execute := True
  Send, %cmdD%
  Sleep 200
  execute := False
}
LR() {
  global
  execute := True
  Send, %cmdLR%
  Sleep 200
  execute := False
}
RL() {
  global
  execute := True
  Send, %cmdRL%
  Sleep 200
  execute := False
}
UD() {
  global
  execute := True
  Send, %cmdUD%
  Sleep 200
  execute := False
}
DU() {
  global
  execute := True
  Send, %cmdDU%
  Sleep 200
  execute := False
}
LRL() {
  global
  execute := True
  Send, %cmdLRL%
  Sleep 200
  execute := False
}
RLR() {
  global
  execute := True
  Send, %cmdRLR%
  Sleep 200
  execute := False
}
UDU() {
  global
  execute := True
  Send, %cmdUDU%
  Sleep 200
  execute := False
}
DUD() {
  global
  execute := True
  Send, %cmdDUD%
  Sleep 200
  execute := False
}
LRLR() {
  global
  execute := True
  Send, %cmdLRLR%
  Sleep 200
  execute := False
}
RLRL() {
  global
  execute := True
  Send, %cmdRLRL%
  Sleep 200
  execute := False
}
UDUD() {
  global
  execute := True
  Send, %cmdUDUD%
  Sleep 200
  execute := False
}
DUDU() {
  global
  execute := True
  Send, %cmdDUDU%
  Sleep 200
  execute := False
}