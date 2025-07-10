' Module   : FILES.BAS
' Project  : Example module-based program using Future Library.
' Purpose  : File handling functions and sub-routines.
' Modified : 2025-07-10 -- Aligned the colons in the header.

' $INCLUDE: 'C:\QBX\DECLARE.BI'
' $INCLUDE: 'C:\BC7\FL35\FUTURE.BI'

FUNCTION FileExists% (Filename$)

' NOTE: FileExists takes a Filename$ string (including the path)
' ----- and returns false or true if the file exists or not.

' Check if Filename$ exists and return result.
IF LEN(DIR$(Filename$)) = 0 THEN
  FileExists% = False
ELSE
  FileExists% = True
END IF
	
END FUNCTION

SUB FileManager (Option$)

' NOTE: The FileManager is used to manage all file-handling
' ----- and redirects requests to the relevant sub-routines.

' TODO: Call FileOpen or FileSave for an open or save dialog...

END SUB

SUB FileOpen

' (?) ...

' TODO: ...

END SUB

SUB FileSave

' (?) ...

' TODO: ...

END SUB

