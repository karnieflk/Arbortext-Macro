TableChoiceGUI:
{
Escapedgui = 0
If GuiNumber !=0
	Gui , %GuiNumber%:Destroy

GuiNumber = 7
	GuiWIdth = 500
	GuiHeight = 300
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Gui , %GuiNumber%:Destroy
	Amonh /=2
	amonw /=2
	
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)	
	
Gui, %GuiNumber%:add, GroupBox,w100 h70,Table Size
Gui, %GuiNumber%:add, Radio, Checked xp+10 yp+20 gTableWidthCheck vTable_Width_GroupC, Column Wide
Gui, %GuiNumber%:add, Radio, xp yp+20  gTableWidthCheck vTable_Width_GroupW, Page Wide
Gui,%GuiNumber%: add, GroupBox, Xp+100 yp-40 w175 h50, Rows
Gui, %GuiNumber%:add, Text, xp+10 yp+25, Rows:
Gui,%GuiNumber%: add, Edit,  xp+32 yp-4 w50 Number Limit4, 
Gui, %GuiNumber%:add, UpDown, Range1-3001  vUserrows,20
Gui, %GuiNumber%:Font, CRed
Gui, %GuiNumber%:Add, Text, xp+52 w75 Vmaxlimit, Max is 3000 Rows 
Gui, %GuiNumber%:Font, 
Gui, %GuiNumber%:add, Button, Default xp-100 yp+190 h40 w250 gTablemaker, Make My Table

gui, %GuiNumber%:add, tab2,xp-100 yp-130 w390 h120 VTabnum, Parts Tables | Troubleshooting Tables | Tooling Tables | Spec Tables
Gui,  %GuiNumber%:tab,1
Gui, %GuiNumber%:add,  Radio,Checked xp+10 yp+30 gPartsTablecheck vpartstable2,2 Column (Qty, Part Name)
Gui, %GuiNumber%:add, Radio,yp+20 gPartsTablecheck vpartstable3,3 Column (Item, Qty, Part Name)
Gui, %GuiNumber%:add, Radio,yp+20 gPartsTablecheck vpartstable5,5 Column (Item, Qty, New Part Number, Part Name, Former Part Number)

Gui, %GuiNumber%:tab,2
Gui, %GuiNumber%:add, Radio,yp-40 gTroubleshootingcheck vj1939 , J1939 Code Description 
Gui, %GuiNumber%:add, Radio,yp+20 gTroubleshootingcheck vTroubleshotingtbl,Troubleshooting


Gui,  %GuiNumber%:Tab, 3
Gui, %GuiNumber%:add, Radio, yp-20 gToolingTablecheck vtooltbl, Tooling Table 

Gui,  %GuiNumber%:Tab, 4
Gui, %GuiNumber%:add, Radio,yp gSpectablecheck vSpectable, Specification Table

Gui, %GuiNumber%:Show, x%amonx% y%amonY% w%GuiWIdth% h%GuiHeight%, Table Selection
Guicontrol,%GuiNumber%:hide, maxlimit
Return
}



7GuiEscape:
7Guiclose:
{
UnPausescript()
Gui, 7:destroy
Escapedgui = 1
return
}

toolingtaBLECHECK:
{
Gui,7:submit, nohide

iF (tooltbl)
{
tabletype = toolingtable
guicontrol,,Table_Width_GroupW,1
Pgwd = Yes
}

Return

}

Tablemaker:
{
Gui,7:submit, nohide
GuicontrolGet, Userrows
If Userarrows > 3000
{
Guicontrol,%GuiNumber%:Show, maxlimit
Sleep 100
Guicontrol,%GuiNumber%:hide, maxlimit
Sleep 100
Guicontrol,%GuiNumber%:Show, maxlimit
Sleep 100
Guicontrol,%GuiNumber%:hide, maxlimit
Sleep 100
Guicontrol,%GuiNumber%:Show, maxlimit
return
}

Else if Userarrows < 3001
guicontrol, %GuiNumber%:hide, maxlimit

UnPausescript()
Gui, 7:Destroy
Return
}

Troubleshootingcheck:
{
Gui,7:submit, nohide

If (j1939)
{
Tabletype = jcode
guicontrol,,Table_Width_GroupW,1
Pgwd = Yes
}
If (Troubleshotingtbl)
{
tabletype = Troubleshoot
guicontrol,,Table_Width_GroupW,1
Pgwd = Yes
}
Return
}

TableWidthCheck:
{
Gui,7:submit, nohide

If (Table_Width_GroupC)
{
Pgwd = No
}

If (Table_Width_GroupW)
{
Pgwd = Yes
}

Return
}

PartsTablecheck:
{
Gui,7:submit, nohide


If (partstable2)
Tabletype = C2

If (partstable3)
Tabletype = C3

If (partstable5)
{
Tabletype = C5
guicontrol,,Table_Width_GroupW,1
Pgwd = Yes
}
Return
}

Spectablecheck:
{
Gui,7:submit, nohide

If (Spectable)
{
Tabletype = Spec
guicontrol,,Table_Width_GroupW,1
Pgwd = Yes
}
Return
}
