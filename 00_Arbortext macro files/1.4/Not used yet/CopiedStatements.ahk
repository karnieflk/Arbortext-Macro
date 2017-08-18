Gui, Add, Text,, Pick which type of Warning that you want to search for.
Gui, Add, ListBox, vCopyMyListBox gCopyMyListBox w750 r3
Gui, Add, Button, Default, OK

GuiControl,, CopyMyListBox, The publication can be found on the Caterpillar Service Information System (SIS) or in normal literature distribution at your local Caterpillar dealer.
GuiControl,, CopyMyListBox, The following parts are adaptable to the machines within the listed serial numbers, and are effective with all machines after the listed serial numbers.
GuiControl,, CopyMyListBox, BU_ at the beginning of the part number indicates an SAP number. Use the proper ordering process for obtaining this part.
Gui, Show
return


CopyMyListBox:
	if A_GuiEvent <> DoubleClick ; if not a double click in the gui screen
return
; Otherwise, the user double-clicked a list item, so treat that the same as pressing OK.
; So fall through to the next label.
ButtonOK:
GuiControlGet, CopyMyListBox  ; Retrieve the ListBox's current selection.

; Otherwise, try to launch it:
Gui,Destroy
Clipboard = %CopyMyListBox%              