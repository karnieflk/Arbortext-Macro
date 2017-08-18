Updatechecker:
{
	;below is just in case the ini file isnt there. it makes a new one
	if not (FileExist("C:\ArbortextMacros\ArbortextMacroSettings.ini"))
	{
		FileAppend,, C:\ArbortextMacros\ArbortextMacroSettings.ini
		activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
		Amonh /=2
		amonw /=2
		amonx := amonx + (amonw/2)
		amony := amony + (amonh/2)
		Settimer, winmovemsgbox, 50
		Titletext := "Looks like This may be the first time running this application. Do you want to check for an update"
		Msgbox,4,%A_Space%Arbortext Macro Updater, %A_Space%Looks like This may be the first time running this application. Do you want to check for an update?
		ifmsgbox Yes
		{
			gosub, Versioncheck
		}else  {
			IniWrite, 14,  C:\ArbortextMacros\ArbortextMacroSettings.ini,update,updaterate
		}}
	
	;if file does exist, then it reads the ini file for the last update check and how often it plans to update.
	if (FileExist("C:\ArbortextMacros\ArbortextMacroSettings.ini"))
	{
		IniRead, updatestatus, C:\ArbortextMacros\ArbortextMacroSettings.ini, update,lastupdate
		IniRead, Updaterate, C:\ArbortextMacros\ArbortextMacroSettings.ini, update,updaterate
		
		NumberOfDays := %A_Now%		; Set to the current date first
		EnvSub, NumberOfDays, %INIDate% , Days 	; this does a date calc, in days
		If NumberOfDays > %Updaterate% )	; More than 14 days
		{
			activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
			Amonh /=2
			amonw /=2
			amonx := amonx + (amonw/2)
			amony := amony + (amonh/2)
			Settimer, winmovemsgbox, 50
			Titletext := "days since the last update check.`n`n Would you like to check for a new update"
			MsgBox,4,%A_Space%Arbortext Macro Updater, It has been %NumberOfDays% days since the last update check.`n`n Would you like to check for a new update?`n`n
			ifmsgbox Yes	
			gosub, Versioncheck
			else
				IniWrite, 14,  C:\ArbortextMacros\ArbortextMacroSettings.ini,update,updaterate
		}}
	
	Return
}

Versioncheck:
{
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2
	amonw /=2
	amonx := amonx + (amonw/2)
	amony := amony + (amonh/2)
	Settimer, winmovemsgbox, 50
	Titletext := "Arbortext Macro Updater"
	Cliptemp = %clipboardall% ; sets the clipboard to a temp variable
	Clipboard = "%A_space%"  ; makes the clipboard a space, so it is emptied
	Progress,  w200, Updating..., Gathering Information, Arbortext Macro Updater ; creates a progress bar with text
	Progress, 0 ; sets the progress bar to 0 percent
	sleep 200 ; pauses the script for 200 miliseconds
	Versioncount = 0 ; makes the versioncount variable to 0
	settimer, versiontimeout, 2000 ; starts a timer that goes to versiontimeout every 2 second
	gosub, create_checkgui ; goes to create_checkgui to create the invisible IE browser
	Settimer, winmovemsgbox, 50
	Progress,  w200, Updating..., Fetching Server Information, Arbortext Macro Updater ; sets the progress bar text
	Progress, 15 ; makes the progress bar at 15%
	DllCall("SetParent", "uint",  hwnd, "uint", ParentGUI) ; calls some built computer functions
	wb.Visible := True  ;makes the webroowser that was created visable in the gui screen that is off the monitor screen
	WinSet, Style, -0xC00000, ahk_id %hwnd% ; makes the gui transparent
	Settimer, winmovemsgbox, 50
	Progress, 25 ; sets progress bar to 25%
	sleep 200 ; pauses the script for 200 miliseconds
	
	wb.navigate("https://docs.google.com/document/d/1RmxRdQ5NrkcYHEajabMcy6sGD19u-6qwLNbG79Fkrvg/edit?usp=sharing") ; makes the webbrowser in the gui navigate to the google docs page that has the updates in it
	Settimer, winmovemsgbox, 50
	Progress,  w200, Updating...,Gathering Current Version From Server, Arbortext Macro Updater ; changes the progress bar text
	Progress, 50 ; sets the progress bar to 50%
	
	Sleep, 200 ; script sleeps 200 miliseconds
	
	while wb.busy ; wile the browser loads the webpage, it loops until the site is loaded
	{
		Sleep 100
	}
	
	Settimer, winmovemsgbox, 50
	Progress,  w200,Updating..., Comparing Version Information, Arbortext Macro Updater ; changes the progress bar
	Progress, 60 ; makes the progress bar to 60%
	sleep 1000
	Winactivate, Arbortext Macro Version ; this is the title of the tab in the browser, so it activates it to the front window
	wingettitle, titleup, A ; gets the actual title with the version number
	;Msgbox, Title is  %title%  ; for diagnostics
	StringGetPos, pos, Titleup, #, 1	 ; gets the position of the # symbol in the title
	String1 := SubStr(Titleup, pos+2) ; deletes everything in the title from the # symobl and whats in front of it
	;msgbox, %string1% ;for diagnostics
	
	Checkversion := SubStr(String1,1,3) ; deletes what is after the numerical version
	;msgbox, %Checkversion% ; for diagnostics
	;Progress, Off ; turns off the progress bar as everything is found
	
	;below is there just in case the macro goes faster than the browser in the gui window, it tries to get the tab title again if it came up blank
	If titleup = 
	{
		Winactivate, Arbortext Macro Version
		sleep 1500
		wingettitle, titleup, A
		StringGetPos, pos, Titleup, #, 1	
		String1 := SubStr(Titleup, pos+2)
		Checkversion := SubStr(String1,1,3) ; deletes what is after the numerical version
	}
	;if that try above failed, the macro cancels out of the update check.
	If titleup = 
	{
		Settimer, winmovemsgbox, 50
		Progress,  w200,Updating..., Error Occured. Update Not Able To Complete, Arbortext Macro Updater
		Progress, 0
		Sleep 3000
		Progress, off
		SplashTextOff
		msgbox, Error getting update. PLease try again later.
		Settimer, versiontimeout, off
	}
	;msgbox, %Checkversion%
	Progress, off
	;if the version online is found to be equal to the version number at the top of the arbortext macros vx.x sctipr
	If Version_Number >= %checkversion%
	{
		Settimer, winmovemsgbox, 50
		Progress,  w200,Updating..., Macro is Up to date., Arbortext Macro Updater
		Progress, 100
		Sleep 3000
		Progress, off
		SplashTextOff
		Settimer, versiontimeout, off
		IniWrite, %A_now%,  C:\ArbortextMacros\ArbortextMacroSettings.ini,  update,lastupdate
		IniWrite, 14,  C:\ArbortextMacros\ArbortextMacroSettings.ini,update,updaterate	
		clipboard = %cliptemp%
	}
	
	; if the version online is geater than the macro version, it will ask to go to the box site to update.
	If Checkversion > %Version_Number%
	{
		Settimer, versiontimeout, off
		Progress, off
		SplashTextOff
		Settimer, winmovemsgbox, 50
		msgbox,262148,Arbortext Macro Updater, New update found. Would you like to open the Cat Box site to download the latest version?
		IfMsgBox, yes 
		{
			gui 4:destroy
			IniWrite, 14,  C:\ArbortextMacros\ArbortextMacroSettings.ini,update,updaterate		
			IniWrite, %A_now%,   C:\ArbortextMacros\ArbortextMacroSettings.inii,  update,lastupdate
			Run, https://cat.box.com/s/kbbxsf1ceyf0lo65n6s52if0op0rzok7
		}
		Else
			gui 4:destroy
		Sleep 500
		IniWrite, 14,  C:\ArbortextMacros\ArbortextMacroSettings.ini,update,updaterate	
		IniWrite, %A_now%,  C:\ArbortextMacros\ArbortextMacroSettings.ini,  update,lastupdate
		
		return
	}
	Gui 4:destroy
	;msgbox, done
	Settimer, versiontimeout, off
	clipboard := ""
	clipboard = %cliptemp%
	return
}


versiontimeout:
{
	Versioncount++
	If Versioncount = 10
	{
		Settimer, winmovemsgbox, 50
		Progress,  w200,Updating..., Error Occured.Cannot connect to server for update check, please check for internet connection., Arbortext Macro Updater
		Progress, 0
		Sleep 2000
		Progress, Off
		SplashTextOff
		Settimer, versiontimeout, off
		;Msgbox,,Serial Updater Timed out, Cannot connect to server for update check, please check for internet connection.
	}
	;clipboard := ""
	;clipboard = %cliptemp%
	Return
}


create_checkgui:
{
	wb := ComObjCreate("InternetExplorer.Application")
	Wb.AddressBar := false
	wb.MenuBar := false
	wb.ToolBar := false
	wb.StatusBar := false
	wb.Resizable := false
	wb.Width := 10
	wb.Height := 10
	wb.Top := 0
	wb.Left := 0
	wb.Silent := true
	hwnd := wb.hwnd
	Gui, 4:+LastFound
	ParentGUI := WinExist()
	Gui,4:-SysMenu -ToolWindow -Border
	Gui,4:Color, EEAA99                                 
	Gui,4:+LastFound                                     
	WinSet, TransColor, EEAA99  
	gui 4: +ToolWindow                   
	Gui,4:show, x0 y-11 W1 H1  , Updater
	
	return
}              