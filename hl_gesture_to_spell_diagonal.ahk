#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input
SetKeyDelay, 100
CoordMode, ToolTip, Screen

#IFWinActive, ahk_exe HogwartsLegacy.exe

execute := False

LoadSettings(_SourcePath = "settings_diagonal.ini", _ValueDelim = "=", _VarPrefixDelim = "_")
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
HotKey, %DirectCastPage1Keys_Spell1%, Spell1KeyHandler
HotKey, %DirectCastPage1Keys_Spell2%, Spell2KeyHandler
HotKey, %DirectCastPage1Keys_Spell3%, Spell3KeyHandler
HotKey, %DirectCastPage1Keys_Spell4%, Spell4KeyHandler

GestureCatch:
If (execute)
  Return
GetMouseGesture(True)
While (GetKeyState(LTrim(A_ThisHotkey, "~"))) {
  MG := GetMouseGesture()
  if (Functions_DebugToolTip) {
    ToolTip, % ParseGesture(MG), A_ScreenWidth //2 - 100, A_ScreenHeight //2
  }
  Sleep 100
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
GetMouseGesture(True)
ToolTip
Return

Spell1KeyHandler:
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {%DirectCastPage1Keys_Spell1%}
} else {
  Send, {%DirectCastPage1Keys_Spell1%}
}
Return

Spell2KeyHandler:
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {%DirectCastPage1Keys_Spell2%}
} else {
  Send, {%DirectCastPage1Keys_Spell2%}
}
Return

Spell3KeyHandler:
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {%DirectCastPage1Keys_Spell3%}
} else {
  Send, {%DirectCastPage1Keys_Spell3%}
}
Return

Spell4KeyHandler:
if (Functions_DirectCastPage1) {
  Send, {F1}
  Sleep, 100
  Send, {%DirectCastPage1Keys_Spell4%}
} else {
  Send, {%DirectCastPage1Keys_Spell4%}
}
Return

GetMouseGesture(reset := false) {
  Static
  MouseGetPos, xpos2, ypos2
  dx := xpos2 - xpos1
  dy := ypos1 - ypos2

  angle := atan(abs(dy)/abs(dx))*57.29578

  if (abs(dy) < 20 and abs(dx) < 20) {
    track := ""
  } else {
    if (angle > 45+22.5) {
      if (dy > 0) {
        track := "8" ; ↑
      } else {
        track := "2" ; ↓
      }
    } else if (angle > 45-22.5) {
      if (dy > 0 and dx > 0) {
        track := "9" ; ↗
      } else if (dy > 0 and dx < 0) {
        track := "7" ; ↖
      } else if (dy < 0 and dx > 0) {
        track := "3" ; ↘
      } else if (dy < 0 and dx < 0) {
        track := "1" ; ↙
      }
    } else if (angle = 0.0) {
      if (abs(dy) > abs(dx)) {
        if (dy > 0) {
          track := "8" ; ↑
        } else {
          track := "2" ; ↓
        }
      } else {
        if (dx > 0) {
          track := "6" ; →
        } else {
          track := "4" ; ←
        }
      }
    } else {
      if (dx > 0) {
        track := "6" ; →
      } else {
        track := "4" ; ←
      }
    }
  }

  p := ParseGesture(track)
  
  xpos1 := xpos2
  ypos1 := ypos2
  if (track <> SubStr(gesture, 0, 1)) { 
    gesture := gesture . track 
  }

  gesture := reset ? "" : gesture

  Return gesture
}

ParseGesture(mg) {
  StringReplace, mg, mg, 1, ↙, All
  StringReplace, mg, mg, 2, ↓, All
  StringReplace, mg, mg, 3, ↘, All
  StringReplace, mg, mg, 4, ←, All
  StringReplace, mg, mg, 6, →, All
  StringReplace, mg, mg, 7, ↖, All
  StringReplace, mg, mg, 8, ↑, All
  StringReplace, mg, mg, 9, ↗, All
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