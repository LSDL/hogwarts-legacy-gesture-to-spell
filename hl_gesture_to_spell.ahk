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

HotKey, %Functions_GestureKey%, GestureCatch

GestureCatch:
If (execute)
  Return
GetMouseGesture(True, Functions_AxisLock)
While (GetKeyState(LTrim(A_ThisHotkey, "~"))) {
  MG := GetMouseGesture(False, Functions_AxisLock)
  if (Functions_DebugToolTip) {
    ToolTip, % ParseGesture(MG), A_ScreenWidth //2 - 100, A_ScreenHeight //2
  }
  Sleep 50
}
if (Functions_Overflow) {
  if (&Gestures_%MG% != &NonExistentVar) {
    CastSpell(Gestures_%MG%)
    Return
  }
} else {
  while(MG <> "") {
    ToolTip, %MG%
    if (&Gestures_%MG% != &NonExistentVar) {
      CastSpell(Gestures_%MG%)
      Return
    }
    StringTrimRight, MG, MG, 1
  }
}
GetMouseGesture(True, Functions_AxisLock)
ToolTip
Return

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

GetMouseGesture(reset := false, AxisLock := false) {
  Static
  MouseGetPos, xpos2, ypos2
  dx := xpos2 - xpos1
  dy := ypos1 - ypos2
  
  if (abs(dy) >= abs(dx)) {
    if (dy > 0) { 
      track:="U" 
    } else { 
      track:="D" 
    }
  } else {
    if (dx > 0) { 
      track:="R"
    } else { 
      track:="L" 
    }
  }

  if (abs(dy) < 4 and abs(dx) < 4) {
    track := ""
  }
  
  if (AxisLock) {
    if (track_prev="L" and track!="R") {
      track:=""
    } else if (track_prev="R" and track!="L") {
      track:=""
    } else if (track_prev="U" and track!="D") {
      track:=""
    } else if (track_prev="D" and track!="U") {
      track:=""
    }
  }

  if (track<>"") {
    track_prev := track
  }
  xpos1 := xpos2
  ypos1 := ypos2
  if (track <> SubStr(gesture, 0, 1)) { 
    gesture := gesture . track 
  }

  gesture := reset ? "" : gesture
  track_prev := reset ? "" : track_prev

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
  if (Functions_DebugToolTip) {
    ToolTip, %keys%, A_ScreenWidth //2 - 100, A_ScreenHeight //2
  }
  execute := True
  Send, %keys%
  Sleep 200
  execute := False
  ToolTip
}