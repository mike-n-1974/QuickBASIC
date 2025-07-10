' Module   : VIEW.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : View management functions and sub-routines.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

SUB ViewManager (View$)

' NOTE: The ViewManager manages requests for on-screen objects,
' ----- by calling the relevant sub-routine as defined by View$.

' Handle requests for interface views.
SELECT CASE View$

  ' Call for a Mouse preview.
  CASE "Mouse"
    'CALL ViewMouse

  ' Call for a Open dialog.
  CASE "Open"
    'CALL ViewOpen
	
  ' Call for a Save dialog.
  CASE "Save"
    'CALL ViewSave
  
  ' Call for a Save As dialog.
  CASE "SaveAs"
    'CALL ViewSaveAs

END SELECT

END SUB