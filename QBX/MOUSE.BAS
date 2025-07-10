' Module   : MOUSE.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : Mouse handling functions and sub-routines.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

' Mouse pointer data statements.
Arrow:
DATA 03,03,03,00,00,03,03,03,03,03,03,03,03,03,03,03
DATA 03,03,03,00,15,00,03,03,03,03,03,03,03,03,03,03
DATA 03,03,03,00,15,15,00,03,03,03,03,03,03,03,03,03
DATA 03,03,03,00,15,15,15,00,03,03,03,03,03,03,03,03
DATA 03,03,03,00,15,15,15,15,00,03,03,03,03,03,03,03
DATA 03,03,03,00,15,15,15,15,15,00,03,03,03,03,03,03
DATA 03,03,03,00,15,15,15,15,15,15,00,03,03,03,03,03
DATA 03,03,03,00,15,15,15,15,15,15,15,00,03,03,03,03
DATA 03,03,03,00,15,15,15,15,00,00,00,00,00,03,03,03
DATA 03,03,03,00,15,15,00,15,15,00,03,03,03,03,03,03
DATA 03,03,03,00,15,00,00,15,15,00,03,03,03,03,03,03
DATA 03,03,03,00,00,03,03,00,15,15,00,03,03,03,03,03
DATA 03,03,03,00,03,03,03,00,15,15,00,03,03,03,03,03
DATA 03,03,03,03,03,03,03,03,00,15,15,00,03,03,03,03
DATA 03,03,03,03,03,03,03,03,00,15,15,00,03,03,03,03
DATA 03,03,03,03,03,03,03,03,03,00,00,03,03,03,03,03

Hand:
DATA 03,03,03,03,03,03,03,00,00,03,03,03,03,03,03,03
DATA 03,03,03,00,00,03,00,15,15,00,00,00,03,03,03,03
DATA 03,03,00,15,15,00,00,15,15,00,15,15,00,03,03,03
DATA 03,03,00,15,15,00,00,15,15,00,15,15,00,03,00,03
DATA 03,03,03,00,15,15,00,15,15,00,15,15,00,00,15,00
DATA 03,03,03,00,15,15,00,15,15,00,15,15,00,15,15,00
DATA 03,00,00,03,00,15,15,15,15,15,15,15,00,15,15,00
DATA 00,15,15,00,00,15,15,15,15,15,15,15,15,15,15,00
DATA 00,15,15,15,00,15,15,15,15,15,15,15,15,15,00,03
DATA 03,00,15,15,15,15,15,15,15,15,15,15,15,15,00,03
DATA 03,03,00,15,15,15,15,15,15,15,15,15,15,15,00,03
DATA 03,03,00,15,15,15,15,15,15,15,15,15,15,00,03,03
DATA 03,03,03,00,15,15,15,15,15,15,15,15,15,00,03,03
DATA 03,03,03,03,00,15,15,15,15,15,15,15,00,03,03,03
DATA 03,03,03,03,03,00,15,15,15,15,15,15,00,03,03,03
DATA 03,03,03,03,03,00,15,15,15,15,15,15,00,03,03,03

' -------------------------------------------------------------------------------

SUB MouseCursor (Shape$)

' NOTE: MouseCursor is used to set the mouse pointer shape,
' ----- by restoring, parsing, and masking the defined DATA.

' Select case on passed shape string.
SELECT CASE Shape$

  ' Get DATA for an arrow.
  CASE "Arrow"
    RESTORE Arrow

  ' Get DATA for a hand.
  CASE "Hand"
    RESTORE Hand

END SELECT

' Temporarily turn off the mouse.
CALL Future.MouseOff

' Copy mouse shape DATA into a string.
FOR i% = 0 TO 255
  READ C%
  C$ = C$ + CHR$(C%)
NEXT

' Parse data and set mask color as 3 (cyan).
CALL Future.MouseShape(SADD(C$), SSEG(C$))
CALL SetMouseMaskColor(3)

' Turn the mouse on again.
CALL Future.MouseOn

END SUB

SUB MouseManager (Mode$)

' NOTE: The MouseManager is called from the main application
' ----- loop and the MenuManager loop, so has no DO...LOOP.

' Continually update the mouse.
CALL Future.UpdateMouse

' Get current mouse status.
X% = Future.MouseX
Y% = Future.MouseY
B% = Future.MouseB

' Check for cases of buttons clicked.
' Button: 1 = Left, 2 = Right, 3 = Both
SELECT CASE B%

  ' Check for click areas on left button.
  CASE 1

    ' TODO: Check for clicks in menu items.
    'CALL MenuClicks(X%, Y%, Mode$)

    ' Check for clicks in menu labels.
    CALL MenuLabels(X%, Y%, Mode$)

END SELECT

END SUB

SUB MouseMode (Menu%, Mode$)

' NOTE: MouseMode is used to display the pulldown menu depending
' ----- on if selected from the main View or while in the Menu.

' Select case on passed mode string.
SELECT CASE Mode$

  ' Display menu from the main view.
  CASE "Desktop"
    CALL MenuManager(Menu%)

  ' Display menu while in the menus.
  CASE "Menu"
    CALL ScreenManager("Retrieve")
    CALL MenuOptions(Menu%, 1, "Down")

END SELECT

END SUB

SUB MousePreview
	
' NOTE: MousePreview is used to display a dialog box that
' ----- shows an enlarged mouse cursor image on 16x16 grid.

' TODO: Add code to display a preview dialog...
' ----- Have < and > arrows to change cursors...

END SUB

