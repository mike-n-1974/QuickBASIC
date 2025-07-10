' Module   : SCREEN.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : Screen mode-related functions and sub-routines.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

SUB ScreenInit

' NOTE: ScreenInit is called from the main application
' ----- module on startup to initialize the video mode.

' Clear the screen.
CLS

' Open debug log to append screen modes.
File% = FREEFILE
OPEN "C:\QBX\DEBUG.LOG" FOR APPEND AS File%

' Initial debug line before mode check.
Datum$ = MID$(DATE$, 7, 4) + "-" + MID$(DATE$, 1, 2) + "-" + MID$(DATE$, 4, 2)
Debug$ = CHR$(10) + Datum$ + " " + TIME$ + " - " + "SCREEN" + " - " + "Checking for VESA modes (if any)..."
PRINT #File%, Debug$

' Define beginning index.
n% = 0

' Check that VESA video modes are possible.
DO
  ModeFound$ = Future.ModeList$(n%)
  
  IF ModeFound$ = "" THEN
    PRINT "No VESA mode found! Can not run this program."
    PRINT #File%, " - No VESA mode found! Or at the end of all modes."
    EXIT DO: END
  ELSEIF INSTR(ModeFound$, "640x480 8 Bits") THEN
	XAxis% = VAL(ScreenPart$(ModeFound$, "XAxis"))
	YAxis% = VAL(ScreenPart$(ModeFound$, "YAxis"))
	Bits% = VAL(ScreenPart$(ModeFound$, "Bits"))
  
    Display.X = XAxis%
    Display.Y = YAxis%
    Display.Bits = Bits%
	
    PRINT #File%, " - " + ModeFound$
  ELSE
    PRINT #File%, " - " + ModeFound$
  END IF
  
  n% = n% + 1
  
LOOP UNTIL ModeFound$ = ""
  
' TODO: Test code to check for a CONFIG.INI file...
IF FileExists%("C:\QBX\CONFIG.INI") = True THEN
  Exist$ = CHR$(10) + Datum$ + " " + TIME$ + " - " + "SCREEN" + " - " + "Testing that a CONFIG.INI file does exist!"
  PRINT #File%, Exist$
ELSE
  Exist$ = CHR$(10) + Datum$ + " " + TIME$ + " - " + "SCREEN" + " - " + "Testing that a CONFIG.INI file does not exist!"
  PRINT #File%, Exist$
END IF

' Close the debug file.
CLOSE File%

' Set the screen mode.
CALL ScreenMode(Display.X, Display.Y, Display.Bits)

' Set the background color.
Future.FILLBOX 0, 0, Display.X - 1, Display.Y - 1, DarkTurquoise

END SUB

SUB ScreenManager (State$) STATIC

' NOTE: The ScreenManager manages the saving and retrieving
' ----- of screen states, required for overlapping objects.

SELECT CASE State$

  ' TODO: Figure out how to calculate screen state size on-the-fly!
  ' Save screen state to XMS.
  CASE "Allocate"
    Size& = 307200 '(640 x 480)
    State% = AllocateXMS(Size&)
    Future.XMSget 0, 0, Display.X - 1, Display.Y - 1, State%

  ' Deallocate used space in XMS.
  CASE "Deallocate"
    DeallocateXMS State%

  ' Define XMS array to GET and PUT.
  CASE "DefineArray"
    ' TODO: Future.DefineXMSArray (X%, Y%, XMShandle%)...

  ' Retrieve screen state from XMS.
  CASE "Retrieve"
    Future.XMSput 0, 0, State%
	 
  ' Retrieve state from XMS array.
  CASE "RetrieveArray"
    ' TODO: Future.XMSArrayPut (X%, Y%, XMShandle%, Index%)...

  ' Save a state into a XMS array.
  CASE "SaveArray"
    ' TODO: Future.XMSArrayGet (X%, Y%, XMShandle%, Index%)...
	 
END SELECT

END SUB

SUB ScreenMode (X%, Y%, B%)

' NOTE: ScreenMode sets the current video mode of the screen
' ----- by passing the values to a Future Library sub-routine.

' Put the video mode and colors into a string.
Colors% = 2 ^ B%
Mode$ = STR$(X%) + " x" + STR$(Y%) + STR$(B%) + " Bits (" + LTRIM$(STR$(Colors%)) + " colors)."

' Output the video mode to the debug log.
CALL DebugOutput("SCREEN", "Video mode set to" + Mode$)

' Set screen mode using a Future Library sub-routine.
CALL SetScreenMode(X%, Y%, B%)

END SUB

FUNCTION ScreenPart$ (Mode$, Part$)

' NOTE: The ScreenPart$ function returns individual parts
' ----- of a string from the Future.ModeList$ function.

' NOTE: Parts of a mode string extracted from ModeList$:
' ------------------------------------------------------
' 640x480 8 Bits (101h)
' (A) (B) (C)    (D)
'
' A. Display width in pixels (up to four numbers long).
' B. Display height in pixels (up to four numbers long).
' C. Screen color bits (up to two numbers long).
' D. The hexadecimal VESA mode number (deprecated).

' Get the X and Y axis from Mode$.
xLoc% = INSTR(Mode$, "x")
XAxis$ = MID$(Mode$, 1, xLoc% - 1)
YAxis$ = RTRIM$(MID$(Mode$, xLoc% + 1, 4))

' Get the color Bit value from Mode$.
BitLoc% = xLoc% + LEN(YAxis$) + 1
Bits$ = RTRIM$(MID$(Mode$, BitLoc%, 3))

' Return the requested part.
SELECT CASE Part$

  ' Return the XAxis.
  CASE "XAxis"
    ScreenPart$ = XAxis$

  ' Return the YAxis.
  CASE "YAxis"
    ScreenPart$ = YAxis$

  ' Return the Bits.
  CASE "Bits"
    ScreenPart$ = Bits$

END SELECT

END FUNCTION

