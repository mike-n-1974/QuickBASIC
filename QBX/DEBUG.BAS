' Module: DEBUG.BAS
' Project: Example module-based program using Future Library.
' Purpose: Debugging-related functions and sub-routines.
' Modified: 2024-11-19 -- Removed "Free memory:" preceding string.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

SUB DebugHeader
	
' NOTE: DebugHeader opens a DEBUG.LOG file for output and
' ----- prints a four-line header + other system info.

File% = FREEFILE
OPEN "C:\QBX\DEBUG.LOG" FOR OUTPUT AS File%

' Print the four-line header.
Header$ = "' Module: DEBUG.LOG" + CHR$(10) + "' Project: Example module-based program using Future Library." + CHR$(10) + "' Purpose: Debugging log file for possible error-solving." + CHR$(10) +  _
"' Created: This file is overwritten on each program run." + CHR$(10)
PRINT #File%, Header$

' Print the development environment.
Compiler$ = "' Compiler: Microsoft (R) QuickBASIC Extended v7.1 (PDS)."
PRINT #File%, Compiler$

' Print the Future.Library version.
Library$ = "' Library: Installed is " + Future.Version$ + "."
PRINT #File%, Library$

' Print the available system memory.
KBytes& = FreeXMSmemory& \ 1024
MBytes& = KBytes& \ 1024
Memory$ = "' Memory: " + LTRIM$(STR$(MBytes&)) + " MB (" + LTRIM$(STR$(KBytes&)) + " kilobytes) of Extended (XMS) memory."
PRINT #File%, Memory$

' Print the operating system version.
Version$ = "' System: " + DebugSystem$("VER")
PRINT #File%, Version$

CLOSE File%
	
END SUB

SUB DebugOutput (Module$, Message$)

' NOTE: DebugOutput sends debug messages to a text log file,
' ----- stating the Module and a Message on what occured.

' Remaining space in far memory.
FarBytes& = FRE(-1)
FarKBytes& = FarBytes& \ 1024

' Approximate remaining space in DGROUP.
Temp& = FRE(-2)
IF Temp& > 0 THEN
  DGBytes& = STACK - Temp&
ELSE
  DGBytes& = STACK
END IF

' Calculate DGROUP space in Kilobytes.
DGKBytes& = DGBytes& \ 1024

' Calculate available Extended Memory.
XMSKBytes& = FreeXMSmemory& \ 1024
XMSMBytes& = XMSKBytes& \ 1024

' Open debug log and append the message.
File% = FREEFILE
OPEN "C:\QBX\DEBUG.LOG" FOR APPEND AS File%

Datum$ = MID$(DATE$, 7, 4) + "-" + MID$(DATE$, 1, 2) + "-" + MID$(DATE$, 4, 2)
Debug$ = CHR$(10) + Datum$ + " " + TIME$ + " - " + Module$ + " - " + Message$
Memory$ = "' DGROUP =" + STR$(DGBytes&) + " bytes, Far =" + STR$(FarBytes&) + " bytes" + ", & XMS =" + STR$(XMSKBytes&) + " kilobytes."
PRINT #File%, Debug$
PRINT #File%, Memory$

CLOSE File%

' NOTE: Temporary display of debug info to the screen.
' ----- Comment out or delete this block to remove it.
Future.FILLBOX 0, Display.Y - 128, Display.X - 1, Display.Y - 1, DarkTurquoise

Future.PRINT 16, Display.Y - 80, Datum$ + " " + TIME$ + " - " + Module$ + " - " + Message$, DarkGrey, Transparent
Future.PRINT 16, Display.Y - 64, "Free DGROUP =" + STR$(DGBytes&) + " bytes (" + LTRIM$(STR$(DGKBytes&)) + " KB)", DarkGrey, Transparent
Future.PRINT 16, Display.Y - 48, "Far memory  =" + STR$(FarBytes&) + " bytes (" + LTRIM$(STR$(FarKBytes&)) + " KB)", DarkGrey, Transparent
Future.PRINT 16, Display.Y - 32, "XMS memory  =" + STR$(XMSKBytes&) + " kilobytes (" + LTRIM$(STR$(XMSMBytes&)) + " MB)", DarkGrey, Transparent

END SUB

FUNCTION DebugSystem$ (Query$)

' NOTE: DebugSystem returns a string containing the
' ----- requested query from a shelled DOS command.

' Define a temporary file.
Filename$ = "C:\QBX\VERSION.TMP"

' Run command and output to file.
SHELL UCASE$(Query$) + " > " + Filename$

' Open temporary file for input.
File% = FREEFILE
OPEN Filename$ FOR INPUT AS File%

' Get input by line until end-of-file.
DO WHILE NOT EOF(File%)
  LINE INPUT #File%, Line$
LOOP

' Return string if not empty.
IF Line$ <> "" THEN DebugSystem$ = Line$

CLOSE File%

' Delete temporary file.
KILL Filename$

END FUNCTION

