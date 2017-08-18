﻿/*
*****************************************************************************************************************************************************************************
*********************************************************************** Licensing Information *******************************************************************************
*****************************************************************************************************************************************************************************
*/

;Unless otherwise stated, All content of this script was created by Jarett Karnia for the use of Caterpillar, Inc
;This script Can be used and modified as needed. But Must give credit to Orginal creaters of the content (including the libraries) and state what was changed from the orginal source code.

/*
////////////////////////////////////////////////////////
Enhancements to do//////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////



*/

/*
Updates to script from Version 1.2
***************************************
Tables is now different
removed background images


/*
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== AutoLoad Section for startup ====== =\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; allows only one instance of this program to be open at a time
DetectHiddenWindows, On ; Used to help find windows that that are minimized or hidden
DetectHiddenText, on ; used to find the text on thoe minimized or hidden windows
#KeyHistory 0 ; no key history to help improve performance since we dont need to see that the user pressed
SetBatchLines, -1 ; to speed up script 
;SetKeyDelay, -1, -1, Play ; to speed up script
SetMouseDelay, -1 ; to speed up script mouse movements
SetDefaultMouseSpeed, 0 ; makes mouse instant
;SetWinDelay, 0 ; makes window functions instant
;SetControlDelay, 0 ; speeds up script


Version_Number := "1.3" ;Version number to use for update checks

; The below code checks if user hit esc and restarted the macro. If they did, then the start splash screen does NOT show. IF they didn't then the start splash screen will show.
;This needs to be in the location becuase it checks the text in the command line, before anything else loads. It will not work if placed in another part of the script.
CmdLine := DllCall("GetCommandLine", "Str")
if !RegExMatch(CmdLine, "\/Restart")
{
	Reload = 0
	activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
	Amonh /=2 ; divides this var by 2
	amonw /=2 ; divides this var by 2
	;amonx := amonx + (amonw/2) ;Math the throw the variable about halfway on the screen
	;amony := amony + (amonh/2) ; ;Math the throw the variable about halfway on the screen
	
	SplashImage, C:\ArbortextMacros\ProgramImages\SplashinmageAM.png, B x0 y0 300 W500,,,Titlescreen ; places the splashimage in the middle of the active monitor
	;MsgBox, % CmdLine ; Message will not be shown if script was passed "/restart" in its command line parameters
	sleep 1000
}else  {
	Reload = 1
}


if !RegExMatch(CmdLine, "\/cpn")
{
	
}else  {
	Tooltip, loading CPN autofind information
}

#include StartupCheck.ahk ; adds startupcheck.ahk
Listlines, off ; turns off debug lines
#include Gdip.ahk ; adds Gip.ahk lib
#include RapidHotKey.ahk ; adds rapidhotkey.ahk lib
Listlines, on ; turns on debug lines



Onexit,  Quitting ; when the program restarts or exits, the script will run this subroutine



; Below are the global variables that work everywhere
Global CPNHotkey, METHotkey, CHKHotkey, SearchHotkey, TableHotkey, section1, section2, section3, guinumber , Tabletype, Pgwd, Userrows, NewwordGUi ; these are all global variables


Ptoken = 0 ; sets the Ptoken variable to 0. 
guinumber = 0 ; set this variable to 0
SkipUnitstag = 0 ; Sets teh variable to 0
canvascount = 0

Menu, Tray, noStandard ; removes the diag menu info from the tray icon



;below checks for the settings text document, if it not there, it makes one
if not (FileExist("C:\ArbortextMacros\ArbortextMacroSettings.ini"))
{
	FileAppend,, C:\ArbortextMacros\ArbortextMacroSettings.ini
	Firstrun = 1
	Gosub, Default_Settings
}


CreateMenu()  ; goes to Createmenu function
sleep 500 ;sets a .5 sec delay
Gosub, Load_Settings ; Loads Ini file settings
sleep 500 ;sets a .5 sec delay
Gosub, SetHotKeys ;Set hotkeys from ini file settings
sleep 500 ;sets a .5 sec delay
GOsub, Updatechecker ; goes to updatechecker:

SplashImage,Off ; turns off the loading image


; This is here if the app restart was from the start of a autofill CPN search
if !RegExMatch(CmdLine, "\/cpn") 
{
	
}else  {
	Tooltip
	gosub, CPNRapidautofill
}


; This section below is here to stop a bug that allowed many.. and I mean many instances of the program to be active.. IT finds the others and kills the process
PID:=DllCall("GetCurrentProcessId") ; Gets this programs Process ID 
for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where name = 'Arbortext macros.exe' and processID  <> " PID ) ; Loop to look for all the "Arbortext Macros.exe" programs in the process tree that isnt the current one. 
process, close, % process.ProcessId ; kills the process (closed the program)


Return ; this stops the script so that is does not continue automatically



/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Subroutine \ Label section for main script functions ====== /=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/


/*
**************************************************************************************************************************************************************************************************************
This section is here as I slowly make variables that work with the rest of the script for common tasks, this way if something changes, you only have to change one thing and the affected areas are corrected
***************************************************************************************************************************************************************************************************************
*/

CPNSingleSearch: ; Send the keys to get a single CPN search (ALT + C, then enter twice)
{
	Send {Alt Down}{c}{Alt Up}{Enter 2}
	Return
}

CpnPluralSearch: ; Sends the keys to get a plural CPN search (Alt + C, then enter, down, enter)
{
	Send {Alt Down}{c}{Alt Up}{Enter}{Down}{Enter}
	Return
}

CpnModSearch: ; Send the keys to get a CPN mod when in a MOD tag (Alt + C, then Enter, Down twice, then enter)
{
	Send {Alt Down}{c}{Alt Up}{Enter}{Down 2}{Enter}
	Return
}

;Createbookmark subroutine
Createbookmark: 
{
	Sleep 500 ; sets a .5 second delay
	Send {Ctrl Down}{Shift down}{f5}{Shift up}{Ctrl up} ; sends the keystrokes to the window. This opens up the bookmark window in ACM
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

;Createqmark subroutine
CreateQmark:
{
	Sleep 500 ; sets a .5 second delay
	Send {Ctrl Down}{Shift down}{q}{Shift up}{Ctrl up} ; sends the keystrokes to the window. This creates a quickmark in the acm window
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

;QuickmarkGo subroutine
Quickmarkgo:
{
	Sleep 500 ; creates a .5 second delay
	Send {Ctrl Down}{q}{Ctrl up} ; sends keystrokes to the window to go to the quickmark
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

CheckoutIE: ; send the keys to perform an IE check out (Alt + O, then H)
{
	Send {Alt Down}{o}{Alt Up}{h}
	return
}

CheckinIE: ; send the keys to perform an IE check in (A;t + 0, then I)
{
	Send {Alt Down}{o}{Alt Up}{i}
	Return
}

ValidateIE: ; Send the keys to perform an IE validate (Alt + C, then DOwn twice, then enter)
{
	Send {Alt Down}{c}{Alt Up}{Down}{Down}{Enter}
	return
}

MetricTolerance() ;Function for the keys to get the Metric tolerance menu (Alt + C, then down, then enter, then down 3 times, then enter)
{
	Send {Alt Down}{c}{Alt Up}{Down}{Enter}{Down 3}{Enter} ; sends keystrokes to window
	return
}

EnglishTolerance() ; function to send the keys for an english tag tolerance menu (Alt + C, then down, then enter, then Down twice, then enter)
{
	Send {Alt Down}{c}{Alt Up}{Down}{Enter}{Down 2}{Enter} ; send keystrokes to window
	Return
}

MetricNorm() ; Function to send the keys for a NON- tolerance metric menu (Alt + C, then down arrow, enter, then down arrow, then enter)
{
	Send {Alt Down}{c}{Alt Up}{Down}{Enter}{Down}{Enter} ; sends keystrokes to window
	Return
}

Englishnorm() ; Function to send the keys for a NON-TOlerance English menu (Alt + C, then DOwn arrow, then enter twice)
{
	Send {Alt Down}{c}{Alt Up}{Down}{Enter 2} ; sends keystrokes to window
	Return
}

/*
****************************************************************************************************************************************************************************
****************************************************************************************************************************************************************************
**********************************************************************************************************************************************************************************
*/



;Rbutton::Rbutton ;This is here to make the right click work like normal until I find out what is messing with the right mouse button. 

; Win + A brings Arbortext window to front if it exists
$#a::
{
	IfWinExist, Arbortext ahk_class TTAFrameXClass ; finds if Arbortext window exists
	{
		WinActivate, Arbortext ahk_class TTAFrameXClass ; makes Arbortext the active window
	}
	return
}


; Win + B brings Browser window to front if it exists
$#b::
{
	IfWinExist, Browser ahk_class TTAFrameXClass ; finds if the browser window exists
	{
		WinActivate, Browser ahk_class TTAFrameXClass ; Brings the browser window to front
	}	
	Return
}

; Win + C brings the Windchill Canvas window to front if it exists
$#c::
{
	IfWinExist, Canvas 14 ahk_class TTAFrameXClass ; Finds if the canvas windchill window exists
	{
		WinActivate, Canvas 14 ahk_class TTAFrameXClass ; brings the windchill canvas window to front
	}
	Return
}


$#h:: ; Win + C brings the Windchill home window to front if it exists
{
	IfWinExist, Windchill - Home ahk_class TTAFrameXClass ; Finds if the  windchill home  window if it  exists
	{
		WinActivate, Windchill - Home ahk_class TTAFrameXClass ; brings the windchill canvas window to front
	}
	Return
}

;Hotkeys rapidhotkey functions
+++SetTitleMatchMode, 2 ; sets the script to find window titles that contain some of the requested wording
#IfWinActive, Arbortext ; makes the hotkeys only work in windows that say Arbortext in them

;=============================================================================================================================
;========================== Arbortext Bookmark Menu ==========================================================================
;============================================================================================================================

; left mouse button and Right mouse button when pressed in Arbortext will create a Menu called MyMenu to make it easier to use bookmarks


~RButton & Lbutton:: ;sets hotkey
{
	Menu, MyMenu, Add, Bookmark Menu, Createbookmark ;creates menu item called Bookmark Menu, if selected, it goes to Createbookmark
	Menu, MyMenu, Add, Create Quickmark, CreateQmark ; creates menu item called Quickmark, if selected it goes to CreateQmark
	Menu, MyMenu, Add  ; Add a separator line.
	Menu, MyMenu, Add, Goto Quickmark, Quickmarkgo ; creates menu item called Quickmark. if selected it goes to quickmarkgo
	Menu, MyMenu, Show ; shows the menu on the screen
	Return
} 



/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Acrolinks Rapid hotkey funcitons ======/=\/=\/=\/=\/=\/\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/

;CPNRapid subroutine
CPNRapid: 
{
	; Below calls on the Rapidhotkey library, each one between the quotes is the number of times you press the hotkey "CPN Singular""CPN plural""CPN MOd"
	RapidHotKey("CPNSIngleSearch""CpnPluralSearch""CpnModSearch",1,0.5,1)
	return
}

;CPNrapidautofill subroutine
CPNRapidautofill:
{
/*
	Gosub, CPNsearch ; goes to the CPNSearch Subroutine
	IfEqual, A_IsCompiled,1
	{
		Run, %A_ScriptFullPath% /Restart
		Exitapp
	}
	
	
	Run, %A_ScriptFullPath% /Restart ; this methond allows the /restart to show in the command line, which prevents the splash image from loading on restart
	exitapp ; exits this verison of the app
	*/
	
	Iniread, Scrolldown, C:\ArbortextMacros\ArbortextMacroSettings.ini, Autofull, autocheckbox
	
	If Scrolldown = 1
	{
	;msgbox, send scrolldown
	Run, C:\Arbortextmacros\CPNSearch.exe /Scrolldown
	}
	Else 
	{
	;msgbox, no scrolldown
	Run, C:\Arbortextmacros\CPNSearch.exe
	}
	
	SetTimer, KillCPNsearch, 180000
	Return
}


KillCPNsearch:
{
Process, Exist, CPNSearch.exe
if(!errorlevel)
process, Close, CPNSearch.exe

SetTimer, KillCPNsearch, Off
Return
}


;==============================================================================================================================================
;============= unitsgroup hotkey, click in proper tag, it will find what the tag it and then open the correct conversion table.================
;=========== click opens the reg conversion, click and hold opens the Tolerance table =========================================================
;==============================================================================================================================================

MetRapid:
{
	; One press of the hotkey goes to MetRapidTotal, 2 presses goes to MetRapidSingle
	RapidHotKey("METRapidTotal""MetRapidSingle",1,0.5,1)
	Return
}

MetRapidSingle: ; This is for when the user pressed the F2 key twice to click into a already present Unitsgroup tag
{
	SkipUnitstag = 1 ; Sets this variable to 1
	Gosub, MetRapidTotal ; goes to the MetRapidTotal subroutine
	SkipUnitstag = 0 ; Once the subroutine is done, the variable is set back to 0
	Return
}

METRapidTotal:
{
	; Sets the script to that is records mouse position and clicks based on the screen and not the window. Helps with reliability
	CoordMode, mouse, screen
	If SkipUnitstag !=1 ; If SkipUnitstag is not 1, it performs the code inbetween the {}
	{
		Temptag = %clipboardall% ;puts all text in clipboard into a variable
		Clipboard = ; clears the clipboard 
		Send {Enter} ; sends enter to the computer
		Sleep 200 ; Delays to app 200 seconds
		Send {U} ;sends the U keystroke to the computer
	}
	
	
	;Findtags() ; goes to the find tags function
	KeyWait, LButton, D T10 ; Waits for the Left mouse button to be pressed down. T10 is options for timeout after 10 seconds and continues down the script
	If ErrorLevel = 1 ; IF the 10 second timeout happens, it creates ErrorLevel = 1, this catches the timeout for the KeyWait command
	{
		Return ; exits the METRapid subroutine
	}
	
	MouseGetPos tx, ty ;Gets the position there you clicked in the tag
	sleep 50 ; sleeps for 50 milliseconds
	Keywait, Lbutton, U t0.5 ; waits for the user to let go of mouse within .5 seconds. This detects if the user is click and holding mouse button.
	
	If ErrorLevel = 1 ; If user does not lift up on mouse (click and hold)
	{
		Unittagtype := Findtags() ;Goes to findtags funciton
		
		If Unittagtype = 1 ; if unittagtype is set to 1 (metric tag) do what is inbetween the {}
		{
			Sleep 100
			Click %tx%, %ty%
			sleep 250
			Send {Lbutton up}
			Sleep 100
			MetricTolerance()
			Return
		}
		
		If Unittagtype = 2 ; if unittagtype is set to 2 (english tag). do what is in between the {}
		{
			sleep 100 ;sets a 100 millisecond delay
			Click %tx%, %ty%
			sleep 250
			Send {Lbutton up}
			Sleep 100
			EnglishTolerance()
			Return
		}}else  {
			Unittagtype := Findtags() ;goes to Findtags Function
			If Unittagtype = 1 ; if unittagtype is set to 1 (Metric tag), do what is in between the {}
			{
				sleep 100 ; sets a 100 millisecond delay
				Click %tx%, %ty%
				sleep 250
				Send {Lbutton up}
				Sleep 100
				MetricNorm()
				Return
			}
			
			If Unittagtype = 2 ; if unittagtype is set to 2 (english tag), do what is in between the {}
			{
				sleep 100 ; sets a 100 millisecond delay
				Click %tx%, %ty%
				sleep 250
				Send {Lbutton up}
				Sleep 100
				Englishnorm()
				Return
			}}
			Clipboard = %Temptag%
			
			Return
		}
		
		
		
		
		;CHKrapid subroutine
		CHKRapid:
		{
			;Below uses the Rapidhotkey library. 
			RapidHotKey("CheckoutIE""CheckinIE""ValidateIE",1,0.5,1)
			return
		}
		#IfWinActive ; stops the only can be used in Arbortext.
		
		
		+++SetTitleMatchMode, 3 ; sets that the window title must match exactly to work
		#IfWinActive Search ahk_class TTAFrameXClass ; window title must only say Search
		
		;SearchRapidArbor subroutine
		SearchRapidArbor:
		{
			+++SetTitleMatchMode,3
			IfWinExist, Search ahk_class TTAFrameXClass ; checks to see if the search window exists
			{
				WinActivate, Search ; activates the search window
				sleep 200 ; delays program for 200 milliseconds
				WinWaitActive, Search,,5 ; waits for search window to be active. Stops the wait after 5 seconds
				sleep 350 ; Delays for 350 miliseconds
				send {esc} ;sends the esc keystroke to window to close the search window
				sleep 500 ; delays program for .5 seconds
			}
			+++SetTitleMatchMode,2
			ErrorLevel = 0 ; reset errorlevel variable to 0
			ErrorLevel := GraphicsSearchSetup() ; runs the GraphicsSearchSetup function and gets the return value of 1 or 0
			If ErrorLevel = 1 ; if the search window is not open. GraphicsSearchSetup() will return a 1, if it opens successfully, function will return a 0
			{
				Exit ; stops the subroutine
			}		
			
			
			#IfWinActive ; turns of only works in search window
			return
		}
		
		
		;canvas rapid subroutine
		CanvasRapid:
		{
			RapidHotKey("Canvasstart",2,0.5,1) ; when pressed twice, it will go to canvasstart subroutine
			Return
		}
		
		
		;canvasstart subroutine
		Canvasstart:
		{
			Send {f2} ; sends teh f2 key to the computer
			WinWaitActive, Canvas Tools AHK_class TTAFrameXClass,,5 ; waits for the Canvas tools window to show up. Times out in 5 seconds.
			If ErrorLevel ; if times out, exits out of the routine.
			{
				exit ; stops the subroutine
			}
			
			sleep 500 ; sets a 500 millisecond pause
			Send {F} ; send F key to computer
			return
		}
		#IfWinActive
		
		+++SetTitleMatchMode, 2 ; Sets the window title matching to contains the search words
		#IfWinActive Canvas Service ahk_class TTAFrameXClass ; window title must only say Search
		;SearchRapidCanvas subroutine
		SearchRapidCanvas:
		{
			;below is the amount of key presses to the sections in the option screen for canvas. 1 press = rapid Section 1, 2 press = repidsection2, 3 presses = rapidsection 3
			RapidHotKey("RapidSection1""RapidSection2""Rapidsection3",1,0.5,1)
			Return
		}
		
		;rapidsection1 subroutine
		RapidSection1:
		{
			Gnumber := Rapid_section_function(Section1)	;goes to the function with the Section1 variable 
			If Gnumber = Error
			Exit
			#IfWinActive ;stops the need to specific window titles
			;Exit ; stops the subroutine
			Return
		}
		
		;rapidsection2 subroutine
		RapidSection2:
		{
			Gnumber := Rapid_section_function(Section2)	
			If Gnumber = Error
			Exit
			#IfWinActive ;stops the need to specific window titles
			;Exit ; stops the subroutine
			Return
		}
		
		;rapidsection3 subroutine
		RapidSection3:
		{
			Gnumber := Rapid_section_function(Section3)	
			If Gnumber = Error
			Exit
			#IfWinActive ;stops the need to specific window titles
			Return
		}
		
		#include Gui for tables.ahk
		
		;tablerapid subroutine for column wide tables, note the subroutines it calls are in AMTables.ahk
		TableRapid:
		{
		
			Tabletext := CreateTable()
			;msgbox, Tablerapid
			;Pgwd := "No" ; sets pgwd variable to no
			;RapidHotKey("3Column""4Column""5Column",1,0.5,1) ; one press of table hotkey goes to 3column subroutine, 2 presses = 4 column, 3 presses = 5 column
			If Escapedgui = 1
			{
			Return
			}
			
			Copytable(tabletext) ; creates the table gui screen with the correct text inside it
			return
		}
	
/*	
		;tablerapidPgwd subroutine for page wide tables, note the subroutines it calls are in AMTables.ahk
		TableRapidPGWd:
		{
			Pgwd := "Yes" ; sets pgwd variable to yes
			RapidHotKey("3Column""4Column""5Column",1,0.5,1) ; one press of table hotkey goes to 3column subroutine, 2 presses = 4 column, 3 presses = 5 column
			;msgbox, done
			
			return
		}
		
		;tabletapideng subroutine, note the subroutines it calls are in AMTables.ahk
		TableRapidENG:
		{
			Pgwd := "Yes" ; sets pgwd variable to yes
			RapidHotKey("J1939""EngineTbl",1,0.5,1) ; one press of hotkey = go to J1939 subroutine, 2 presses goes to Enginetbl subroutine
			return
		}
		
		*/
		
		#IfWinActive ; resets needs to specific window text
		
		/*
		CloseCPN:
		{
			;msgbox, close cpn ;for diagnostics
			process, Close, CPNSearch.exe 
			SetTimer, CloseCPN, Off
			Running_script = 0
			Return
		}
		*/
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Search for Warnings GUI ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		+++SetTitleMatchMode,2 ; sets window title matches to contains the wording
		#IfWinActive, Arbortext ahk_class TTAFrameXClass ; following hotkey only works in Arbortext window
		
		
		$+^S:: ; Shift + ctrl + S hotkey
		{
			; for cleaner code, the below statement is made to include the file warningGUi.ahk that is in the same folder as this script.
			;#include warningGUI.ahk
			gosub, Warningsgui
			return
		}
		#IfWinActive ; clears the only in Arbortext requirement
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Quick View GUI ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		
		$#alt:: ; Win + Alt
		{
			Gosub, GUIscreen ; go to GUIscreen subroutine, note the subroutine is in guiscreen.ahk
			Return
		}
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create the  F6 Tables for the macro ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		; below includes the AMtables.ahk when compiling. 
		#Include AMTables.ahk
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Loads HotKeys Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		SetHotKeys:
		{
			+++SetTitleMatchMode, 3 ; window title has to match exactly with text
			Hotkey, IfWinActive, Search AHK_class TTAFrameXClass ; hotkey only works in search window
			Hotkey, $%SearchHotKey%, SearchRapidArbor ; makes the contents of the searchhotkey variable go to SearchrapidSearch subroutine
			#IfWinActive ; clears the have to be in search window
			
			+++SetTitleMatchMode, 2 ; window title must contain the text
			HOTKEY, IfWinActive, Arbortext AHK_class TTAFrameXClass ; these hotkeys work only in Arbortext
			Hotkey, $%CPNHotKey%, CPNRapid ; makes the contents of the CPNhotkey variable go to CPNrapid subroutine, also turn the hotkey on
			Hotkey, $^%CPNHotKey%, CPNRapidautofill  ; makes the Ctrl + contents of the  CPNhotkey variable go to CPNrapidautofill subroutine, also turn the hotkey on
			Hotkey, $%METHotKey%, METRapid ; makes the contents of the  METhotkey variable go to METrapid subroutine, also turn the hotkey on
			Hotkey, $%CHKHotKey%, CHKRapid ; makes the contents of the  CHKhotkey variable go to CHKRapid subroutine, also turn the hotkey on
			Hotkey, $%TableHotKey%, TableRapid ; makes the contents of the  Tablehotkey variable go to TableRapid subroutine, also turn the hotkey on
			;Hotkey, $^%TableHotKey%, TableRapidpgwd ; makes the Ctrl + contents of the  Tablehotkey variable go to TableRapidPgwd subroutine, also turn the hotkey on
			;Hotkey, $+^%TableHotKey%, TableRapidENG ; makes the shift + Ctrl + contents of the  Tablehotkey variable go to TableRapidENG subroutine, also turn the hotkey on
			;Hotkey, $#^%TableHotKey%, TableVSP ; makes the contents of the  Win + Ctrl + Table hotkey variable go to TableVSP subroutine, also turn the hotkey on
			Hotkey, $%SearchHotKey%, SearchRapidArbor ; makes the contents of the Searchhotkey variable go to SearchRapidArbor subroutine, also turn the hotkey on
			
			HotKey, IfWinActive, Canvas Service AHK_class TTAFrameXClass ; this hotkey only works in the cavas service window
			Hotkey, $%SearchHotKey%, SearchRapidCanvas ; makes the contents of the Searchhotkey variable go to SearchRapidCanvas subroutine, also turn the hotkey on
			
			Hotkey, IfWinActive,  Canvas 14 AHK_class TTAFrameXClass ; this hotkey only works in Canvas 14 for windchill
			Hotkey, $%SearchHotKey%, CanvasRapid ; makes the contents of the Searchhotkey variable go to CanvasRapid subroutine, also turn the hotkey on
			Return
		}
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create the  Gui screens ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		#include GUIScreen.ahk
		
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Canvas search screen Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		
		+++SetTitleMatchMode, 2 ; sets window requirements to exact match
		
		;canvassucceed subroutine
		CavnasSucceed:
		{
			IfWinExist, ACM Save2WC Function Succeeded ; checks to see if the ACM Save2WC Function Succeeded window exists
			{
				SetTimer, CavnasSucceed, off ; Turns off the timer
				Sleep 500 ; pauses script for .5 seconds
				WinActivate ACM Save2WC Function Succeeded ; activates the ACM save2wc window
				sleep 10
				WinWaitActive, ACM Save2WC Function Succeeded,,3 ; waits for the window to be active, times out after 3 seconds
				Sleep 100 ; pasues for .5 seconds
				;WinActivate, ACM Save2WC Function Succeeded
				;sleep 100
				Send {Enter} ; sends enter to window
				Sleep 300 ; pauses for 300 milliseconds
				WinActivate Search AHK_class TTAFrameXClass ; activates search window from Arbortext
				Sleep 200 ; pauses script for 100 milliseconds
				WinWaitActive, Search,,10 ; waits for search window to be active window, times out after 10 seconds
				If ErrorLevel = 1 ; if times out, exists subroutine
				{
					Exit ; stops subroutine
				}else  {
					sleep 500
					Send {Enter} ; send enter key to window
					sleep 500
					WinWaitActive, Browser,,10 ; waits for the browser window to be opened and active window. waits 10 seconds before timeout
					If ErrorLevel = 1 ; if times out, stops subroutine
					{
						Exit ; stops subroutine
					}else  {
						Sleep 1000 ; pauses 1 second
						WinActivate, Search AHK_class TTAFrameXClass ; makes the search window the active window
						Sleep 100 ; pauses .1 second
						WinWaitActive, Search,, 10 ; waits for the search window to become active, times out after 10 seconds
						sleep 500 ;pauses .5 second
						Send {Esc} ; sends escape
						Sleep 500 ; pauses 500 miliseond
						WinActivate, Browser  AHK_class TTAFrameXClass; activates the browser window
						
						SetTimer, CavnasSucceed, Off ; turns off the check every .5 second for ACM Save2wc window
					}}}
					Else IfWinNotExist, ACM Save2WC Function Succeeded  ; if window does not exists, it just goes back to the previous function
					{
						sleep 100
						Canvascount++
						If Canvascount = 100
						{
							SetTimer, CavnasSucceed, off ; Turns off the timer
							canvascount = 0
						}
						Return
					}
					Return
				}
				
				;Arbortextfullscteen subroutine
				ArborFullScreen:
				{
					Fullscreen = 0 ; sets fullscreen variable to 0
					wingetTitle,TitlearborAM,A ; gets the window title of the active window. stores title into TitlearborAM variable
					WinGetPos, Xarbor,yarbor,warbor,harbor, %titlearborAM% ; finds the window position on the screen
					CurrmonAM := GetCurrentMonitor() ; goes to the GetCurrentMonitor function and gets the screen the window is on
					SysGet,Aarea,MonitorWorkArea,%currmonAM% ; finds the four coners of the screen  the window is on
					WidthA := AareaRight- AareaLeft ; math to find width of screen. Stores it into WidthA variable
					HeightA := aareaBottom - aAreaTop ; Math to find the height of screen, stores it into HeightA variable
					leftt := aAreaLeft - 4 ; gets the left most position of the screen minus 4 pixels because Oracle create a 4 pixel invisible window around ACM
					topp := AAreaTop - 4 ; gets the top position of the window minus 4 pixes becasue oracle creates a 4 pixel invisible border aroung ACM window
					MouseGetPos mmx,mmy ; gets the current mouse pointer position
					If yarbor = %topp% ; checks to see if the top of the window matchs the top of the screen
					{
						If xarbor = %leftt% ; Checks to see if the left side of the window is on the left most side of the screen
						;Msgbox, win maxed ; for diagnotics
						Return ; stops and returns to the rest of the script
					}
					Else
						;msgbox, not maxed ; for diagnositcs
					CoordMode, mouse, Relative ; makes it so the mouse position is relative to the active window
					MouseMove 300,10 ;move the mouse to the top of the active window
					Click ; clicks the mouse
					Click ; clicks the mouse.. This maximizes the window
					Fullscreen = 1 ; sets the fullscreen variable to 1
					CoordMode, mouse, screen ; sets the mouse position so relative to the screen 
					;MouseMove, mmx, mmy ; for diagnostics
					return
				}
				
				;GetCurrentMonitor function
				GetCurrentMonitor()
				{
					SysGet, numberOfMonitors, MonitorCount ; finds how many monitors the user is using
					WinGetPos, winX, winY, winWidth, winHeight, Arbortext ; gets the window position of arbortext
					winMidX := winX + winWidth / 2 ; math to find middle of monitor
					winMidY := winY + winHeight / 2 ; math to find middle of monitor
					Loop %numberOfMonitors% ; loops through all monitors
					{
						SysGet, monArea, Monitor, %A_Index% ; gets the monitor size of the monitor
						if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop) ; finds the monitor that the arbortext window it on
						return A_Index ; returns the monitor number
					}
					SysGet, MonitorPrimary, MonitorPrimary ; gets which monitor is the primart monitor
					return "No Monitor Found" ; returns this to variable if arbortext is not found
				}
				
				;below includes the version check script 
				#include Version check_arbortext.ahk
				
								
				;Esc key will stop any loops in arbortext.
				+++SetTitleMatchMode, 2 ; window title must contain the wording
				#IfWinActive, Arbortext ; window must contain arbortext for Esc key to work this way
				~esc:: ; the ~ lets the esc pass through, so it act like a normal esc key as well as perform the below actions
				{
					reload = 1
					BreakLoop := 1 ; sets breakloop to 1, so if loops see this, it will stop them
					;SystemCursor("On") ; ensures the system cursor is on from CPN search. IF user excapes out of it
					Send {Ctrl up}{shift up}{alt up} ; send keystrokes
					
					
					IfEqual, A_IsCompiled,1
					{
						Run, %A_ScriptFullPath% /Restart
					}
					
					
					Run, %A_ScriptFullPath% /Restart ; this methond allows the /restart to show in the command line, which prevents the splash image from loading on restart
					exitapp ; exits this verison of the app
					Return
					;reload ; reloads script
				}
				
				#IfWinActive ; stops any in only arbortext requirement
				
				/*		
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Saves to INI File Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				*/
				#include Ini settings.ahk
				
				Quitting:
				{
					Send {alt up}
					Send {Ctrl up}
					Send {Shift up}
					Exitapp
					Return
				}   
				
				/*		
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Function section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				*/
				
				StartGDIP(Ptoken)
				{
					if pToken = 0 ; if the Gdip library isnt started, it will be 0
					{
						pToken := Gdip_Startup() ; start up the Gdip library and returns a number to the Ptoken variable
					}
					
					Return pToken
				}
				
				StopGdip(Ptoken)
				{
					If pToken !=0 ; if the gdip libraryt is in use
					{
						Gdip_Shutdown(pToken) ; turns the gdip library off to save memory
					}
					Return Ptoken
				}
				
				Copytext()
				{
					Send {Ctrl Down}{c}{Ctrl Up} ; sends the Ctrl +C to copy the selected text
					Return
				}
				
				;findtags Function
				Findtags()
				{
					Unittagtype = 0 ; sets Unittagtype variable to 0
					tagcounter = 0 ; sets tagcounter to 0
					Send {Lbutton UP} ; sends a Leftmouse button Up to computer if the user still has the mouse button down
					sleep 100 ; sets a 100 miliseond delay
					send {Shift Down}{Left}{Shift Up} ; sends keystrokes to window to get tag
					sleep 300 ; sets a 300 millisecond delay
					Copytext() ; Goes to function to copy the selected text
					ClipWait, 3 ; waits for clipboard to contain text. Times out in 3 seconds
					Sleep 100 ; sets ni a 100 millisecond delay
					Texttemp = %Clipboard% ;puts the clipboard contents into the Texttemp variable
					If Texttemp = 
					{
						send {Shift Down}{Left}{Shift Up} ; sends keystrokes to window to get tag
						sleep 300 ; sets a 300 millisecond delay
						Copytext() ; Goes to function to copy the selected text
						ClipWait, 3 ; waits for clipboard to contain text. Times out in 3 seconds
						Sleep 100 ; sets ni a 100 millisecond delay
					}
					
					If texttemp contains BeforeOrAfterText,Metric,English,interword ; sees if the texttemp var has BeforeorAFtertext, metric or english in the variable
					{}
					Else ; IF it does not contain one of the above text. exits so that it does not keep going.
					{
						send {Shift Down}{Left}{Shift Up} ; sends the keystrokes to the window to select the text to the left of the cursor
						sleep 100 ; sets a 100 millisecond delay
						Copytext() ; Goes to function to copy the selected text
						sleep 100
						Texttemp = %Clipboardall% ;puts the clipboard contents into the Texttemp variable
					}
					
					If texttemp contains BeforeOrAfterText,Metric,English,interword ; sees if the texttemp var has BeforeorAFtertext, metric or english in the variable
					{}
					Else ; IF it does not contain one of the above text. exits so that it does not keep going.
					{
						Return "Timed_Out"
					}
					
					
					If Texttemp contains metric ; when texttemp variable contains the word metric, it does what is in between the {}
					{
						;click %tx%,%ty% ; clicks in the recorded mouse location
						clipboard = %Temptag% ; sets the clipboard to the temptag variable
						Return 2 ;sends the number 2 from funciton
					}
					
					If Texttemp contains english  ; when texttemp variable contains the word english, it does what is in between the {}
					{
						;click %tx%,%ty% ; clicks in the recorded mouse location
						clipboard = %Temptag% ; sets the clipboard to the temptag variable
						Return 1 ;sends the number 1 from funciton
					}
					
					
					While Texttemp contains BeforeOrAfterText,interword ; Loop while Texttemp variable has the BeforeorAFtertext in it. This is for when Show generated text is on in ACM
					{
						tagcounter++ ; adds 1 to tagcounter variable
						If tagcounter = 4 ; when tagcounter variable is set to 3, it stops the loop. This prevents the script from messing up if the user does not click in the unitsgroup tag
						{
							Return "Timed_Out" 
							Break ; stops the loop
						}
						
						If Texttemp contains metric ; when texttemp variable contains the word metric, it does what is in between the {}
						{
							;click %tx%,%ty% ; clicks in the recorded mouse location
							clipboard = %Temptag% ; sets the clipboard to the temptag variable
							Return 2 ;sends the number 2 from funciton
							break ; stops the while loop
						}
						
						If Texttemp contains english  ; when texttemp variable contains the word english, it does what is in between the {}
						{
							;click %tx%,%ty% ; clicks in the recorded mouse location
							clipboard = %Temptag% ; sets the clipboard to the temptag variable
							Return 1 ;sends the number 1 from funciton
							break ; stops the while loop
						}
						
						send {Shift Down}{Left}{Shift Up} ; sends the keystrokes to the window to select the text to the left of the cursor
						sleep 100 ; sets a 100 millisecond delay
						Copytext() ; Goes to function to copy the selected text
						ClipWait, 3 ; wait for the clipboard to contain text. Times outs after 3 seconds
						Sleep 100 ; sets a 100 millisecond delay
						Texttemp = %Clipboard%  ; makes the texttemp variable contain the clipboard text
					}
					
					clipboard = %Temptag% ; when the subroutine is over, put the original clipboard text that was stored into the temptag variable back into the clipboard
					temptag := ; clears the temptag variable to free up some memory
					Return
				}
				
				+++SetTitleMatchMode,2
				GraphicsSearchSetup()
				{
					WinActivate Arbortext
					sleep 100
					WinWaitActive, Arbortext,,10 ;Waits for search window to be the active window. Stops wait after 5 seconds
					If ErrorLevel = 1 ; if the search window is not open. subroutine will stop.
					{
						msgbox, error
						Return "2" ; returns 2 to say it timed out.
					}
					Sleep 500
					Send {Alt Down}{o}{Alt Up}{e} ; sends keystrokes to computer to open the search window
					sleep 300 ; delays program for 100 milliseconds
					WinWaitActive, Search,,10 ;Waits for search window to be the active window. Stops wait after 5 seconds
					If ErrorLevel = 1 ; if the search window is not open. subroutine will stop.
					{
						Return "1" ; returns 1 to say it timed out.
					}
					Sleep 500
					Send {Tab}{g}{r} ; sends keystrokes to window
					sleep 200 ; delays program for 200 milliseconds
					Send {tab}{g}{r} ; sends keystrokes to window
					Sleep 200 ; delays program for 200 milliseconds
					Send {tab 2}{right} ; sends keystrokes to window
					Sleep 200 ; delays program for 200 milliseconds
					Send {tab 8} ; sends 8 tab keystrokes to window
					Sleep 400 ; delays program for 400 milliseconds
					Send {c}{o}{n}{t}{r}{tab}{Enter} ; sends keystrokes to window
					Sleep 400 ; delays program for 400 milliseconds
					Send {tab 7}  ; sends 7 tabs to window
					Sleep 200 ; delays program for 200 milliseconds
					
					
					If (RegExMatch(clipboard,"^G[0-9]{8}$")) ; finds if the number is a Gnumber with an upper case G
					{
						Clipboard := RegexReplace(Clipboard,"G","g") ; replaces the Uppercase G to a Lower case g so it can be found in ACM
					}
					
					if RegExMatch(clipboard, "^g[0-9]{8}$") ; searches the clipboard for an item that has a g in the front and then 8 numbers after it (a graphics # for ACM) If found, it pastes, if not then it does nothing
					{
						Sendraw %Clipboard% ; send keystrokes to window
					}
					Return 0
				}
				
				CreateMenu()
				{
					Menu, tray, Add, Arbortext Macros  ,Guiscreen ;make the title of the menu
					Menu, tray, Default,Arbortext Macros  ; makes this the top line in the menu
					Menu,Tray, Disable, Arbortext Macros ; disables it so it is greyed out
					Menu, tray, add, Hotkey Cheat Sheet, Guiscreen ; Creates a new menu item. ; goes to gui screen
					Menu, tray, add, Options, Optionsmenu ; Goes to options screen
					Menu, tray, add, Check For Update, Versioncheck ; goes to version check
					Menu, tray, add, About, Aboutmenu ; OPens about menu
					Menu, tray, add, Quit, Quitapp ; quit macro
					return
				}
				
				
				Rapid_section_function(SectionNumber)
				{
					Send {Ctrl Down}{Left}{Ctrl Up} ; send the keystrokes to the computer
					Sleep 100 ; pauses for 100 milliseconds
					Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up} ; sends the keystrokes to the computer
					Sleep 100 ; pauses for 100 milliseconds
					Copytext() ; Goes to function to copy the selected text
					Sleep 200 ; pauses for 200 milliseconds
					
					If (RegExMatch(clipboard,"^G[0-9]{8}$")) ; finds if the number is a Gnumber with an upper case G
					{
						Clipboard := RegexReplace(Clipboard,"G","g") ; replaces the Uppercase G to a Lower case g so it can be found in ACM
					}
					
					if RegExMatch(clipboard, "^g[0-9]{8}$") ; searches the clipboard for an item that has a g in the front and then 8 numbers after it (a graphics # for ACM) If found, it pastes, if not then it does nothing
					{
						Gnumber = %clipboard% ; takes the Gnumber from the clipboard and puts into the Gnumber variable
					}
					
					IfWinExist Arbortext ; if Arbortext window exists
					{
						+++SetTitleMatchMode, 3 ; sets search for window titles to be exact match
						IfWinExist Search ahk_class TTAFrameXClass  ; window has to say exactly Search in title and if search window is open
						{
							WinActivate Search ; active search window
							sleep 100 ; pause for 100 milliseconds
							WinWaitActive, Search,,5 ; wait for search window to be active. Times out in 5 seconds
							sleep 300
							Send {Alt Down}{C}{Alt UP} ; sends the keystrokes to the computer
							Sleep 300 ; pauses for 300 milliseconds
						}
						ErrorLevel = 0 ; reset errorlevel variable to 0
						+++SetTitleMatchMode, 2 ; Sets the window title matching to contains the search words
						ErrorLevel := GraphicsSearchSetup() ; runs the GraphicsSearchSetup function and gets the return value of 1 or 0
						If ErrorLevel = 1 or ErrorLevel = 2 ; if the search window is not open. GraphicsSearchSetup() will return a 1, Arbortext cannot be made active window a 2 if it opens successfully, function will return a 0
						{
							Gnumber := "Error" ; makes Gnumber variable contain the text Error
							Return Gnumber ; returns from function with the error text
							Exit ; stops the subroutine
						ErrorLevel = 0 ; reset errorlevel variable to 0
						+++SetTitleMatchMode, 2 ; Sets the window title matching to contains the search words
						ErrorLevel := GraphicsSearchSetup() ; runs the GraphicsSearchSetup function and gets the return value of 1 or 0
						If ErrorLevel = 1 or ErrorLevel = 2 ; if the search window is not open. GraphicsSearchSetup() will return a 1, Arbortext cannot be made active window a 2 if it opens successfully, function will return a 0
						{
						Gnumber := "Error" ; makes Gnumber variable contain the text Error
						Return Gnumber ; returns from function with the error text
						Exit ; stops the subroutine
					}
				}
				
				WinActivate Canvas Service ; active canvas service window
				Sleep 300 ; pause script for 300 milliseconds
				WinWaitActive,Canvas Service,, 5 ; wait for canvas service window to be active. times out in 3 seconds
				sleep 500
				Send {Tab 2} ; sends the keystrokes to the computer
				Sleep 100 ; pauses for 100 milliseconds
				Send %SectionNumber% ; send the Section one variable to the section drop down in the canvas service screen
				Sleep 200 ; pause for 200 milliseconds
				Send {Down}{Tab 7} ; sends the keystrokes to the computer
				
				SetTimer, CavnasSucceed, 500	;turns on a timer that ever .5 seconds, script goes to the Canvassucceed subroutine
				Return Gnumber ; returns the Gnumber variable from the clipboard
			}
			
			
		
	
	}
	

activeMonitorInfo( ByRef aX, ByRef aY, ByRef aWidth,  ByRef  aHeight, ByRef mouseX, ByRef mouseY  )
{
CoordMode, Mouse, Screen
MouseGetPos, mouseX , mouseY
SysGet, monCount, MonitorCount
Loop %monCount%
{ 	SysGet, curMon, Monitor, %a_index%
if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom )
{
aX      := curMonTop
ay      := curMonLeft
aHeight := curMonBottom - curMonTop
aWidth  := curMonRight  - curMonLeft
return
}
}
}


	Pausescript()
		{
			Menu,Tray,Icon, % "C:\ArbortextMacros\icons\paused.ico", ,1
			Pause,on
			Return
		}

		UnPausescript()
	{
		Menu,Tray,Icon, % "C:\ArbortextMacros\icons\am.ico", ,1
		Pause,off
		Return
		}
		
		Licensinginfo()
			{
				Msgbox, Unless otherwise stated, All content of this script unless otherwise noted was created by Jarett Karnia for the use of Caterpillar, Inc `n This script Can be used and modified as needed. But Must give credit to Orginal creaters of the content (including the libraries) and state what was changed from the orginal source code.
				Return
			
			
			}
		
#`::Listlines              