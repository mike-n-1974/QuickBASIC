' Module: MENU.BAS
' Project: Example module-based program using Future Library.
' Purpose: Menu handling functions and sub-routines.
' Modified: 2022-10-22 -- Added 'Edit' menu items in DATA statements.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

' Dimension an array for five menus.
DIM SHARED Menu(1 TO 5) AS MenuType

' Variables for menu drawing and item IDs.
DIM SHARED Banner%, ItemID%, Shadow%, Solid%, Spacing%


' NOTE: The menu DATA listed below follows this strict formatting:
' ----------------------------------------------------------------
' DATA Position, "Title", Span, Count, "Items..." -> (Name/Keys/State)
'      (A)        (B)     (C)   (D)     (E)          (F)  (G)   (H)
'
' A. Position (in pixels) is from the left and divisble by eight.
'    The distance is up to the first letter of the menu Title.
' B. Title is the capitalized pulldown menu title (keep them short).
' C. Span (in characters) is the widest displayed menu item + 2.
'    Includes the item Name, Keys, and the empty space inbetween.
'    Does NOT include the caret (^) character within the Name.
' D. Count (in items) is the number of Items including dividers (-).
'    Used to calculate how long the menu pulldown will be (in pixels).
' E. Items are a comma separated string of the pulldown menu options.
'    The caret (^) within an item denotes the Shortcut key character.
'    The divider (-) item indicates where a menu dividing line goes.
'    The slash (/) within an item separates the three attributes.
' F. The item attributes are in three parts separated by a slash (/).
'    1. Name  = the menu item, including the Shortcut key caret (^).
'    2. Keys  = the Alt or Ctrl key sequence (usable outside of menus).
'    3. State = the default enabled or disabled state of the menu item.
' G. If an item doesn't have a key sequence, leave as two slashes (//).
' H. The State of a menu item is either On (enabled) or Off (disabled).

DATA 24,"File",17,7,"^New/Ctrl+N/On,^Open.../Ctrl+O/On,-,^Save/Ctrl+S/Off,Save ^As...//Off,-,E^xit/Alt+X/On"
DATA 72,"Edit",15,8,"^Undo/Ctrl+Z/Off,^Redo/Ctrl+Y/Off,-,^Copy/Ctrl+C/On,^Paste/Ctrl+V/Off,-,C^lear//On,^Delete/Del/On"
DATA 120,"Views",11,4,"Item ^1//On,Item ^2...//Off,-,Item ^3...//Off"
DATA 176,"Options",18,4,"^Mouse.../Ctrl+M/On,-,Item ^4...//Off,Item ^5...//Off"
DATA 248,"Help",11,4,"DEBUG.^LOG//On,-,Item ^6...//Off,Item ^7...//Off"


' NOTE: Working out menu layouts (including key sequences):
' ---------------------------------------------------------
' | File |            | Edit |           ...  | Options |          | Help |
' +-----------------+ +---------------+       +------------------+ +-----------+
' | New      Ctrl+N | | Undo   Ctrl+Z |       | Mouse...  Ctrl+M | | DEBUG.LOG |
' | Open     Ctrl+O | | Redo   Ctrl+Y |       |------------------| |-----------|
' |-----------------| |---------------|       | Item 4...        | | Item 6... |
' | Save     Ctrl+S | | Copy   Ctrl+C |       | Item 5...        | | Item 7... |
' | Save As...      | | Paste  Ctrl+V |       +------------------+ +-----------+
' |-----------------| |---------------|
' | Exit      Alt+X | | Clear         |
' +-----------------+ | Delete    Del |
'                     +---------------+

SUB MenuAttributes

' NOTE: MenuAttributes defines commonly used menu attributes,
' ----- reads the DATA into an array, and calls MenuBanner.

' Define menu attributes.
Banner% = 16 '(pixels)
Shadow% = Banner% + 1
Solid% = -1 '(bitscan)
Spacing% = Banner% \ 2

' Read menu info from DATA statements and calculate size.
Size% = 0
FOR n% = 1 TO UBOUND(Menu)
  READ Menu(n%).Position
  Size% = Size% + LEN(Menu(n%).Position)
  
  READ Menu(n%).Title
  Size% = Size% + LEN(RTRIM$(Menu(n%).Title))
  
  READ Menu(n%).Span
  Size% = Size% + LEN(Menu(n%).Span)
  
  READ Menu(n%).Count
  Size% = Size% + LEN(Menu(n%).Count)
  
  READ Menu(n%).Items
  Size% = Size% + LEN(RTRIM$(Menu(n%).Items))
NEXT n%

' Output array size to the debug log.
Message$ = "MenuAttributes: Menu array uses" + STR$(Size%) + " bytes."
CALL DebugOutput("MENU", Message$)

' Draw the banner with titles.
CALL MenuBanner

END SUB

SUB MenuBanner

' NOTE: MenuBanner draws the top menu bar with a Shadow
' ----- and prints each menu Title from the Menu array.

' Draw the top banner with underline.
Future.FILLBOX 0, 0, Display.X - 1, Banner%, LightGrey
Future.LINE 0, Shadow%, Display.X - 1, Shadow%, DarkGrey, Solid%

' Print trimmed menu titles from array.
FOR n% = 1 TO UBOUND(Menu)
  Future.PRINT Menu(n%).Position, 1, RTRIM$(Menu(n%).Title), Black, Transparent
NEXT n%

END SUB

SUB MenuClicks (X%, Y%, Mode$)

' NOTE: MenuClicks checks for mouse clicks in the pulldown,
' ----- within X% and Y% ranges for individual menu items.

' TODO: Check for clicks of enabled menu items...
' ----- Close the pulldown if clicked outside of it!

END SUB

FUNCTION MenuItem$ (Elements$, Part$)

' NOTE: The MenuItem$ function returns the requested parts
' ----- from a slash (/) separated string of item elements.

' Dimension array used for item parts.
REDIM Parts$(1 TO 3)

' Define the starting count number.
n% = 1

' Define default position values.
NewPos% = 0
OldPos% = 1

' Loop to extract all the parts.
DO
  NewPos% = INSTR(NewPos% + 1, Elements$, "/")
  Length% = NewPos% - OldPos%

  IF NewPos% > 0 THEN
    Parts$(n%) = MID$(Elements$, OldPos%, Length%)
  ELSE
    Parts$(n%) = MID$(Elements$, OldPos%)
  END IF

  n% = n% + 1
  OldPos% = NewPos% + 1
  
LOOP UNTIL NewPos% = 0

' Return the requested part.
SELECT CASE Part$

  ' Return the name.
  CASE "Name"
    MenuItem$ = Parts$(1)

  ' Return the keys.
  CASE "Keys"
    MenuItem$ = Parts$(2)

  ' Return the state.
  CASE "State"
    MenuItem$ = Parts$(3)

END SELECT

' Deallocate space used by Parts$ array.
ERASE Parts$

END FUNCTION

SUB MenuLabels (X%, Y%, Mode$)

' NOTE: MenuLabels checks for mouse clicks in the menu labels,
' ----- within ranges calculated from the titles in an array.

' Define default label.
Label% = 1

' Define offset from left.
Offset% = 16

' Dimension array used for ranges.
REDIM Ranges(1 TO UBOUND(Menu)) AS RangeType

' Get ranges of menu title labels.
FOR n% = 1 TO UBOUND(Menu)
  Distance% = (LEN(RTRIM$(Menu(n%).Title)) + 2) * Spacing%
  IF n% = 1 THEN
    Ranges(n%).Label = 1
    Ranges(n%).Value = Offset% + Distance%
  ELSE
    Ranges(n%).Label = n%
    Ranges(n%).Value = Ranges(n% - 1).Value + Distance%
  END IF
NEXT n%

' Check for X% within label ranges.
FOR i% = 2 TO UBOUND(Ranges)
	
  SELECT CASE X%

    ' Less than the left offset.
    CASE IS < Offset%
      EXIT SUB

    ' First label on the left.
    CASE Offset% TO Ranges(1).Value
      Label% = Ranges(1).Label
	  
    ' Check within other ranges.
    CASE Ranges(i% - 1).Value TO Ranges(i%).Value
      Label% = Ranges(i%).Label

    ' Greater than the last range.
    CASE IS > Ranges(UBOUND(Menu)).Value
      EXIT SUB

END SELECT

NEXT i%

' Deallocate space used by array.
ERASE Ranges

' Check for clicks in height of the menu bar.
IF Y% > 0 AND Y% <= Banner% THEN

  ' Debug of values X%, Y%, Label, & Mode.
  Message$ = "MenuLabels.: X%=" + LTRIM$(STR$(X%)) + ", Y%=" + LTRIM$(STR$(Y%)) + ", Label=" + LTRIM$(STR$(Label%)) + ", & Mode=" + LTRIM$(Mode$)
  CALL DebugOutput("MENU", Message$)
  
  ' Redraw the banner with titles.
  CALL MenuBanner

  ' Display menu if within a label.
  CALL MouseMode(Label%, Mode$)

END IF

END SUB

SUB MenuManager (Index%)

' NOTE: The MenuManager is called from the KeyManager and MouseMode
' ----- sub-routines to manage the display of the selected menu.

' Menu position variables.
X% = Index%
Y% = 1
Z$ = "Down"

' Turn the mouse off.
CALL Future.MouseOff

' Save current screen.
CALL ScreenManager("Allocate")

' Draw the menu pulldown.
CALL MenuOptions(X%, Y%, Z$)

' Turn the mouse on again.
CALL Future.MouseOn

' Debug in the MenuManager.
CALL DebugOutput("MENU", "In MenuManager before the input loop.")


' DO..LOOP to capture menu input.
DO
  ' Capture the keys pressed.
  KeyPress$ = INKEY$
  
  ' Capture the mouse too.
  CALL MouseManager("Menu")

  SELECT CASE KeyPress$
	  
    ' TODO: Add CASE for menu item shortcut key press?

    ' Action triggered on Enter key pressed.
    CASE CHR$(13)
       CALL ScreenManager("Retrieve")
       CALL ScreenManager("Deallocate")
       CALL ActionManager("Enter", ItemID%, "Menu")
       EXIT DO

    ' Exit menu loop on Escape pressed.
    CASE CHR$(27)
       CALL DebugOutput("MENU", "MenuManager: Escape key pressed, so exited menu.")
       CALL ScreenManager("Retrieve")
       CALL ScreenManager("Deallocate")
       EXIT DO

    ' Move menu pulldown on Left key pressed.
    CASE CHR$(0) + CHR$(75)
      X% = X% - 1
      IF X% < 1 THEN X% = UBOUND(Menu)
      CALL ScreenManager("Retrieve")
      CALL MenuOptions(X%, 1, Z$)

    ' Move menu pulldown on Right key pressed.
    CASE CHR$(0) + CHR$(77)
      X% = X% + 1
      IF X% > UBOUND(Menu) THEN X% = 1
      CALL ScreenManager("Retrieve")
      CALL MenuOptions(X%, 1, Z$)

    ' Move item highlight on Up key pressed.
    CASE CHR$(0) + CHR$(72)
      Y% = Y% - 1
      IF Y% < 1 THEN Y% = Menu(X%).Count
      CALL MenuOptions(X%, Y%, "Up")

    ' Move item highlight on Down key pressed.
    CASE CHR$(0) + CHR$(80)
      Y% = Y% + 1
      IF Y% > Menu(X%).Count THEN Y% = 1
      CALL MenuOptions(X%, Y%, "Down")

  END SELECT

LOOP


' Debug in the MenuManager.
CALL DebugOutput("MENU", "In MenuManager after the input loop.")

END SUB

SUB MenuOptions (X%, Y%, Z$)

' NOTE: MenuOptions is where most of the menu magic happens, by
' ----- drawing the pulldown from the formatted DATA statements.

' Calculate and trim values required.
Title$ = RTRIM$(Menu(X%).Title)
Span% = Menu(X%).Span * Spacing%
Offset% = Menu(X%).Position - Spacing%
Left% = Menu(X%).Position - (Spacing% * 2)
Range% = (LEN(Title$) + 2) * Spacing%
Depth% = (Menu(X%).Count * Banner%) + (Spacing% * 2)

' Draw the title label.
Future.FILLBOX Offset%, 0, Offset% + Range%, Banner%, Blue
Future.PRINT Menu(X%).Position, 1, Title$, White, Transparent

' Draw the pulldown box shadow first.
Future.FILLBOX Left% + 2, Shadow%, Left% + Span% + 2, Shadow% + Depth% + 2, DarkGrey

' Draw pulldown box of selected menu.
Future.FILLBOX Left%, Shadow%, Left% + Span%, Shadow% + Depth%, LightGrey

' Redraw the menu bar shadow line.
Future.BOX Left%, Shadow%, Left% + Span%, Shadow% + Depth%, DarkGrey

' NOTE: What follows prints the menu options from items in a string.
' ----- String manipulation adapted from an example by Ray Thomas.
' ----- [ http://brisray.com/qbasic/qtext.htm ]

' Dimension array used for menu items.
REDIM Options(1 TO Menu(X%).Count) AS ItemType

' Trim any empty space from Items string.
Items$ = RTRIM$(Menu(X%).Items)

' Define the top value for printing text.
Top% = (Shadow% + Spacing%) + 1

' Define the starting count number.
n% = 1

' Define default position values.
NewPos% = 0
OldPos% = 1

' Loop to find all comma separated items.
DO
  NewPos% = INSTR(NewPos% + 1, Items$, ",")
  Length% = NewPos% - OldPos%

  IF NewPos% > 0 THEN
    Elements$ = MID$(Items$, OldPos%, Length%)
    Options(n%).Name = MenuItem$(Elements$, "Name")
    Options(n%).Keys = MenuItem$(Elements$, "Keys")
    Options(n%).State = MenuItem$(Elements$, "State")
  ELSE
    Elements$ = MID$(Items$, OldPos%)
    Options(n%).Name = MenuItem$(Elements$, "Name")
    Options(n%).Keys = MenuItem$(Elements$, "Keys")
    Options(n%).State = MenuItem$(Elements$, "State")
  END IF

  ' Define menu item elements.
  Name$ = RTRIM$(Options(n%).Name)
  Keys$ = RTRIM$(Options(n%).Keys)
  State$ = RTRIM$(Options(n%).State)

  ' Calculate the gap between name and keys.
  Wide% = Menu(X%).Span - 2
  Gap% = Wide% - ((LEN(Name$) - 1) + LEN(Keys$))
  Void$ = STRING$(Gap%, " ")

  IF Name$ <> "-" THEN

    ' Get the shortcut key after the caret (^).
    KeyLoc% = INSTR(Name$, "^")
    Shortcut$ = MID$(Name$, KeyLoc% + 1, 1)
    Before$ = MID$(Name$, 1, KeyLoc% - 1)
    After$ = MID$(Name$, KeyLoc% + 1)

    ' Print the menu item either enabled or disabled!
    IF State$ = "On" THEN
      Future.PRINT Offset%, Top%, Before$ + After$ + Void$ + Keys$, Black, Transparent
      Future.PRINT Left% + (KeyLoc% * Spacing%), Top%, Shortcut$, White, Transparent
    ELSE
      Future.PRINT Offset%, Top%, Before$ + After$ + Void$ + Keys$, DarkGrey, Transparent
      Future.PRINT Left% + (KeyLoc% * Spacing%), Top%, Shortcut$, DarkGrey, Transparent
    END IF

    ' Set the Options array Shortcut value.
    Options(n%).Shortcut = Shortcut$

  ELSE

    ' Draw a divider if Name$ is only a dash (-).
    Divider% = (Top% + Spacing%) - 1
    Future.LINE Left%, Divider%, Left% + Span%, Divider%, DarkGrey, Solid%

  END IF

  ' Iterate values used.
  n% = n% + 1
  OldPos% = NewPos% + 1
  Top% = Top% + Banner%

LOOP UNTIL NewPos% = 0


' Define highlighted menu item parts.
HiLite$ = RTRIM$(Options(Y%).Name)
Keys$ = RTRIM$(Options(Y%).Keys)
State$ = RTRIM$(Options(Y%).State)

' Calculate the gap between name and keys.
Wide% = Menu(X%).Span - 2
Gap% = Wide% - ((LEN(HiLite$) - 1) + LEN(Keys$))
Void$ = STRING$(Gap%, " ")

' TODO: Ignore highlighting if all items are disabled?
' ----- Currently at least one item should be enabled!

' Draw highlighted menu item if not disabled!
IF HiLite$ <> "-" AND State$ = "On" THEN

  ' Get the shortcut key after the caret (^).
  KeyLoc% = INSTR(HiLite$, "^")
  Shortcut$ = MID$(HiLite$, KeyLoc% + 1, 1)
  Before$ = MID$(HiLite$, 1, KeyLoc% - 1)
  After$ = MID$(HiLite$, KeyLoc% + 1)

  ' Calculate position of highlight.
  Top% = (Shadow% + Spacing%) + 1
  Glow% = Top% + ((Banner% * Y%) - Banner%)

  ' Print the highlighted item and shortcut key.
  Future.FILLBOX Left%, Glow% - 1, Left% + Span%, Glow% + Banner%, Blue
  Future.PRINT Offset%, Glow%, Before$ + After$ + Void$ + Keys$, LightGrey, Transparent
  Future.PRINT Left% + (KeyLoc% * Spacing%), Glow%, Shortcut$, White, Transparent
   
  ' Set selected item (ranges 1100 to 1900).
  ItemID% = 1000 + (X% * 100) + Y%

  ' Debug the highlighted menu item.
  CALL DebugOutput("MENU", "MenuOptions: Item=[" + HiLite$ + "], Keys=[" + Keys$ + "], State=[" + State$ + "], & Shortcut=[" + Shortcut$ + "]")

  ' TODO: Temporary to determine identifiers.
  Future.PRINT Offset% + Span%, Glow%, "ItemID =" + STR$(ItemID%), DarkGrey, Transparent

ELSE
  SELECT CASE Z$
    CASE "Down"
      Y% = Y% + 1
      CALL MenuOptions(X%, Y%, Z$)
    CASE "Up"
      Y% = Y% - 1
      CALL MenuOptions(X%, Y%, Z$)
  END SELECT
END IF

' Debug of the X% and Y% values.
Message$ = "MenuOptions: X%=" + LTRIM$(STR$(X%)) + ", Y%=" + LTRIM$(STR$(Y%)) + ", Z$=" + LTRIM$(Z$) + ", & ID=" + LTRIM$(STR$(ItemID%))
CALL DebugOutput("MENU", Message$)

' Debug number of bytes used in Options array.
Size% = 0
FOR n% = 1 TO UBOUND(Options)
  Size% = Size% + LEN(RTRIM$(Options(n%).Keys))
  Size% = Size% + LEN(RTRIM$(Options(n%).Name))
  Size% = Size% + LEN(RTRIM$(Options(n%).Shortcut))
  Size% = Size% + LEN(RTRIM$(Options(n%).State))
NEXT n%

Message$ = "MenuOptions: Options array uses" + STR$(Size%) + " bytes."
CALL DebugOutput("MENU", Message$)

' Deallocate space used by menu pulldown array.
ERASE Options

END SUB

