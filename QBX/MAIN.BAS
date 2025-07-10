' Module   : MAIN.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : Main program loop that calls relevant managers.
' Modified : 2025-07-10 -- Added separating lines in code below.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

' Create a debug log file.
CALL DebugHeader

' Empty all variables.
CLEAR

' Initialise the screen.
CALL ScreenInit

' Set the default font to 8x16.
CALL SetFont(1)

' Debug of first two CALLs in the main module.
CALL DebugOutput("MAIN", "Initialise the screen and set default font.")

' -------------------------------------------------------------------------------

' Set initial status values.
status.Quit = False
status.Saved = False

' Debug of initial values above.
CALL DebugOutput("MAIN", "Set initial Quit and Saved values to false.")

' -------------------------------------------------------------------------------

' Set the default mouse pointer.
CALL MouseCursor("Arrow")

' Load and draw the top menu bar.
CALL MenuAttributes

' Debug of mouse pointer and drawing the menu.
CALL DebugOutput("MAIN", "Set the mouse cursor and draw the menu.")
 

' Debug of main module before the loop.
CALL DebugOutput("MAIN", "In this module before the application loop.")

' -------------------------------------------------------------------------------

' Begin the main application loop.
DO

  ' Call the KeyManager to check for keys.
  CALL KeyManager

  ' Call the MouseManager to poll the mouse.
  CALL MouseManager("Desktop")
  
  ' TODO: Call the ViewManager to manage the view.
  'CALL ViewManager
  
' End loop on quit status being true.
LOOP UNTIL status.Quit = True

' -------------------------------------------------------------------------------

' Debug of main module after the loop.
CALL DebugOutput("MAIN", "In this module after the application loop.")

' Turn off the mouse.
CALL Future.MouseOff

' Reset Screen before exiting.
CALL ReSetScreen

' Debug in main module on exiting.
CALL DebugOutput("MAIN", "Now ending the program.")

' End the program.
SYSTEM

