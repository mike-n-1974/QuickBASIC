' Module   : OBJECTS.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : Object creation functions and sub-routines.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'
       
' OBJECT PARAMETERS ARE AS FOLLOWS ("null" if not applicable):
' ------------------------------------------------------------
'  - Button = "Arrow", "Cancel", "Check", "Default", or "Radio"
'  - Frame  = "None", "Solid", "Title", or "Window"
'  - Id     =  0000 (4-digit integer, in object ranges, not 1000s)
'  - Size   = "XXX1,YYY1,XXX2,YYY2" (left,top,width,height)
'  - Kind   = "Button", "Dialog", "Input", "Scroll", or "TextBox"
'  - Scroll = "Both", "Horiz", "None", or "Vert" (if object has any)
'  - Title  =  On Dialogs, TextBoxes, or Window objects only

SUB ObjectButton (Object AS ObjectType)

END SUB

SUB ObjectFrame (Object AS ObjectType)

END SUB

SUB ObjectInput (Object AS ObjectType)

END SUB

SUB ObjectScroll (Object AS ObjectType)

END SUB

SUB ObjectTextBox (Object AS ObjectType)

END SUB

SUB ObjectWindow (Object AS ObjectType)
	
END SUB

