#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input
SetKeyDelay, 100
CoordMode, ToolTip, Screen

#IFWinActive, ahk_exe HogwartsLegacy.exe

execute := False

LoadSettings(_SourcePath = "settings.ini", _ValueDelim = "=", _VarPrefixDelim = "_")
{
  Global
  if !FileExist(_SourcePath){
    MsgBox, 16, % "Error", % "The file " . _SourcePath . " does not esxist"
  } else {    
    Local FileContent, CurrentPrefix, CurrentVarName, CurrentVarContent, DelimPos
    FileRead, FileContent, %_SourcePath%
    If ErrorLevel = 0
    {
      Loop, Parse, FileContent, `n, `r%A_Tab%%A_Space%
      {
        If A_LoopField Is Not Space
        {
          If (SubStr(A_LoopField, 1, 1) = "[")
          {
            RegExMatch(A_LoopField, "\[(.*)\]", ini_Section)
            CurrentPrefix := ini_Section1
          }
          Else
          {
            DelimPos := InStr(A_LoopField, _ValueDelim)
            CurrentVarName := SubStr(A_LoopField, 1, DelimPos - 1)
            CurrentVarContent := SubStr(A_LoopField, DelimPos + 1)
            %CurrentPrefix%%_VarPrefixDelim%%CurrentVarName% = %CurrentVarContent%
          }
          
        }
      }
    }
  }
}
LoadSettings()

; ~Ctrl::
~RButton::
If (execute)
  Return
GetMouseGesture(True)
While (GetKeyState(LTrim(A_ThisHotkey, "~"))) {
  MG := GetMouseGesture()
  ToolTip, % ParseGesture(MG), A_ScreenWidth //2 - 100, A_ScreenHeight //2
  Sleep 50
}
if (&Gestures_%MG% != &NonExistentVar) {
  CastSpell(Gestures_%MG%)
  Return
}
GetMouseGesture(True)
ToolTip
Return

GetMouseGesture(reset := false) {
	Static
	mousegetpos,xpos2, ypos2
	dx:=xpos2-xpos1,dy:=ypos1-ypos2
	,( abs(dy) >= abs(dx) ? (dy > 0 ? (track:="U") : (track:="D")) : (dx > 0 ? (track:="R") : (track:="L")) )
	,abs(dy)<4 and abs(dx)<4 ? (track := "") : ""
	,xpos1:=xpos2,ypos1:=ypos2
	,track<>SubStr(gesture, 0, 1) ? (gesture := gesture . track) : ""
	,gesture := reset ? "" : gesture
	Return gesture
}

ParseGesture(mg) {
  StringReplace, mg, mg, L, ←, All
  StringReplace, mg, mg, R, →, All
  StringReplace, mg, mg, U, ↑, All
  StringReplace, mg, mg, D, ↓, All
  Return mg
}

CastSpell(keys) {
  global
  ToolTip, %keys%
  execute := True
  Send, %keys%
  Sleep 200
  execute := False
  ToolTip
}

1::
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {1}
} else {
  Send, {1}
}
Return

2::
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {2}
} else {
  Send, {2}
}
Return

3::
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {3}
} else {
  Send, {3}
}
Return

4::
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {4}
} else {
  Send, {4}
}
Return
