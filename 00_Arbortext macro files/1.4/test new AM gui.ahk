#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
checkvars = CPN,MET,CHK,Search,Table

Optionsmenu:
{
	GuiWIdth = 824 
	GuiHeight = 430
	;gosub, Load_Settings
	GuiNumber = 2
	;activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	
	
	sleep 200
	
	;Settimer, Quickview, 2000
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
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF1Status% xp-150 yp+20 w15 h20 vCpn gCPNRad  ,CPNF1
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF2Status% xp+30 yp w15 h20  gCPNRad,CPNF2
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF3Status% xp+30 yp w15 h20   gCPNRad, CPNF3
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF4Status% xp+30 yp w15 h20   gCPNRad, CPNF4
	Gui, %GuiNumber%:Add, Radio, Checked%CPNF5Status% xp+30 yp w15 h20  gCPNRad, CPNF5
	Gui, %GuiNumber%:Add, Radio, Checked%CPNUNStatus% xp+50 yp w15 h20   gCPNRad, CPNUN
	
	; Metric to English Table Gui Options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h40 , Units Group tag and Conversion window(Click or click and hold in tag)
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%METF1Status% xp-150 yp+20 w15 h20 vMET gCPNRad  ,METF1
	Gui, %GuiNumber%:Add, Radio, Checked%METF2Status% xp+30 yp w15 h20   gCPNRad ,METF2
	Gui, %GuiNumber%:Add, Radio, Checked%METF3Status% xp+30 yp w15 h20   gCPNRad , METF3
	Gui, %GuiNumber%:Add, Radio, Checked%METF4Status% xp+30 yp w15 h20  gCPNRad , METF4
	Gui, %GuiNumber%:Add, Radio, Checked%METF5Status% xp+30 yp w15 h20   gCPNRad , METF5
	Gui, %GuiNumber%:Add, Radio, Checked%METUNStatus% xp+50 yp w15 h20  gCPNRad, METUN
	
	; Check in - check out - validate GUI options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h30 , Check in- Check out - Validate
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF1Status% xp-150 yp+20 w15 h20 vCHK gCPNRad ,CHKF1
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF2Status% xp+30 yp w15 h20   gCPNRad ,CHKF2
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF3Status% xp+30 yp w15 h20   gCPNRad,CHKF3
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF4Status% xp+30 yp w15 h20  gCPNRad, CHKF4
	Gui, %GuiNumber%:Add, Radio, Checked%CHKF5Status% xp+30 yp w15 h20  gCPNRad , CHKF5
	Gui, %GuiNumber%:Add, Radio, Checked%CHKUNStatus% xp+50 yp w15 h20   gCPNRad,CHKUN
	
	;Search function Gui Options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10 yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w100 h30 , Graphic Search
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF1Status% xp-150 yp+20 w15 h20 vSearch gCPNRad ,SearchF1
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF2Status% xp+30 yp w15 h20  gCPNRad ,SearchF2
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF3Status% xp+30 yp w15 h20  gCPNRad , SearchF3
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF4Status% xp+30 yp w15 h20  gCPNRad , SearchF4
	Gui, %GuiNumber%:Add, Radio, Checked%SearchF5Status% xp+30 yp w15 h20  gCPNRad , SearchF5
	Gui, %GuiNumber%:Add, Radio, Checked%SearchUNStatus% xp+50 yp w15 h20  gCPNRad ,SearchUN
	
	; Tables Gui options
	
	Gui, %GuiNumber%:Add, Groupbox, xs+10  yp+35 w470 h60
	Gui, %GuiNumber%:Add, Text, xp+40 yp+15 w160 h30 , Tables (Col wide - Pg Wide - Eng Troubleshooting - VSP)
	Gui, %GuiNumber%:Add, Text, xp+182 yp w20 h20 , F1
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F2 
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F3
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F4
	Gui, %GuiNumber%:Add, Text, xp+30 yp w20 h20 , F5
	Gui, %GuiNumber%:Add, Text, xp+30 yp w55 h20 , Unassigned
	Gui, %GuiNumber%:Add, Radio, Checked%TableF1Status% xp-150 yp+20 w15 h20 VTable gCPNRad ,TableF1
	Gui, %GuiNumber%:Add, Radio, Checked%TableF2Status% xp+30 yp w15 h20   gCPNRad ,TableF2
	Gui, %GuiNumber%:Add, Radio, Checked%TableF3Status% xp+30 yp w15 h20  gCPNRad  , TableF3
	Gui, %GuiNumber%:Add, Radio, Checked%TableF4Status% xp+30 yp w15 h20   gCPNRad , TableF4
	Gui, %GuiNumber%:Add, Radio, Checked%TableF5Status% xp+30 yp w15 h20  gCPNRad,TableF5
	Gui, %GuiNumber%:Add, Radio, Checked%TableUNStatus% xp+50 yp w15 h20   gCPNRad ,TableUN
	Gui, %GuiNumber%:Add, Button, xs+10 yp+30 w60 h60 h30 , Default Settings
	Gui, %GuiNumber%:Add, Button, xp+100 yp w60 h60 h30 , Save Settings
	Gui, %GuiNumber%:Add, Button, xp+290 yp w60 w75 h30 , Reset CPN Autofill Search
	
	
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
	Gui, %GuiNumber%:Add, Checkbox, checked%autocheckbox% xp+10 yp+20 vautocheckbox, Autoscroll down for CPN fill (ESC Key stops Autoscrolling)
	Gosub, SetOPtions
	gui,%GuiNumber%:submit, nohide
	;Gui, %GuiNumber%:Add, Picture, x0 y0 w%GuiWIdth% h%GuiHeight% +0x4000000, %GuiBackground%
	Gui,%GuiNumber%:Show,  w%GuiWIdth% h%GuiHeight%, Arbortext Hotkeys V%Version_Number%
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

	return
}




CPNRad:
{

	Loop, parse, checkvars,`,
{	
	OldValue%A_loopfield% :=  A_loopfield  %A_loopfield%
}

	gui,Submit,NoHide

	Loop, parse, checkvars,`,
{	
	NAme := A_LoopField %A_loopField%
	newValue%A_loopField% := A_LoopField  %A_loopfield%

	If  (Oldvalue%A_LoopField% = newValue%A_loopField%)
		continue
	else	{
			Changedvalue := A_LoopField
			Key := %A_LoopField%
		break
			}
}

;~ MsgBox,  changed value is %Changedvalue% `n`n Key is %Key%
Checkhotkey(Changedvalue,Key,checkvars)

gui,Submit,NoHide
return

}


Checkhotkey(Type,Key,checkvars)
{

	Loop, parse, checkvars,`,
{
	
	;~ MsgBox, test is %test% `n`n Type is %Type%
Test := %A_LoopField%
;~ MsgBox, Test is %Test% Loopfield is %A_LoopField%
;~ If  (Type = A_LoopField)
;~ continue
If  (Key = Test)  && if  (Type != A_LoopField)
{	
GuiControl,,%a_loopfield%UN, 1
%a_loopfield%Hotkey := "*"
}}
return
}


2GuiClose:
{
	ExitApp
	return
	
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


QuitApp:
{
	ExitApp
	Return
}

SetOPtions:
{
	;GOsub, Load_Settings
	
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
		
Default_settings:
{
msgbox, default settings
return
}
Settings_save:
{
msgbox, save settings
return
}

#`::
{
	ListLines
	ListVars
return

}