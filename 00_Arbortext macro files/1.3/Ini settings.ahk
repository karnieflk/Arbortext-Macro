Settings_save:
{
	if not (FileExist("C:\ArbortextMacros\ArbortextMacroSettings.ini")) ; if ini file isnt there it makes one
	{
		FileAppend,, C:\ArbortextMacros\ArbortextMacroSettings.ini
		Firstrun = 1
		Sleep 1000
		GOsub, Default_Settings
	}
	Gui, 1:Submit, Nohide ;so the options and hotkey gui screen updates
	Gui, 2:Submit, Nohide
	
	;Checking what hotkeys that is enabled/disabled, and store it into variables
	IniWrite, %CpnEnable%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, CpnEnable
	IniWrite, %METEnable%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, METEnable
	IniWrite, %CHKEnable%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, CHKEnable
	IniWrite, %SearchEnable%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, SearchEnable
	IniWrite, %TableEnable%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, TableEnable
	
	;Writes the Status of the CPN Radio buttons
	IniWrite, %CPNF1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF1
	IniWrite, %CPNF2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF2
	IniWrite, %CPNF3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF3
	IniWrite, %CPNF4%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF4
	IniWrite, %CPNF5%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF5
	IniWrite, %CPNUN%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNUN
	
	
	;Writes the Status of the Metric to English Table
	IniWrite, %METF1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF1
	IniWrite, %METF2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF2
	IniWrite, %METF3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF3
	IniWrite, %METF4%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF4
	IniWrite, %METF5%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF5
	IniWrite, %METUN%, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METUN
	
	
	;Writes the Status of the Check in /out/validate menu
	IniWrite, %CHKF1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF1
	IniWrite, %CHKF2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF2
	IniWrite, %CHKF3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF3
	IniWrite, %CHKF4%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF4
	IniWrite, %CHKF5%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF5
	IniWrite, %CHKUN%, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKUN
	
	;Writes the Status of the Search window hotkey
	IniWrite, %SearchF1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF1
	IniWrite, %SearchF2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF2
	IniWrite, %SearchF3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF3
	IniWrite, %SearchF4%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF4
	IniWrite, %SearchF5%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF5
	IniWrite, %SearchUN%, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchUN
	
	;Writes the Status of the Table  hotkey
	IniWrite, %TableF1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF1
	IniWrite, %TableF2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF2
	IniWrite, %TableF3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF3
	IniWrite, %TableF4%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF4
	IniWrite, %TableF5%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF5
	IniWrite, %TableUN%, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableUN
	
	;Writes the status of the userhotkeys
	IniWrite, %CPNHotKey%, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, CPNHotKey
	IniWrite, %METHotKey%, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, METHotKey
	IniWrite, %CHKHotKey%, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, CHKHotKey
	IniWrite, %SearchHotKey%, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, SearchHotKey
	IniWrite, %TableHotKey%, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, TableHotKey
	
	;Writes teh canvase service screen options
	IniWrite, %Section1%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section1
	IniWrite, %Section2%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section2
	IniWrite, %Section3%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section3
	
	IniWrite, %autocheckbox%, C:\ArbortextMacros\ArbortextMacroSettings.ini, Autofull, autocheckbox
	
	GoSub, Load_Settings
	Gosub, SetHotKeys
	
	
	
	return
}
/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Loads INI File Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/

Load_Settings:
{
	;Loads checkbox status
	IniRead, CPNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, CPNEnable
	IniRead, MetStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, METEnable
	IniRead, CHKStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, CHKEnable
	IniRead, SearchStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, SearchEnable
	IniRead, TableStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, Hotkeys, TableEnable
	
	;Loads CPN Radio button status
	IniRead, CPNf1Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF1
	IniRead, CPNf2Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF2
	IniRead, CPNf3Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF3
	IniRead, CPNf4Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF4
	IniRead, CPNf5Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNF5
	IniRead, CPNUNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, CPNRadio, CPNUN
	
	;Loads Metric to Eng Radio button status
	IniRead, METf1Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF1
	IniRead, METf2Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF2
	IniRead, METf3Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF3
	IniRead, METf4Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF4
	IniRead, METf5Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METF5
	IniRead, METUNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, METRadio, METUN
	
	;Loads CHK Radio button status
	IniRead, CHKf1Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF1
	IniRead, CHKf2Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF2
	IniRead, CHKf3Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF3
	IniRead, CHKf4Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF4
	IniRead, CHKf5Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKF5
	IniRead, CHKUNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, CHKRadio, CHKUN
	
	;Loads Search Radio button status
	IniRead, Searchf1Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF1
	IniRead, Searchf2Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF2
	IniRead, Searchf3Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF3
	IniRead, Searchf4Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF4
	IniRead, Searchf5Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchF5
	IniRead, SearchUNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, SearchRadio, SearchUN
	
	
	;Loads Table Radio button status
	IniRead, Tablef1Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF1
	IniRead, Tablef2Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF2
	IniRead, Tablef3Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF3
	IniRead, Tablef4Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF4
	IniRead, Tablef5Status, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableF5
	IniRead, TableUNStatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, TableRadio, TableUN
	
	; Loads the hotkey variables
	
	IniRead, CPNHotKey, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, CPNHotKey
	IniRead, METHotKey, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, METHotKey
	IniRead, CHKHotKey, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, CHKHotKey
	IniRead, SearchHotKey, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, SearchHotKey
	IniRead, TableHotKey, C:\ArbortextMacros\ArbortextMacroSettings.ini, DeclareHotKey, TableHotKey
	
	; Loads the canvas section variables
	IniRead, Section1, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section1
	IniRead, Section2, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section2
	IniRead, Section3, C:\ArbortextMacros\ArbortextMacroSettings.ini, Canvas, Section3
	
	IniRead, autocheckbox, C:\ArbortextMacros\ArbortextMacroSettings.ini, Autofull, autocheckbox
	return
}


/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Defauklt Settings ection ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/
Default_Settings: ; sets the settings to the default ones
{
	SetTimer, Quickview, Off
	if not (FileExist("C:\ArbortextMacros\ArbortextMacroSettings.ini"))
	{
		FileAppend,, C:\ArbortextMacros\ArbortextMacroSettings.ini
		Firstrun = 1
	}
	Gui, 1:Submit, Nohide
	Gui, 2:Submit, Nohide
	If Firstrun <> 1
	{
		activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
		Amonh /=2
		amonw /=2
		amonx := amonx + (amonw/2)
		amony := amony + (amonh/2)
		Settimer, winmovemsgbox, 50
		Titletext := "Are you sure you want to set the hotkeys to their default values"
		Msgbox,4,, Are you sure you want to set the hotkeys to their default values?
		IfMsgbox no
		return
	}
	GuiControl,, CPNF1, 1 ; this sets the radio buttons
	GuiControl,, METF2, 1
	GuiControl,, CHKF3, 1
	GuiControl,, SearchF4, 1
	GuiControl,, TableF5, 1
	
	CPNHotKey = F1
	METHotKey = F2
	CHKHotKey = F3
	SearchHotKey = F4
	TableHotKey = F5
	Section1 = 72A
	Section2 = 72a
	Section3 = 72a
	autocheckbox = 0
	GoSub, Guitab1
	
	Gosub, Settings_Save
	Sleep 100
	Sleep 100
	SetTimer, Quickview, 1000
	
	
	
	
	return
}              