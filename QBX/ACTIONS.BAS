' Module: ACTIONS.BAS
' Project: Example module-based program using Future Library.
' Purpose: Action handling functions and sub-routines.
' Modified: 2022-12-15 -- Removed 'Dialog' from SELECT CASE Object$.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

SUB ActionManager (Cause$, Id%, Object$)

' NOTE: The ActionManager is called from either a Manager
' ----- sub-routine or an Object that triggers an action.

' Select case on passed object string.
SELECT CASE Object$

  ' Actions for defined buttons.
  CASE "Button"
    ' TODO: Select case for buttons...

  ' Actions passed from key manager.
  CASE "Key"
    ' TODO: Select case for pressed keys...

  ' Actions for each menu's items.
  CASE "Menu"
    SELECT CASE Id%
				
      ' File menu IDs in 1100 range.
      CASE 1101 ' "New"
	  ' TODO: Check saved status first...
		 
      CASE 1102 ' "Open"
	  ' TODO: Check saved status first...
		 
      CASE 1104 ' "Save"
	  ' TODO: Call FileManager...
		 
      CASE 1105 ' "Save As"
	  ' TODO: Call FileManager...
		 
      CASE 1107 ' "Exit"
	  ' TODO: Check saved status first...
	  Status.Quit = True
	  
      ' TODO: Add more cases for menus!
	    
	  ' Options menu IDs in 1400 range.
      CASE 1401 ' "Mouse..."
	  ' TODO: Open 'Mouse Preview' dialog...
	    
	  ' TODO: Add other cases for menus!

    END SELECT
	
    ' Debug the menu item selected.
    CALL DebugOutput("ACTION", "ActionManager: Menu item ID=" + LTRIM$(STR$(Id%)) + " selected with Enter key.")
	  
END SELECT

END SUB

