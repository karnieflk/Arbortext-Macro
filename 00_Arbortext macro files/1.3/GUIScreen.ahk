
;This makes up the win+alt screen
Guiscreen:
{
	If GuiNumber !=0 ; If guiscreeen vairable is not 0
	Gui , %GuiNumber%:Destroy ; closes the gui screen
;Below is making the menu for the gui screen
	Menu, BBBB, Add, &Check For Update , Versioncheck
	Menu, BBBB, Add, &Options, Optionsmenu
	Menu, BBBB, Add,
	Menu, BBBB, Add, &Exit, exitprogram
	
	Menu, DDDD, Add, &How To Use, HowTo
	Menu, DDDD, Add, &About , Aboutmenu
	
	Menu, MyMenuBar, Add, &File, :BBBB
	Menu, MyMenuBar, Add, &Help, :DDDD
	
	
	GuiNumber = 1 ; sets the guiscreen variable to 1
	GuiWIdth = 824  ;sets the width of the gui screen
	GuiHeight =500 ; Sets the height of the gui screen

	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.

	Gui , %GuiNumber%:Destroy ; in case the guiscren was not destroyed already to clear and issues with duplicate variables
	Amonh /=2 ; some math to get the gui screen in the center of the window
	amonw /=2 ; more match to center screen
	
	amonx := amonx + (amonw/2) ; still math to get the final screen placement
	amony := amony + (amonh/2) ; last bit of math for now
	
	
	sleep 200 ; pauses script for 200 miliseconds
	Settimer, Quickview, 2000 ; Sets up a timer to close window after 2 seconds on not active
	Gosub, Load_Settings ; loads the settings from the ini files
	gosub, GuiTab1 ; goes to teh guitab subroutine

	Gui , %GuiNumber%:Add, groupbox, xm+21 ym+15 Section w235 h95, 
	Gui, %GuiNumber%:font,C131980 Bold Underline s12
	Gui,%GuiNumber%:Add, Text, xs+5 ys+15 vCPNGui, %CPNHotKey%:
	
	Gui,%GuiNumber%:font,C131980 norm s8
	Gui,%GuiNumber%:Add, Text, xs+5 ys+40   , 1 Press: CPN (Singular)
	
	Gui,%GuiNumber%:Add, Text, xs+5 ys+60   , 2 Presses : CPN (Plural)
	Gui,%GuiNumber%: Add, Text, xs+5 ys+80   , 3 Presses: CPN Modifier
	
	Gui , %GuiNumber%:Add, groupbox, xm+21 ym+115 Section w235 h165,
	Gui, %GuiNumber%:font,C7a1380 Bold Underline s12
	Gui,%GuiNumber%:Add, Text, xS+3 yS+10  vMETgui, %METHotKey%:
	
	Gui,%GuiNumber%:font, C7a1380 Norm s8
	
	Gui,%GuiNumber%:Add, Text, xS+3 ys+30 , 1 Press: Create a Units Group tag +++
	Gui,%GuiNumber%:Add, Text, xS+3 ys+50 , 2 Presses: Fill a Units Group tag +++
	Gui,%GuiNumber%:Add, Text, xS+3 ys+70 w230 , +++ Within 10 seconds perform one of the following actions:
	Gui,%GuiNumber%:Add, Text, xS+3 ys+100 w230 , Click in Metric or English tag to open Conversion Window
	Gui,%GuiNumber%:Add, Text, xS+3 ys+130  w230, Click and Hold in Metric or English tag to open Convertion with Tolerance Window
	
	Gui , %GuiNumber%:Add, groupbox, xm+21 ym+280 Section w235 h95,
	Gui,%GuiNumber%:font,C801350 Bold Underline s12
	Gui,%GuiNumber%:Add, Text, xs+3 ys+10  VCHKgui, %CHKHotKey%:
	
	Gui, %GuiNumber%:font,C801350 Norm s8
	Gui,%GuiNumber%:Add, Text, xs+3 ys+35, 1 Press: Check Out Object
	Gui,%GuiNumber%:Add, Text, xs+3 ys+55, 2 Presses: Check In Object
	Gui,%GuiNumber%:Add, Text, xs+3 ys+75, 3 Presses: Validate Object
	
	
	Gui , %GuiNumber%:Add, groupbox, xm+21 ym+380 Section w235 h105,
	Gui,%GuiNumber%:font,C801319 Bold Underline s12
	Gui,%GuiNumber%:Add, Text, xs+3 ys+10  vSearchgui, %SearchHotKey%:
	
	Gui,%GuiNumber%:font,C801319 Norm s8
	Gui,%GuiNumber%:Add, Text, xs+3 ys+35 w208 h65, Opens and Sets up Graphic Search Window In Arbortext and from Canvas Image Check In Screen. If in Canvas, click in Gnumber Box at check in window, then press hotkey.
	
		
	; 2nd column
	
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+15 Section w510 h140, 
	Gui, %GuiNumber%:font,C0e1360 Bold Underline s12
	Gui,%GuiNumber%:Add, Text, xs+3 ys+10  vCtrlcpngui, Ctrl + %CPNHotKey%
	
	Gui, %GuiNumber%:font,C0e1360 Norm s8
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+30 , Auto Find empty CPN tags within current screen and Fills them. 
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+50 , Esc: Stops auto fill
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+70 w465 ,If CPN has no Cat Part number, The CPN tag will remain blank and the Arbortext Macros program will continue on with filling the remaining empty CPN tags.
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+110 w465, If The Search Function seems to try to enter the CPN on the wrong location, Delete the image files in C:/ArbortextMacros/UserImages to reset the search parameters.
	
	Gui, %GuiNumber%:font,C804313 Bold Underline s12
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+150 Section w510 h75, 
	Gui, %GuiNumber%:Add, Text, xs+3 ys+11 w24 h23 vTablegui, %TableHotKey%:
	
	Gui, %GuiNumber%:font,C804313 Norm s8
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+40  , 1 Press : Create Table

	
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+230 Section w255 h50,
	Gui,%GuiNumber%:font, CBlack Bold Underline S12
	Gui, %GuiNumber%:Add, Text, xs+3 Ys+10, Ctrl + Shift + S
	
	Gui, %GuiNumber%:font,CBlack Norm s8
	Gui, %GuiNumber%:Add, Text, xs+3 Ys+35, Search For warnings in Arbortext
	
	Gui, %GuiNumber%:font,C1db8a9 Bold Underline s11
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+280 Section w255 h50,
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+10  , WIN + A
	
	Gui, %GuiNumber%:font,C1db8a9 Norm s8
	Gui, %GuiNumber%:Add, Text, xs+3 ys+30 , Bring Arbortext Window to Front
	
	Gui, %GuiNumber%:font,C1d79b8 Bold Underline s11
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+330 Section w255 h50, 
	Gui, %GuiNumber%:Add, Text, xs+3 ys+10 , WIN + B
	
	Gui, %GuiNumber%:font,C1d79b8 Norm s8
	Gui , %GuiNumber%:Add, Text,  xs+3 ys+30, Bring Image Browser Window in Arbortext to Front
	
	Gui, %GuiNumber%:font,Cb81d79 Bold Underline s11
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+380 Section w255 h50, 
	Gui ,%GuiNumber%:Add, Text,xs+3 ys+10 , WIN + C
	
	Gui, %GuiNumber%:font,Cb81d79 Norm s8
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+30, Bring Windchill Canvas Window to Front
	
	Gui, %GuiNumber%:font,C1d79b8 Bold Underline s11
	Gui , %GuiNumber%:Add, groupbox, xm+270 ym+430 Section w255 h50, 
	Gui, %GuiNumber%:Add, Text, xs+3 ys+10, WIN + H
	
	Gui, %GuiNumber%:font,C1d79b8 Norm s8
	Gui , %GuiNumber%:Add, Text, xs+3 ys+30, Bring Windchill - Home Tab to Front
	
	
	Gui, %GuiNumber%:Menu, MyMenuBar
	Gui, %GuiNumber%:Show, x%amonx% y%amonY% w%GuiWIdth% h%GuiHeight%, Arbortext Hotkeys V%Version_Number%
	
	return
}

; options gui screen
Optionsmenu:
{
	GuiWIdth = 824 
	GuiHeight = 430
	gosub, Load_Settings
	If GuiNumber !=0
	Gui , %GuiNumber%:Destroy
	GuiNumber = 2
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	
	Gui, %guiNumber%:Destroy
	sleep 200
	
	Settimer, Quickview, 2000
	;Gui, submit, nohide
	Gui, %GuiNumber%:Add, Groupbox, Section xm+5 ym+19 w800 h400
	Gui, %GuiNumber%:Add, Groupbox, xs+10 ys+19 w470 h60
	;Gui,2:Submit, NoHide
	Gui, %GuiNumber%:Add, Text, xp+37 yp+27 w200 h30 , CPN Tag Fill (Single - Plural - Mod)
	Gui, %GuiNumber%:Add, Text, xp+182 yp-13 w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF1Status% xp-150 yp+20 w15 h20 vCPNF1 gCPNRad,CPNF1
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF2Status% xp+30 yp w15 h20 vCPNf2 gCPNRad,CPNF2
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF3Status% xp+30 yp w15 h20 vCPNf3 gCPNRad, CPNF3
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF4Status% xp+30 yp w15 h20 vCPNf4 gCPNRad, CPNF4
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF5Status% xp+30 yp w15 h20 vCPNf5 gCPNRad, CPNF5
	Gui, %GuiNumber%:Add, Radio, Checked%CPNUNStatus% xp+50 yp w15 h20 vCPNUN gCPNRad, CPNUN
	
	; Metric to English Table Gui Options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h40 , Units Group tag and Conversion window(Click or click and hold in tag)
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%METF1Status% xp-150 yp+20 w15 h20 vMETF1 gMETRad,METF1
	Gui, %GuiNumber%:Add, Radio, Checked%METF2Status% xp+30 yp w15 h20 vMETF2 gMETRad,METF2
	Gui, %GuiNumber%:Add, Radio, Checked%METF3Status% xp+30 yp w15 h20 vMETF3 gMETRad, METF3
	Gui, %GuiNumber%:Add, Radio, Checked%METF4Status% xp+30 yp w15 h20 vMETF4 gMETRad, METF4
	Gui, %GuiNumber%:Add, Radio, Checked%METF5Status% xp+30 yp w15 h20 vMETF5 gMETRad, METF5
	Gui, %GuiNumber%:Add, Radio, Checked%METUNStatus% xp+50 yp w15 h20 vMETUN gMETRad, METUN
	
	; Check in - check out - validate GUI options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h30 , Check in- Check out - Validate
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF1Status% xp-150 yp+20 w15 h20 vCHKF1 gCHKRad,CHKF1
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF2Status% xp+30 yp w15 h20 vCHKF2 gCHKRad,CHKF2
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF3Status% xp+30 yp w15 h20 vCHKF3 gCHKRad,CHKF3
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF4Status% xp+30 yp w15 h20 vCHKF4 gCHKRad, CHKF4
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF5Status% xp+30 yp w15 h20 vCHKF5 gCHKRad, CHKF5
	Gui, %GuiNumber%:Add, Radio, Checked%CHKUNStatus% xp+50 yp w15 h20 vCHKUN gCHKRad,CHKUN
	
	;Search function Gui Options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w100 h30 , Graphic Search
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF1Status% xp-150 yp+20 w15 h20 vSearchF1 gSearchRad,SearchF1
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF2Status% xp+30 yp w15 h20 vSearchF2 gSearchRad,SearchF2
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF3Status% xp+30 yp w15 h20 vSearchF3 gSearchRad, SearchF3
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF4Status% xp+30 yp w15 h20 vSearchF4 gSearchRad, SearchF4
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF5Status% xp+30 yp w15 h20 vSearchF5 gSearchRad, SearchF5
	Gui, %GuiNumber%:Add, Radio, Checked%SearchUNStatus% xp+50 yp w15 h20 vSearchUN gSearchRad,SearchUN
	
	; Tables Gui options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10  yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h30 , Tables (Col wide - Pg Wide - Eng Troubleshooting - VSP)
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%TableF1Status% xp-150 yp+20 w15 h20 VTableF1 gTableRad,TableF1
	Gui, %GuiNumber%:Add, Radio, Checked%TableF2Status% xp+30 yp w15 h20 VTableF2 gTableRad,TableF2
	Gui, %GuiNumber%:Add, Radio, Checked%TableF3Status% xp+30 yp w15 h20 VTableF3 gTableRad, TableF3
	Gui, %GuiNumber%:Add, Radio, Checked%TableF4Status% xp+30 yp w15 h20 VTableF4 gTableRad, TableF4
	Gui, %GuiNumber%:Add, Radio, Checked%TableF5Status% xp+30 yp w15 h20 VTableF5 gTableRad,TableF5
	Gui, %GuiNumber%:Add, Radio, Checked%TableUNStatus% xp+50 yp w15 h20 vTableUN gTableRad,TableUN
	Gui, %GuiNumber%:Add, Button, xs+10 yp+30 w60 h60 h30 gDefault_Settings, Default Settings
	Gui, %GuiNumber%:Add, Button, xp+100 yp w60 h60 h30 gSettings_save, Save Settings
	Gui, %GuiNumber%:Add, Button, xp+290 yp w60 w75 h30 gDelete_images, Reset CPN Autofill Search
	
	
	; For Canvas scrren options
	Gui, %GuiNumber%:Add, Groupbox, xs+500 ys+30 w300 h125
	Gui, %GuiNumber%:add, Text, x570 y40 w200 h20 vcanvassearchoptions, Canvas Search Options For (%SearchHotKey%) Hotkey
	Gui, %GuiNumber%:add, Text, x620 y60 w150 h20, Section Numbers
	Gui, %GuiNumber%:Add, Edit, x650 y80  w30 limit3 vSection1, %Section1%
	gui, %GuiNumber%:add, text, x610 y83 , 1 Press:
	Gui, %GuiNumber%:Add, Edit, x650 y100 w30 limit3 vSection2, %Section2%
	gui, %GuiNumber%:add, text, x610 y103 , 2 Press:
	Gui, %GuiNumber%:Add, Edit, x650 y120 w30  limit3 vSection3, %Section3%
	gui, %GuiNumber%:add, text, x610 y123, 3 Press:
	
	
	; For autoCPN Fill
	Gui, %GuiNumber%:Add, Groupbox, xs+500 ys+200 w300 h125, CPN Autofill Options
	Gui, %GuiNumber%:Add, Checkbox, checked%autocheckbox% xp+10 yp+20 gautofillcheckboxsave vautocheckbox, Autoscroll down for CPN fill (ESC Key stops Autoscrolling)
	Gosub, SetOPtions
	gui,%GuiNumber%:submit, nohide
	;Gui, %GuiNumber%:Add, Picture, x0 y0 w%GuiWIdth% h%GuiHeight% +0x4000000, %GuiBackground%
	Gui,%GuiNumber%:Show, x%amonx% y%amony% w%GuiWIdth% h%GuiHeight%, Arbortext Hotkeys V%Version_Number%
	return
}

;about menu gui screen
Aboutmenu:
{
	If GuiNumber !=0
	Gui , %GuiNumber%:Destroy
	GuiNumber = 3
	GuiWIdth = 600 
	GuiHeight = 240
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	Gui, %guiNumber%:Destroy
	sleep 200
	Gui, %GuiNumber%:Add, Groupbox, x5 y10 w590 h210
	Gui,%GuiNumber%:Add,Text, xp+10 yp+10 , This program was designed to help increase productivity by automating commomly used tasks in Arbortext and Canvas
	Gui,%GuiNumber%:Add,Text, xp yp+25 BackgroundTrans, To get the latest version, go to the File menu and select Check for updates.
	Gui, %GuiNumber%:add, Text, xp yp+25   BackgroundTrans,  The location of the macro is at the following box account:
	gui, %GuiNumber%:font, CBlue Underline
	Gui, %GuiNumber%:Add,Text, xp yp+20  BackgroundTrans gboxlink, https://cat.box.com/s/kbbxsf1ceyf0lo65n6s52if0op0rzok7
	gui, %GuiNumber%:font,
	Gui, %GuiNumber%:Add,Text, xp yp+30, For program bugs or possible enhancement requests, Email:
	gui, %GuiNumber%:font, CBlue Underline
	Gui, %GuiNumber%:add,Text, xp yp+20  gemaillink, Karnia_Jarett_S@Cat.com with subject line: Arbortext Macros Program
	gui, %GuiNumber%:font,
	gui, %GuiNumber%:font, s8
	gui, %GuiNumber%:add, Text, xp+250 yp+35  BackgroundTrans, This program was created by
	gui, %GuiNumber%:add, Text, xp yp+25  BackgroundTrans, and is maintained by Jarett Karnia
	;Gui, %GuiNumber%:Add, Picture, x0 y0 w%GuiWIdth% h%GuiHeight% +0x4000000, %GuiBackground%
	Gui, %GuiNumber%:Show, x%amonx% y%amony% w%GuiWIdth% h%GuiHeight% , Arbortext Hotkeys V%Version_Number%
	Settimer, Quickview, 2000
	return
}

; warnings menu gui screen
Warningsgui:
{
	If GuiNumber !=0
	Gui , %GuiNumber%:Destroy
	GuiNumber = 5
	gui %GuiNumber%: destroy
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	
	Gui, %GuiNumber%:Add, Text,x10 y10,Pick which type of Warning that you want to search for, or type in Warning Number below.
	Gui, %GuiNumber%:Add, ListBox, vMyListBox gMyListBoxs w270 r27
	Gui, %GuiNumber%:Add, Text,xp+300 yp+50, Warning Number to search for:
	Gui, %GuiNumber%:Add, Edit,xp yp+30 w75 vWarningsnumbertext, 
	Gui, %GuiNumber%:Add, Button, Default gButtonOK, OK
	
	GuiControl,%GuiNumber%:, MyListBox, Air Cleaner
	GuiControl,%GuiNumber%:, MyListBox, Brake Saver
	GuiControl,%GuiNumber%:, MyListBox, Brakes
	GuiControl,%GuiNumber%:, MyListBox, Burns
	GuiControl,%GuiNumber%:, MyListBox, Chemicals
	GuiControl,%GuiNumber%:, MyListBox, Cooling System
	GuiControl,%GuiNumber%:, MyListBox, Crushing
	GuiControl,%GuiNumber%:, MyListBox,  Electrical System
	GuiControl,%GuiNumber%:, MyListBox,  Engine
	GuiControl,%GuiNumber%:, MyListBox,  Falling Body
	GuiControl,%GuiNumber%:, MyListBox,  Fasteners
	GuiControl,%GuiNumber%:, MyListBox,  Fire
	GuiControl,%GuiNumber%:, MyListBox,  Fuel System
	GuiControl,%GuiNumber%:, MyListBox,  Generator
	GuiControl,%GuiNumber%:, MyListBox,  Hydraulics
	GuiControl,%GuiNumber%:, MyListBox,  Implements
	GuiControl,%GuiNumber%:, MyListBox,  Instruction
	GuiControl,%GuiNumber%:, MyListBox,  Lifting
	GuiControl,%GuiNumber%:, MyListBox,  Lubrication System
	GuiControl,%GuiNumber%:, MyListBox,  Machine Operation
	GuiControl,%GuiNumber%:, MyListBox,  Machining
	GuiControl,%GuiNumber%:, MyListBox,  Moving Parts
	GuiControl,%GuiNumber%:, MyListBox,  Operator Cab
	GuiControl,%GuiNumber%:, MyListBox,  Pressure
	GuiControl,%GuiNumber%:, MyListBox,  Spring Force
	GuiControl,%GuiNumber%:, MyListBox,  Steering
	GuiControl,%GuiNumber%:, MyListBox,  Tires
	
	Gui, %GuiNumber%:Show, x%amonx% y%amony% w475 h400, Search for warnings
	return
}


Copytable(Tabletext)
{
	;  x%Amonx% Y%Amony%
	If GuiNumber !=0
	Gui , %GuiNumber%:Destroy
	
	GuiNumber = 6
	Gui , %GuiNumber%:Destroy
	activeMonitorInfo(amonY,AmonX,AmonW,AmonH,mx,my) ;gets the coordinates of the screen where the mouse is located.
	Amonx := amonx + 50
	Amony := amony + 50
	
	Gui, %GuiNumber%:Add, Edit, x5 y30 W265 h190 , %Tabletext%
	Gui, %GuiNumber%:add, Text, x5 y5 ,Please Copy the text below and paste it into Arbortext.
	gui, %GuiNumber%: add, button, w265 h50 xp yp+220 Default  gCopyallguitext, Copy Text
	gui, %GuiNumber%: show, x%amonx% w275 h300, Tablewindow
	sleep 300
	ControlFocus, Copy Text, Tablewindow
	Return
}

Copyallguitext:
{
	winactivate, Tablewindow
	ControlFocus,,Tablewindow
	SEnd ^A
	sleep 100
	Send ^c
	sleep 100
	Tooltip, Textcopied
	Sleep 500
	Tooltip,
	gui 6: destroy 
	return
}

6GuiEscape:
6Guiclose:
{
	gui,6: Destroy
	Return
}


autofillcheckboxsave:
{
gui,%GuiNumber%:Submit, Nohide

GuiControlGet, autocheckbox

If (autocheckbox)
Scrolldown = 1

Else 
scrolldown = 0


GuiControlGet, autocheckbox
IniWrite, %autocheckbox%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Autofull, autocheckbox
Return
}

Howto:
{
	splashtexton,,Arbortext Macro, Loading PDF
	Run, C:\ArbortextMacros\How to use Arbortext Macros.pdf
	sleep 2000
	SplashTextOff
	return
} 

Delete_images:
{
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	Settimer, winmovemsgbox, 50
	Titletext := "Are you sure you want to reset the Cpn Search?"
	Msgbox, 4,,Are you sure you want to reset the Cpn Search?
	
	IfMsgBox no
	{
		Return
	}
	Else IfMsgBox Yes
	{
		dir = C:\ArbortextMacros\UserImages
		FileDelete, %dir%\*.*
		Loop, %dir%\*.*, 2
		FileRemoveDir, %A_LoopFileLongPath%,1
		Settimer, winmovemsgbox, 50
		Titletext := "CPN Autofill is now reset"
		MsgBox, CPN Autofill is now reset
		
		Return
	}
	Return
}

winmovemsgbox:
{
	settimer, winmovemsgbox, off
	ID:=WinExist(Titletext)
	WinMove, ahk_id %ID%, , Amonx, Amony 
	return
}

exitprogram:
{
	exitapp
	return
}


Quickview:
{
	IfWinNotActive, Arbortext Hotkeys
	{
		;Gosub, Settings_Save
		gosub, SetHotKeys
		if guinumber <> 0
		Gui, %guiNumber%:Destroy
		
		SetTimer, Quickview, Off
		return
	}
	Return
}

1GuiEscape:
1guiclose:
{
	;gosu,Settings_save
	;gosub, SetHotKeys
	gui, 1:destroy
	Return
}



2GuiEscape:
2guiclose:
{
	gosub,Settings_save
	gosub, SetHotKeys
	gui, 2:destroy
	Return
}


3GuiEscape:
3guiclose:
{
	gui, 3:destroy
	Return
}

emaillink:
{
	Run,  mailto:Karnia_Jarett_S@cat?Subject=Arbortext Macros
	return
}

boxlink:
{
	Run, https://cat.box.com/s/kbbxsf1ceyf0lo65n6s52if0op0rzok7
	return
}



5guiclose:
{
	Gui 5: destroy
	Return
}

MyListBoxs:
{
	if A_GuiEvent <> DoubleClick
	return
	
	; Otherwise, the user double-clicked a list item, so treat that the same as pressing OK.
	; So fall through to the next label.
	ButtonOK:
	GuiControlGet, MyListBox  ; Retrieve the ListBox's current selection.
	GuiControlGet, Warningsnumbertext
	
	If warningsnumbertext != 
	Mylistbox := warningsnumbertext
	
	; Otherwise, try to launch it:
	Gui,5:Destroy
	+++SetTitleMatchMode, 3
	IfWinExist Search 
	{
		WinActivate Search
		sleep 300
		WinwaitActive, Search,,5
		sleep 500					
		Send {Esc}
		Sleep 500
	}
	+++SetTitleMatchMode, 2				
	WinActivate Arbortext
	sleep 100
	;msgbox No search active
	WinwaitActive, Arbortext,,5
	sleep 500				
	Send {Alt Down}{o}{Alt Up}{e}
	sleep 500
	WinWaitActive, Search,,5
	If ErrorLevel
	{
		Exit
	}else  {
		sleep 500
		Send {Tab}{S}{H}{A}{r}
		sleep 500
		Send {tab}{S}{H}{A}{r}{e}{d}{Space}{w}
		Sleep 500
		Send {tab 2}{right}
		Sleep 500
		Send {tab 8}
		Sleep 500
		Send {c}{a}{t}{Space}{I}{tab}{Enter}
		Sleep 500
		Send {tab 7} 
		Send %MyListBox%
		Sleep 1000
		Send {Enter}
		sleep 500
	}
	return
}


/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== GUI Selection Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/ 
GuiSubmit:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	;GoSub, Settings_save
	gosub, SetHotKeys
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	return
}







CPNRad:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	
	
	If (CpnUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%CPNHotKey%, Off
		Hotkey, $^%CPNHotKey%, Off
		CPNHotKey = *
	}
	If (CpnUN != "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%CPNHotKey%, CPNRapid, on
		Hotkey, $^%CPNHotKey%, CPNRapidautofill, on
	}
	
	
	;If CPN is set to F1
	If (CPNF1 = "1") 
	{
		CPNHotKey := "F1"
		Gosub, SetHotKeys
		Gosub, Settings_Save
		
		IF (METF1Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF1, 0
			METHotKey = *
			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		
		iF (CHKF1Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF1, 0
			CHKotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (SearchF1Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF1, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (TableF1Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF1, 0	
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}}	
	
	;If CPN is set to F2
	If (CPNF2 = "1") 
	{
		CPNHotKey := "F2"
		
		Gosub, SetHotKeys
		Gosub, Settings_Save
		
		
		IF (METF2Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF2, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (CHKF2Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF2, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (SearchF2Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF2, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (TableF2Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF2, 0	
			TableHotKey = *
			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}}	
	
	;If CPN is set to F3
	If (CPNF3 = "1") 
	{
		CPNHotKey = F3
		Gosub, SetHotKeys
		GoSub, Settings_Save
		
		IF (METF3Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF3, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (CHKF3Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF3, 0
			CHKHotKey = *
			GoSub, CPNRad
		}
		iF (SearchF3Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF3, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (TableF3Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF3, 0	
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}}	
	
	;If CPN is set to F4
	If (CPNF4 = "1") 
	{
		CPNHotKey = F4
		Gosub, SetHotKeys
		GoSub, Settings_Save
		
		IF (METF4Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF4, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (CHKF4Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF4, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (SearchF4Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF4, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (TableF4Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF4, 0
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}}	
	
	;If CPN is set to F5
	If (CPNF5 = "1") 
	{
		CPNHotKey = F5
		Gosub, SetHotKeys
		GoSub, Settings_Save
		
		IF (METF5Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF5, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		
		iF (CHKF5Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF5, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (SearchF5Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF5, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}
		iF (TableF5Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF5, 0	
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CPNRad
		}}	
	
	Gosub, Settings_Save
	Gosub, SetHotKeys
	Sleep 100	
	Gosub, Guitab1
	
	Return
}
;===========================================
; For when Metric table is changed =====
;=======================================

METRad:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	If (METUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%METHotKey%, Off
		METHotKey = *
	}
	
	If (METUN != "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%METHotKey%, METRapid, on
	}
	
	
	
	;If Met is set to F1
	If (METF1 = "1") 
	{
		METHotKey = F1
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF1Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF1, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		
		
		iF (CHKF1Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF1, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (SearchF1Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF1, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (TableF1Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF1, 0	
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}}	
	
	;If MET is set to F2
	If (METF2 = "1") 
	{
		METHotKey = F2
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF2Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF2, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (CHKF2Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF2, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (SearchF2Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF2, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (TableF2Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF2, 0	
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}}	
	
	;If MET is set to F3
	If (METF3 = "1") 
	{
		METHotKey = F3
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF3Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF3, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (CHKF3Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF3, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (SearchF3Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF3, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (TableF3Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF3, 0
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}}	
	
	;If MET is set to F4
	If (METF4 = "1") 
	{
		METHotKey = F4
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF4Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF4, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (CHKF4Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF4, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (SearchF4Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF4, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (TableF4Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF4, 0	
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}}	
	
	;If MET is set to F5
	If (METF5 = "1") 
	{
		METHotKey = F5
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF5Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF5, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		
		iF (CHKF5Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF5, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (SearchF5Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF5, 0
			SearchHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}
		iF (TableF5Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF5, 0
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, METRad
		}}	
	
	Gosub, Settings_Save
	Sleep 100
	Gosub, Guitab1
	Return
}

;===========================================
; For when CHECK funciton is changed =====
;=======================================

CHKRad:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	If (CHKUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%CHKHotKey%, Off
		CHKHotKey = *
	}
	
	If (CHKUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%CHKHotKey%, CHKRapid, on
	}
	
	;If CHK is set to F1
	If (CHKF1 = "1") 
	{
		CHKHotKey = F1
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF1Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF1, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		
		iF (METF1Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF1, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		
		
		
		iF (SearchF1Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF1, 0
			SearchHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		
		iF (TableF1Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF1, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}}	
	
	;If CHK is set to F2
	If (CHKF2 = "1") 
	{
		CHKHotKey = F2
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF2Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF2, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (METF2Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF2, 0
			METHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}	
		
		iF (SearchF2Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF2, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (TableF2Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF2, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}}	
	
	;If CHK is set to F3
	If (CHKF3 = "1") 
	{
		CHKHotKey = F3
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF CPNTF3Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF3, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (METF3Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF3, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}	
		
		iF (SearchF3Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF3, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (TableF3Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF3, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}}	
	
	;If CHK is set to F4
	If (CHKF4 = "1") 
	{
		CHKHotKey = F4
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF4Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF4, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (METF4Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF4, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}	
		
		iF (SearchF4Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF4, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (TableF4Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF4, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}}	
	
	;If CHK is set to F5
	If (CHKF5 = "1") 
	{
		CHKHotKey = F5
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF5Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF5, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (METF5Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF5, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}	
		
		
		iF (SearchF5Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF5, 0
			SearchHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}
		iF (TableF5Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF5, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, CHKRad
		}}	
	
	
	Gosub, Settings_Save
	Gosub, SetHotKeys
	Sleep 100	
	Gosub, Guitab1
	Return
}

;=========================================================
;========== fOR WHEN THE SEARCH FUNCTION IS CHANGED=======
;===========================================================

SearchRad:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	
	If (SearchUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%SearchHotKey%, Off
		
		HotKey, IfWinActive, Canvas Service AHK_class TTAFrameXClass ; this hotkey only works in the cavas service window
		Hotkey, $%SearchHotKey%, Off
		Hotkey, IfWinActive,  Canvas 14 AHK_class TTAFrameXClass ; this hotkey only works in Canvas 14 for windchill
		Hotkey, $%SearchHotKey%, Off
		
		+++SetTitleMatchMode, 3
		Hotkey, IfWinActive, Search ; hotkey only works in search window
		Hotkey, $%SearchHotKey%, Off
		
		SearchHotKey = *
		+++SetTitleMatchMode,2
	}
	
	
	If (SearchUN != "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		
		HotKey, IfWinActive, Canvas Service AHK_class TTAFrameXClass ; this hotkey only works in the cavas service window
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		Hotkey, IfWinActive,  Canvas 14 AHK_class TTAFrameXClass ; this hotkey only works in Canvas 14 for windchill
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		Hotkey, IfWinActive, Search ; hotkey only works in search window
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
	}
	
	;If Search is set to F1
	If (SearchF1 = "1") 
	{
		SearchHotKey = F1
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF1Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF1, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		
		iF (METF1Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF1, 0
			METHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		
		
		iF (CHKF1Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF1, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		
		iF (TableF1Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF1, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}}	
	
	;If Search is set to F2
	If (SearchF2 = "1") 
	{
		SearchHotKey = F2
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF2Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF2, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (METF2Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF2, 0
			METHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}	
		
		iF (CHKF2Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF2, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (TableF2Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF2, 0
			TableHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}}	
	
	;If Search is set to F3
	If (SearchF3 = "1") 
	{
		SearchHotKey = F3
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF CPNTF3Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF3, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (METF3Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF3, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}	
		
		iF (CHKF3Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, SearchF3, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (TableF3Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF3, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}}	
	
	;If Search is set to F4
	If (SearchF4 = "1") 
	{
		SearchHotKey = F4
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF4Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF4, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (METF4Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF4, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}	
		
		IF (CHKF4Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF4, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		
		iF (TableF4Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF4, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}}	
	
	;If Search is set to F5
	If (SearchF5 = "1") 
	{
		SearchHotKey = F5
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF5Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF5, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		iF (METF5Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF5, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}	
		
		IF (CHKF5Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF5, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}
		
		iF (TableF5Status = "1")
		{
			GuiControl,, TableUN, 1
			GuiControl,, TableF5, 0
			TableHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, SearchRad
		}}	
	
	
	Gosub, Settings_Save
	Gosub, SetHotKeys
	Sleep 100	
	Gosub, Guitab1
	Return
}
;=============================================
;====FOR WHEN THE TABLE HOTKEY IS CHANGED ====
;=============================================

TableRad:
{
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	
	If (TableUN = "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%TableHotKey%, Off
		;Hotkey, $^%TableHotKey%, Off
		;Hotkey, $+^%TableHotKey%, Off
		;Hotkey, $#^%TableHotKey%, Off
		TableHotKey = *
	}
	
	If (TableUN != "1")
	{
		HOTKEY, IfWinActive, Arbortext ; these hotkeys work only in Arbortext
		Hotkey, $%TableHotKey%, TableRapid, on
		;Hotkey, $^%TableHotKey%, TableRapidpgwd, on
		;Hotkey, $+^%TableHotKey%, TableRapidENG, on
		;Hotkey, $#^%TableHotKey%, TableVSP,on
	}
	
	;If Table is set to F1
	If (TableF1 = "1") 
	{
		TableHotKey = F1
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF1Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF1, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		
		iF (METF1Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF1, 0
			METHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		
		
		
		iF (CHKF1Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF1, 0
			CHKHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		
		iF (SearchF1Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF1, 0
			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}}	
	
	;If Table is set to F2
	If (TableF2 = "1") 
	{
		TableHotKey = F2
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF2Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF2, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (METF2Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF2, 0
			METHotKey = *			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}	
		
		iF (CHKF2Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF2, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (SearchF2Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF2, 0			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}}	
	
	;If Table is set to F3
	If (TableF3 = "1") 
	{
		TableHotKey = F3
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF CPNTF3Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF3, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (METF3Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF3, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}	
		
		iF (CHKF3Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF3, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (SearchF3Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF3, 0			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}}	
	
	;If Table is set to F4
	If (TableF4 = "1") 
	{
		TableHotKey = F4
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF4Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF4, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (METF4Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF4, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}	
		
		iF (CHKF4Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF4, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		
		iF (SearchF4Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF4, 0
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (SearchF4Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF4, 0			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}}	
	
	;If Table is set to F5
	If (TableF5 = "1") 
	{
		SearchHotKey = F5
		Gosub, SetHotKeys
		Gosub, Settings_Save
		IF (CPNF5Status = "1")
		{
			GuiControl,, CPNUN, 1
			GuiControl,, CPNF5, 0
			CPNHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (METF5Status = "1")
		{
			GuiControl,, METUN, 1
			GuiControl,, METF5, 0
			METHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}	
		
		iF (CHKF5Status = "1")
		{
			GuiControl,, CHKUN, 1
			GuiControl,, CHKF5, 0
			CHKHotKey = *
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}
		iF (SearchF5Status = "1")
		{
			GuiControl,, SearchUN, 1
			GuiControl,, SearchF5, 0			
			Gosub, Settings_Save
			Sleep 100
			
			GoSub, TableRad
		}}	
	Gosub, Settings_Save
	Gosub, SetHotKeys
	Sleep 100	
	Gosub, Guitab1
	Return
}

Guitab1:
{
	GuiControl,,CPNgui, %CPNHotKey%
	GuiControl,,METgui, %METHotKey%
	GuiControl,,CHKgui, %CHKHotKey%
	GuiControl,,Searchgui, %SearchHotKey%
	GuiControl,,Tablegui, %TableHotKey%
	GuiControl,Text,CtrlTablegui, Ctrl + %TableHotKey%
	GuiControl,Text,CtrlhiftTablegui, Ctrl + Shift + %TableHotKey%
	GuiControl,Text,CtrlCPNgui, Ctrl + %CPNHotKey%
	GuiControl,Text,canvassearchoptions, Canvas Search Options For (%SearchHotKey%) Hotkey
	return
}

GuiTab2:
{
	Gosub, CPNRad
	Gosub, METRad
	Gosub, CHKRad
	Gosub, TableRad
	Gosub, SearchRad
	Return
}

QuitApp:
{
	ExitApp
	Return
}

SetOPtions:
{
	GOsub, Load_Settings
	
	loopcounting = 0
	Loop,4
	{
		loopcounting++
		If CPNF1 = 1
		GuiControl,, CPNF1, 1
	}
	If CPNUN = 1
	GuiControl,, CPNUN, 1
	
	loopcounting = 0
	
	Loop,4
	{
		loopcounting++
		If METF%loopcounting% = 1
		GuiControl,, METF%loopcounting%, 1
	}
	If METUN = 1
	GuiControl,, METUN, 1
	
	loopcounting = 0
	Loop,4
	{
		loopcounting++
		If SearchF%loopcounting% = 1
		GuiControl,, SearchF%loopcounting%, 1
	}
	If SearchUN = 1
	GuiControl,, SearchUN, 1
	
	loopcounting = 0
	Loop,4
	{
		loopcounting++
		If TableF%loopcounting% = 1
		GuiControl,, TableF%loopcounting%, 1
	}
	If TableUN = 1
	GuiControl,, TableUN, 1

	if autocheckbox = 1
	;Autocheckckeck = 1
	Guicontrol,,autocheckbox,1
	
	Gui,submit, nohide

	return
}              