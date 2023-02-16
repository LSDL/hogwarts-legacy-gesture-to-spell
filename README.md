# Gesture to spell - Hogwarts Legacy
A AHK script project that allows you to cast magic with mouse gestures in Hogwarts Legacy game.

Default controls for magic cast is so painful. So, I made this.\
At first, It is difficult to aim or it may not be cast well as desired.\
But, you knows, wielding magic wand is difficult. That's the way it is.\
However, once you get used to it, this method is much more comfortable.\
I have played game with mouse gesture more than 20 hours and still playing with.\
I'm bet you're gonna love this.


## Demonstration
[Youtube Video - Demo](https://youtu.be/xgpiAxEwMPA)\
[Youtube Video - Gameplay](https://youtu.be/OIM831k9JUY)


## Installation
Download the [latest release](https://github.com/LSDL/hogwarts-legacy-gesture-to-spell/releases)\
launch game first, then launch exe and play.\
Right click system tray icon then press 'Close' to terminate.


## Usage
This is a description that assumes default settings.ini.\
You can customize the settings.ini yourself.

Cast Spell : Keep press mouse right button and gesture, then release to cast.

1234 Key : Cast Page 1 - Slot 1234 spells directly.

Page 2 Slot 1 : ←\
Page 2 Slot 2 : ↑\
Page 2 Slot 3 : ↓\
Page 2 Slot 4 : →

Page 3 Slot 1 : ←→\
Page 3 Slot 2 : ↑↓\
Page 3 Slot 3 : ↓↑\
Page 3 Slot 4 : →←

Page 4 Slot 1 : ←→←\
Page 4 Slot 2 : ↑↓↑\
Page 4 Slot 3 : ↓↑↓\
Page 4 Slot 4 : →←→


## Settings
You can edit settings.ini for your own gestures.

```
[Functions]
GestureKey=~RButton
DirectCastPage1=1
DebugToolTip=0
Overflow=0
AxisLock=1
```

- GestureKey\
This is the key to activate gesture. Default is "\~RButton" = Mouse Right Click.\
"\~" means "This keys native function will not be blocked."\
For more information, visit AHK V1 Doc.\
[HotKeys](https://www.autohotkey.com/docs/v1/Hotkeys.htm)\
[List of Keys](https://www.autohotkey.com/docs/v1/KeyList.htm)


- DirectCastPage1\
If enabled, pressing 1234 keys directly cast Page 1 - Slot 1234 spells.\
If disabled, you can cast currently selected pages spells with 1234 keys (like normally)\
*0: Off / 1: On (Default: 1)*

- DebugToolTip\
If enabled, whenever you gesture, tooltip shows what gesture and keys activated.\
*0: Off / 1: On (Default: 0)*

- Overflow\
Gesture overflow filtering function.\
If enabled,\
LU -> Command not exists -> Do nothing.\
If disabled,\
LU -> LU command not exists, but L command Exists -> Do L command.\
*0: Off / 1: On (Default: 0)*

- AxisLock\
Fix the gesture input axis to first gesture.\
If enabled, from the second gesture, only the input of the same axis as the first gesture is accepted.\
For exmaple,\
L -> next gesture must be R\
LR -> next gesture must be L\
*0: Off / 1: On (Default: 1)*

```
[DirectCastPage1Keys]
Spell1=1
Spell2=2
Spell3=3
Spell4=4
```

KeyBindings for DirectCastPage1.\
When you press the 'Spell1' key, the page 1 slot  1 magic is cast.\
*(Default: 1 2 3 4)*

```
[Gestures] 
L={F2}1
U={F2}2
D={F2}3
R={F2}4
LR={F3}1
UD={F3}2
DU={F3}3
RL={F3}4
LRL={F4}1
UDU={F4}2
DUD={F4}3
RLR={F4}4
```
Gesttures are customizable.\
L, R, U, D Combination = \{<F1\~F4>\}<1~4>\
ex) LRU={F4}2\
ex) LRLRU={F4}4

## Diagonal Version
This version supports 8 direction gesture.\
\
**Difference**
- 'AxisLock' not supported.
- Gesture config keyword is different. not LRUD, it works like\
7 8 9 | ↖ ↑ ↗\
4 X 6 | ← X →\
1 2 3 | ↙ ↓ ↘\
Check out the settings_diagonal.ini as reference.
