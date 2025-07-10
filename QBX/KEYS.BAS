' Module: KEYS.BAS
' Project: Example module-based program using Future Library.
' Purpose: Keyboard handling functions and sub-routines.
' Modified: 2022-11-18 -- Added case for Alt + E keys pressed.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'


' NOTE: FOR REFERENCE ONLY (key codes for KeyManager)
' ---------------------------------------------------------
' Appropriate key codes for a US English QWERTY keyboard.
' A trailing asterisk (*) denotes a keycode has been used.
'
' ALT + KEYS:
' ---------------------------------------------------------
' CHR$(0) + CHR$(16)    =       Alt + Q
' CHR$(0) + CHR$(17)    =       Alt + W
' CHR$(0) + CHR$(18)    =       Alt + E *
' CHR$(0) + CHR$(19)    =       Alt + R
' CHR$(0) + CHR$(20)    =       Alt + T
' CHR$(0) + CHR$(21)    =       Alt + Y
' CHR$(0) + CHR$(22)    =       Alt + U
' CHR$(0) + CHR$(23)    =       Alt + I
' CHR$(0) + CHR$(24)    =       Alt + O
' CHR$(0) + CHR$(25)    =       Alt + P
'
' CHR$(0) + CHR$(30)    =       Alt + A
' CHR$(0) + CHR$(31)    =       Alt + S
' CHR$(0) + CHR$(32)    =       Alt + D
' CHR$(0) + CHR$(33)    =       Alt + F *
' CHR$(0) + CHR$(34)    =       Alt + G
' CHR$(0) + CHR$(35)    =       Alt + H
' CHR$(0) + CHR$(36)    =       Alt + J
' CHR$(0) + CHR$(37)    =       Alt + K
' CHR$(0) + CHR$(38)    =       Alt + L
'
' CHR$(0) + CHR$(44)    =       Alt + Z
' CHR$(0) + CHR$(45)    =       Alt + X *
' CHR$(0) + CHR$(46)    =       Alt + C
' CHR$(0) + CHR$(47)    =       Alt + V
' CHR$(0) + CHR$(48)    =       Alt + B
' CHR$(0) + CHR$(49)    =       Alt + N
' CHR$(0) + CHR$(50)    =       Alt + M
'
' CHR$(0) + CHR$(104)   =       Alt + F1
' CHR$(0) + CHR$(105)   =       Alt + F2
' CHR$(0) + CHR$(106)   =       Alt + F3
' CHR$(0) + CHR$(107)   =       Alt + F4
' CHR$(0) + CHR$(108)   =       Alt + F5
' CHR$(0) + CHR$(109)   =       Alt + F6
' CHR$(0) + CHR$(110)   =       Alt + F7
' CHR$(0) + CHR$(111)   =       Alt + F8
' CHR$(0) + CHR$(112)   =       Alt + F9
' CHR$(0) + CHR$(113)   =       Alt + F10
' CHR$(0) + CHR$(139)   =       Alt + F11
' CHR$(0) + CHR$(140)   =       Alt + F12
'
' CHR$(0) + CHR$(120)   =       Alt + 1
' CHR$(0) + CHR$(121)   =       Alt + 2
' CHR$(0) + CHR$(122)   =       Alt + 3
' CHR$(0) + CHR$(123)   =       Alt + 4
' CHR$(0) + CHR$(124)   =       Alt + 5
' CHR$(0) + CHR$(125)   =       Alt + 6
' CHR$(0) + CHR$(126)   =       Alt + 7
' CHR$(0) + CHR$(127)   =       Alt + 8
' CHR$(0) + CHR$(128)   =       Alt + 9
' CHR$(0) + CHR$(129)   =       Alt + 0
'
' CONTROL + KEYS:
' ---------------------------------------------------------
' CHR$(0) + CHR$(94)    =       Ctrl + F1
' CHR$(0) + CHR$(95)    =       Ctrl + F2
' CHR$(0) + CHR$(96)    =       Ctrl + F3
' CHR$(0) + CHR$(97)    =       Ctrl + F4
' CHR$(0) + CHR$(98)    =       Ctrl + F5
' CHR$(0) + CHR$(99)    =       Ctrl + F6
' CHR$(0) + CHR$(100)   =       Ctrl + F7
' CHR$(0) + CHR$(101)   =       Ctrl + F8
' CHR$(0) + CHR$(102)   =       Ctrl + F9
' CHR$(0) + CHR$(103)   =       Ctrl + F10
' CHR$(0) + CHR$(137)   =       Ctrl + F11
' CHR$(0) + CHR$(138)   =       Ctrl + F12
'
' CHR$(0) + CHR$(114)   =       Ctrl + Prnt Scr
' CHR$(0) + CHR$(115)   =       Ctrl + Left
' CHR$(0) + CHR$(116)   =       Ctrl + Right
' CHR$(0) + CHR$(117)   =       Ctrl + End
' CHR$(0) + CHR$(118)   =       Ctrl + Page Down
' CHR$(0) + CHR$(119)   =       Ctrl + Home
' CHR$(0) + CHR$(132)   =       Ctrl + Page Up
'
' FUNCTION KEYS:
' ---------------------------------------------------------
' CHR$(0) + CHR$(59)    =       F1
' CHR$(0) + CHR$(60)    =       F2
' CHR$(0) + CHR$(61)    =       F3
' CHR$(0) + CHR$(62)    =       F4
' CHR$(0) + CHR$(63)    =       F5
' CHR$(0) + CHR$(64)    =       F6
' CHR$(0) + CHR$(65)    =       F7
' CHR$(0) + CHR$(66)    =       F8
' CHR$(0) + CHR$(67)    =       F9
' CHR$(0) + CHR$(68)    =       F10
' CHR$(0) + CHR$(133)   =       F11
' CHR$(0) + CHR$(134)   =       F12
'
' OTHER KEYS:
' ---------------------------------------------------------
' CHR$(0) + CHR$(71)    =       Home
' CHR$(0) + CHR$(72)    =       Up
' CHR$(0) + CHR$(73)    =       Page Up
' CHR$(0) + CHR$(75)    =       Left
' CHR$(0) + CHR$(77)    =       Right
' CHR$(0) + CHR$(79)    =       End
' CHR$(0) + CHR$(80)    =       Down
' CHR$(0) + CHR$(81)    =       Page Down
' CHR$(0) + CHR$(82)    =       Insert
' CHR$(0) + CHR$(83)    =       Delete
'
' SHIFT + KEYS:
' ---------------------------------------------------------
' CHR$(0) + CHR$(15)    =       Shift + Tab
' CHR$(0) + CHR$(84)    =       Shift + F1
' CHR$(0) + CHR$(85)    =       Shift + F2
' CHR$(0) + CHR$(86)    =       Shift + F3
' CHR$(0) + CHR$(87)    =       Shift + F4
' CHR$(0) + CHR$(88)    =       Shift + F5
' CHR$(0) + CHR$(89)    =       Shift + F6
' CHR$(0) + CHR$(90)    =       Shift + F7
' CHR$(0) + CHR$(91)    =       Shift + F8
' CHR$(0) + CHR$(92)    =       Shift + F9
' CHR$(0) + CHR$(93)    =       Shift + F10
' CHR$(0) + CHR$(135)   =       Shift + F11
' CHR$(0) + CHR$(136)   =       Shift + F12

SUB KeyManager

' NOTE: The KeyManager is called from the main application loop,
' ----- so has no DO...LOOP of its own. Captures most key presses.

' Capture the keys pressed.
KeyPress$ = INKEY$

SELECT CASE KeyPress$

  ' Show File menu on Alt + F pressed.
  CASE CHR$(0) + CHR$(33)
    CALL DebugOutput("KEYS", "KeyManager: Alt + F keys pressed = File menu.")
    CALL MenuManager(1)
	 
  ' Show Edit menu on Alt + E pressed.
  CASE CHR$(0) + CHR$(18)
   CALL DebugOutput("KEYS", "KeyManager: Alt + E keys pressed = Edit menu.")
   CALL MenuManager(2)

  ' TODO: Add more menu key presses here...

  ' Exit program on Alt + X pressed.
  CASE CHR$(0) + CHR$(45)
    CALL DebugOutput("KEYS", "KeyManager: Alt + X keys pressed = Exit program.")
    ' TODO: Check Status.Saved value first...
    Status.Quit = True

  ' TODO: Add cases for CTRL key sequences...

END SELECT

END SUB

