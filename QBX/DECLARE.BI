' Module   : DECLARE.BI
' Project  : Example module-based program using Future Library.
' Purpose  : TYPEs, COMMON, CONST, FUNCTIONs, and SUBs.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' Application defined TYPEs.
TYPE ConfigType
  Key AS STRING * 16
  Value AS STRING * 64
END TYPE

TYPE DisplayType
  X AS INTEGER
  Y AS INTEGER
  Bits AS INTEGER
END TYPE

TYPE ItemType
  Keys AS STRING * 6
  Name AS STRING * 20
  Shortcut AS STRING * 1
  State AS STRING * 3
END TYPE

TYPE MenuType
  Count AS INTEGER
  Items AS STRING * 100
  Position AS INTEGER
  Span AS INTEGER
  Title AS STRING * 7
END TYPE

TYPE ObjectType
  Button AS STRING * 7
  Frame AS STRING * 6
  Id AS INTEGER
  Size AS STRING * 19  
  Kind AS STRING * 7
  Scroll AS STRING * 5
  Title AS STRING * 24
END TYPE

TYPE RangeType
  Label AS INTEGER
  Value AS INTEGER
END TYPE

TYPE StatusType
  Quit AS INTEGER
  Saved AS INTEGER
END TYPE

' Global type variables.
COMMON SHARED Config AS ConfigType
COMMON SHARED Display AS DisplayType
COMMON SHARED Status AS StatusType

' Defined color constants.
CONST Transparent& = -1
CONST Black& = 0
CONST Blue& = 1
CONST Green& = 2
CONST DarkTurquoise& = 3
CONST Red& = 4
CONST DarkPink& = 5
CONST Brown& = 6
CONST LightGrey& = 7
CONST DarkGrey& = 8
CONST LightBlue& = 9
CONST BrightGreen& = 10
CONST LightTurquoise& = 11
CONST Salmon& = 12
CONST Pink& = 13
CONST Yellow& = 14
CONST White& = 15

' Defined boolean constants.  
CONST True = -1, False = NOT True

' Application functions.
DECLARE FUNCTION DebugSystem$ (Query$)
DECLARE FUNCTION FileExists% (Filename$)
DECLARE FUNCTION MenuItem$ (Elements$, Part$)
DECLARE FUNCTION ScreenPart$ (Mode$, Part$)

' Application sub-routines.
DECLARE SUB ActionManager (Cause$, Id%, Object$)
DECLARE SUB ConfigManager (Mode$, Setting$)
DECLARE SUB ConfigOpen (Setting$)
DECLARE SUB ConfigSave (Setting$)
DECLARE SUB DebugHeader ()
DECLARE SUB DebugOutput (Module$, Message$)
DECLARE SUB FileManager (Option$)
DECLARE SUB FileOpen ()
DECLARE SUB FileSave ()
DECLARE SUB KeyManager ()
DECLARE SUB MenuAttributes ()
DECLARE SUB MenuBanner ()
DECLARE SUB MenuClicks (X%, Y%, Mode$)
DECLARE SUB MenuLabels (X%, Y%, Mode$)
DECLARE SUB MenuManager (Index%)
DECLARE SUB MenuOptions (X%, Y%, Z$)
DECLARE SUB MouseCursor (Shape$)
DECLARE SUB MouseManager (Mode$)
DECLARE SUB MouseMode (Menu%, Mode$)
DECLARE SUB MousePreview ()
DECLARE SUB ObjectButton (Object AS ObjectType)
DECLARE SUB ObjectFrame (Object AS ObjectType)
DECLARE SUB ObjectInput (Object AS ObjectType)
DECLARE SUB ObjectScroll (Object AS ObjectType)
DECLARE SUB ObjectTextBox (Object AS ObjectType)
DECLARE SUB ObjectWindow (Object AS ObjectType)
DECLARE SUB ScreenInit ()
DECLARE SUB ScreenManager (State$)
DECLARE SUB ScreenMode (X%, Y%, B%)
DECLARE SUB ViewManager (View$)
