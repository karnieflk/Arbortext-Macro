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
Updates to script from Version 1.3
***************************************
Updated Code a bit
	- combined a bunch of the individual files to make it one large file
Added config file to help ease in updating for future proofing


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


inifile = c:\arbortextmacros\config.ini
Load_ini_file(inifile)

Version_Number := "1.4 Beta" ;Version number to use for update checks

; The below code checks if user hit esc and restarted the macro. If they did, then the start splash screen does NOT show. IF they didn't then the start splash screen will show.
;This needs to be in the location becuase it checks the text in the command line, before anything else loads. It will not work if placed in another part of the script.
CmdLine := DllCall("GetCommandLine", "Str")

if !RegExMatch(CmdLine, "\/Restart")
{
	Reload = 0
	SplashImage,%Root_Folder_Location%\ProgramImages\SplashinmageAM.png, B x0 y0 h300 W500,,,Titlescreen ; places the splashimage  at the top corner  of the active monitor
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
/*
*********************************************************************************************************************************
******************************** Startup check section ************************************************************************
*********************************************************************************************************************************
*/
;Creates the needed Folders if they dont Exist

IfNotExist,  %Root_Folder_Location%
{
	FileCreateDir, %Root_Folder_Location%
}

IfNotExist, %Root_Folder_Location%\UserImages
{
	FileCreateDir, %Root_Folder_Location%\UserImages
}
IfNotExist, %Root_Folder_Location%\Icons
{
	FileCreateDir, %Root_Folder_Location%\Icons
}
IfNotExist, %Root_Folder_Location%\ProgramImages
{
	FileCreateDir, %Root_Folder_Location%\ProgramImages
}

IfNotExist, %Root_Folder_Location%\ArbortextMacroSettings.ini
{
	;below takes the files fron the marcosn folder on computer and embeds them into the exe file. 
	FileInstall, C:\ArbortextMacrosn\ArbortextMacroSettings.ini, %Root_Folder_Location%\ArbortextMacroSettings.ini
	Firstrun = 1
}

FileInstall, C:\ArbortextMacrosn\How to use Arbortext Macros.pdf, %Root_Folder_Location%\How to use Arbortext Macros.pdf,1

IfNotExist, %Root_Folder_Location%\icons\paused.ico
{
	;below takes the files fron the marcosn folder on my computer and embeds them into the exe file. 
	FileInstall,C:\ArbortextMacrosn\icons\paused.ico, %Root_Folder_Location%\icons\paused.ico
}

IfNotExist,%Root_Folder_Location%\icons\am.ico
{
	;below takes the files fron the marcosn folder on my computer and embeds them into the exe file. 
	FileInstall,C:\ArbortextMacrosn\icons\am.ico,%Root_Folder_Location%\icons\am.ico
}

;================================================================

; INstalls the needed files for the auto search

FileInstall,C:\ArbortextMacrosn\ProgramImages\Box.png,%Root_Folder_Location%\ProgramImages\Box.png,0     

FileInstall,C:\ArbortextMacrosn\ProgramImages\SplashinmageAM.png,%Root_Folder_Location%\ProgramImages\SplashinmageAM.png,1

FileInstall, C:\ArbortextMacrosn\CPNSearch.exe,%Root_Folder_Location%\CPNSearch.exe,1

IfExist,%Root_Folder_Location%\ProgramImages\BG.png
	FileDelete,%Root_Folder_Location%\ProgramImages\BG.png


IfExist,%Root_Folder_Location%\Change Log.txt
{
	FileDelete,%Root_Folder_Location%\Change Log.txt
}

If Reload = 0
{
	Filename := "Arbortext Macros"
	Folder := A_Startup
	loop, %folder%\*.*
	{
		If A_LoopFileName Contains %Filename%
		{
			;msgbox, foudn name %A_LoopFileName%
			Foundfile = 1
			Break
		}}
	
	
	;IfNotExist %A_Startup%\Arbortext macros*.exe | .ahk | .ink
	If foundfile !=1
	{
		activeMonitorInfo( amony,Amonx,AmonW,AmonH,mx,my ) ;gets the coordinates of the screen where the mouse is located.
		Amonh /=2
		amonw /=2
		amonx := amonx + (amonw/2)
		amony := amony + (amonh/2)
		Settimer, winmovemsgbox, 50
		Titletext := "Do you want to open the Startup folder so that you can put the progam in it"
		msgbox, 262148,No Startup File, Arbortext Macros is not in startup folder. Do you want to open the Startup folder so that you can put the progam in it?
		
		IfMsgBox Yes
		{
			Run, %A_StartUp%
		}}}   

; Creates Menu for gui screen
Menu, BBBB, Add, &Check For Update , Versioncheck
	Menu, BBBB, Add, &Options, Optionsmenu
	Menu, BBBB, Add,
	Menu, BBBB, Add, &Exit, exitprogram
	
	Menu, DDDD, Add, &How To Use, HowTo
	Menu, DDDD, Add, &About , Aboutmenu
	
	Menu, MyMenuBar, Add, &File, :BBBB
	Menu, MyMenuBar, Add, &Help, :DDDD
	
/*
*********************************************************************************************************************************
******************************** End of Startup check section ************************************************************************
*********************************************************************************************************************************
*/
	

Listlines, off ; turns off debug lines


Listlines, on ; turns on debug lines
Onexit,  Quitting ; when the program restarts or exits, the script will run this subroutine



; Below are the global variables that work everywhere
Global CPNHotkey, METHotkey, CHKHotkey, SearchHotkey, TableHotkey, section1, section2, section3, guinumber , Tabletype, Pgwd, Userrows, NewwordGUi ; these are all global variables


Ptoken = 0 ; sets the Ptoken variable to 0. 
guinumber = 0 ; set this variable to 0
SkipUnitstag = 0 ; Sets teh variable to 0
canvascount = 0




;below checks for the settings text document, if it not there, it makes one
if not (FileExist(Root_Folder_Location "\ArbortextMacroSettings.ini"))
{
	FileAppend,,%Root_Folder_Location%\ArbortextMacroSettings.ini
	Firstrun = 1
	Gosub, Default_Settings
}


Create_Tray_Menu()  ; goes to Createmenu function
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


; This section below is here to stop a bug that allowed many.. and I mean many instances of the program to be active..  Process finds the others with the same name and kills them
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
	Send %CPN_Single_Search%
	Return
}

CpnPluralSearch: ; Sends the keys to get a plural CPN search (Alt + C, then enter, down, enter)
{
	Send %CPN_Plural_Search%
	Return
}

CpnModSearch: ; Send the keys to get a CPN mod when in a MOD tag (Alt + C, then Enter, Down twice, then enter)
{
	Send %CPN_Mod_Search%
	Return
}

;Createbookmark subroutine
Createbookmark: 
{
	Sleep 500 ; sets a .5 second delay
	Send %Create_Bookmark%  ; sends the keystrokes to the window. This opens up the bookmark window in ACM
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

;Create_Quickmark subroutine
Create_Quickmark:
{
	Sleep 500 ; sets a .5 second delay
	Send %Create_Quickmark%  ; sends the keystrokes to the window. This creates a quickmark in the acm window
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

;QuickmarkGo subroutine
Quickmarkgo:
{
	Sleep 500 ; creates a .5 second delay
	Send %GO_TO_Quickmark%  ; sends keystrokes to the window to go to the quickmark
	Menu, MyMenu, DeleteAll ; turns off the MyMenu
	Return
}

CheckoutIE: ; send the keys to perform an IE check out (Alt + O, then H)
{
	Send %Arbortext_Check_Out_IE%
	return
}

CheckinIE: ; send the keys to perform an IE check in (A;t + 0, then I)
{
	Send %Arbortext_Check_In_IE%
	Return
}

ValidateIE: ; Send the keys to perform an IE validate (Alt + C, then DOwn twice, then enter)
{
	Send %Validate_IE%
	return
}

MetricTolerance() ;Function for the keys to get the Metric tolerance menu (Alt + C, then down, then enter, then down 3 times, then enter)
{
	Send %Metric_Tolerance%  ; sends keystrokes to window
	return
}

EnglishTolerance() ; function to send the keys for an english tag tolerance menu (Alt + C, then down, then enter, then Down twice, then enter)
{
	Send %English_Tolerance%  ; sends keystrokes to window
	Return
}

MetricNorm() ; Function to send the keys for a NON- tolerance metric menu (Alt + C, then down arrow, enter, then down arrow, then enter)
{
	Send %Metric_No_Tolerance% ; sends keystrokes to window
	Return
}

Englishnorm() ; Function to send the keys for a NON-TOlerance English menu (Alt + C, then DOwn arrow, then enter twice)
{
	Send %English_No_Tolerance%  ; sends keystrokes to window
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
	IfWinExist, %Arbortext_Window_Title% ; finds if Arbortext window exists
	{
		Win_Activate(Arbortext_Window_Title) ; makes Arbortext the active window
	}
	return
}


; Win + B brings Browser window to front if it exists
$#b::
{
	IfWinExist, %Browser_Window_Title% ; finds if the browser window exists
	{
		Win_Activate(Browser_Window_Title) ; Brings the browser window to front
	}	
	Return
}

; Win + C brings the Windchill Canvas window to front if it exists
$#c::
{
	IfWinExist, %Canvas_Window_Title% ; Finds if the canvas windchill window exists
	{
		Win_Activate(Canvas_Window_Title)  ; brings the windchill canvas window to front
	}
	Return
}


$#h:: ; Win + C brings the Windchill home window to front if it exists
{
	IfWinExist, %Windchill_Window_Title% ; Finds if the  windchill home  window if it  exists
	{
		Win_Activate(Windchill_Window_Title)  ; brings the windchill home window to front
	}
	Return
}

;Hotkeys rapidhotkey functions
+++SetTitleMatchMode, 2 ; sets the script to find window titles that contain some of the requested wording
#If WinActive(Arbortext_Window_Title) ; makes the hotkeys only work in windows that say Arbortext in them

;=============================================================================================================================
;========================== Arbortext Bookmark Menu ==========================================================================
;============================================================================================================================

; left mouse button and Right mouse button when pressed in Arbortext will create a Menu called MyMenu to make it easier to use bookmarks


~RButton & Lbutton:: ;sets hotkey
{
	Menu, MyMenu, Add, Bookmark Menu, Createbookmark ;creates menu item called Bookmark Menu, if selected, it goes to Createbookmark
	Menu, MyMenu, Add, Create Quickmark, Create_Quickmark ; creates menu item called Quickmark, if selected it goes to Create_Quickmark
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
	
	Iniread, Scrolldown,%Root_Folder_Location%\ArbortextMacroSettings.ini, Autofull, autocheckbox
	
	If Scrolldown = 1
	{
	;msgbox, send scrolldown
	Run,%Root_Folder_Location%\CPNSearch.exe /Scrolldown
	}
	Else 
	{
	;msgbox, no scrolldown
	Run,%Root_Folder_Location%\CPNSearch.exe
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
		Sleep 200 ; Delays to app .200 seconds
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
			Clipboard = %Temptag%
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
			Clipboard = %Temptag%
			Return
		}}
		
		else  {
			Unittagtype := Findtags() ;goes to Findtags Function
			If Unittagtype = 1 ; if unittagtype is set to 1 (Metric tag), do what is in between the {}
			{
				sleep 100 ; sets a 100 millisecond delay
				Click %tx%, %ty%
				sleep 250
				Send {Lbutton up}
				Sleep 100
				MetricNorm()
				Clipboard = %Temptag%
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
				Clipboard = %Temptag%
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
		#If ; stops the only can be used in Arbortext.
		
		
		+++SetTitleMatchMode, 3 ; sets that the window title must match exactly to work
		#If WinActive(Search_Window_Title)  ; window title must only say Search
		
		;SearchRapidArbor subroutine
		SearchRapidArbor:
		{
			+++SetTitleMatchMode,3
			IfWinExist, %Search_Window_Title% ; checks to see if the search window exists
			{
				Win_Activate(Search_Window_Title)
				sleep 250 ; Delays for 350 miliseconds
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
			
			
			#If ; turns of only works in search window
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
			WinWaitActive, %Canvas_Tools_Window_Title%,,5 ; waits for the Canvas tools window to show up. Times out in 5 seconds.
			If ErrorLevel ; if times out, exits out of the routine.
			{
				exit ; stops the subroutine
			}
			
			sleep 500 ; sets a 500 millisecond pause
			Send {F} ; send F key to computer
			return
		}
		#If
		
		+++SetTitleMatchMode, 2 ; Sets the window title matching to contains the search words
		#If WinActive(Canvas_Service_Window_Title) ; window title must only say Search
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
			#If  ;stops the need to specific window titles
			;Exit ; stops the subroutine
			Return
		}
		
		;rapidsection2 subroutine
		RapidSection2:
		{
			Gnumber := Rapid_section_function(Section2)	
			If Gnumber = Error
			Exit
			#If ;stops the need to specific window titles
			;Exit ; stops the subroutine
			Return
		}
		
		;rapidsection3 subroutine
		RapidSection3:
		{
			Gnumber := Rapid_section_function(Section3)	
			If Gnumber = Error
			Exit
			#If ;stops the need to specific window titles
			Return
		}
		
		#include Gui for tables.ahk
		
	
		TableRapid:
		{
		
			Tabletext := CreateTable()
			If Escapedgui = 1
			{
			Return
			}
			
			Copytable(tabletext) ; creates the table gui screen with the correct text inside it
			return
		}

		
		#If ; resets needs to specific window text
		
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
		#If WinActive(Arbortext_Window_Title) ; following hotkey only works in Arbortext window
		
		
		$+^S:: ; Shift + ctrl + S hotkey
		{
			; for cleaner code, the below statement is made to include the file warningGUi.ahk that is in the same folder as this script.
			;#include warningGUI.ahk
			gosub, Warningsgui
			return
		}
		#If ; clears the only in Arbortext requirement
		
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
	


;~ /=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create Column Wide Tables Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\


3Column: ; Makes 3 column Table with 22 rows. Makes the top row merged and adds required parts.  Then the 2nd row has qty, part #, part description
{
	
	;Tabletype = C2
	;Tabletext := Createtable("C2",Pgwd) ; to createtable Function that passes C2 for 2 column, then the pgwd variable. 
	
	Return
}


4Column: ; Makes 4 column Table with 22 rows. Makes the top row merged and adds required parts.  Then the 2nd row has item. qty, part #, part description
{
	;Tabletype = C3
	;Tabletext := Createtable("C3",Pgwd) ; to createtable funciton that passed the c3 for 3 column, then the Pgwd variable contents (Yes or no)
	Copytable(tabletext) ; creates the table gui screen with the correct text inside it
	return
}


/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create Pagewide Tables Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/ 

5Column: ; Makes 5 column Table pg wide with 22 rows. Makes the top row merged and adds required parts.  Then the 2nd row has qty, part #, part description, former part
{
	;Tabletype = C5
	;Tabletext := Createtable("C5",Pgwd)  ;to createtable funciton that passed the c5 for 5 column, then the Pgwd variable contents (Yes or no)
	Copytable(tabletext) ; creates the table gui screen with the correct text inside it
	Return
}

/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== ENgine Troubleshooting Tables ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/

EngineTbl: 
{
	;tabletype = Troubleshoot
	;Tabletext := Createtable("Troubleshoot",Pgwd)  ;to createtable funciton that passed the Troubleshoot for the troubleshooting table, then the Pgwd variable contents (Yes or no)
	Copytable(tabletext) ; creates the table gui screen with the correct text inside it
	Return
}

J1939:
{
	;Tabletext :=  Createtable("Jcode",Pgwd) ;to createtable funciton that passed the Jcode for the Jcode table, then the Pgwd variable contents (Yes or no)
	Copytable(tabletext)  ; creates the table gui screen with the correct text inside it
	
	Return
}



TableVSP:
{
	/*
	Running_script = 1
	GOsub, ArborFullScreen
	Sleep 500
	Send {AltDown}{ShiftDown}{t}{ShiftUP}{altup}
	sleep 300
	WinwaitActive, Table Insert,,3
	Sleep 300
	Send {Tab}{Right}{Tab}
	Sleep 300
	Send {2}{1}{Tab}{5}{Enter}
	Sleep 300
	Send {I}{t}{e}{m}{Right}
	Sleep 300
	Send {Q}{t}{y}{Right}
	Sleep 300
	Send {Item}
	Sleep 300
	Send {P}{a}{r}{t}{Space}{N}{u}{m}{b}{e}{r}{right}
	Sleep 300
	Send {P}{a}{r}{t}{Space}{N}{a}{m}{e}{right}
	Sleep 300
	Send {I}{l}{l}{u}{s}{t}{r}{a}{t}{i}{o}{n}{Space}{(}{S}{u}{b}{-}{s}{t}{e}{p}{)}{Space}{L}{o}{c}{a}{t}{i}{o}{n}
	Sleep 300 
	Send {Alt Down}{a}{s}{r}{Alt Up}
	Sleep 300
	Send {AltDown}{a}{h}{AltUp}
	Sleep 300
	Send {AltDown}{Numpad5}{AltUp}
	Sleep 300
	Send {AltDown}{a}{a}{altup}
	sleep 200
	WinwaitActive, Table Properties,,3
	Sleep 300
	Send {ShiftDown}{tab}{ShiftUp}{Right}{Right}{Right}{tab}{tab}{tab}{tab}{c}{e}{tab}{c}{e}{enter}{Down}{Right 4}
	Send Illustration%A_Space%`(`)
	Sleep 300
	Send {Alt Down}{a}{s}{c}{Alt Up}
	Sleep 300
	Send {Ctrl DOwn}{C}{Ctrl Up}
	Sleep 500
	Send {Shift Down}{Down 19}{Shift UP}
	Sleep 300
	Send {Ctrl DOwn}{V}{Ctrl Up}
	sleep 300
	If fullscreen = 1
	{
		CoordMode, mouse, Relative
		MouseMove 300,10
		Click
		Click
		Fullscreen = 0
		Coordmode, mouse, screen
		MouseMove, mmx, mmy
	}
	Running_script = 0
	*/
	
	Return
}

Createtable() ; CreateTabel function
{
	Temptag = %clipboardall% 
	;msgbox, tabletype is %Tabletype% `n Pgwd is %Pgwd%
	Gui 6:Destroy ; gets rid of the gui screen
	sleep 500 ; pauses scipt for .5 seconds
	clipboard =   ; clears the clipboard contents
	Send {AltDown}{ShiftDown}{t}{ShiftUP}{altup} ; send the Alt+Shift+ T to the computer.
	sleep 500 ; pauses script for .5 seconds
	WinwaitActive, %Table_Insert_Title%,,5 ; waits for the Table INsert window to be active
	sleep 500 ; pauses script for .5 seconds
	send {Enter} ; sends Enter to computer
	Sleep 500 ; pauses script for .5 seconds
	Send {SHift Down}{up} ; sends Shift down and then UP to the computer
	sleep 500 ; pauses script for .5 seconds
	send {shift up} ; Send shift up to the computer to release the shift key
	sleep 500 ; pauses script for .5 seconds
	Send {ctrl down}{c}{ctrl up} ; sends Ctrl + c to teh computer to copy the table contents out
	sleep 100 ; pauses script for .5 seconds
	clipwait ;waits for the clipboard to have date in int
	string = %clipboard% ; stores that data into the variable "String"
	FoundPos := RegExMatch(String,"^`<table frame")
		;msgbox, %FoundPos%
		If FoundPos != 1
		{
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,Please put cursor in approiate location to create a table
		IfEqual, A_IsCompiled,1
					{
						Run, %A_ScriptFullPath% /Restart
					}
					
					
					Run, %A_ScriptFullPath% /Restart ; this methond allows the /restart to show in the command line, which prevents the splash image from loading on restart
					exitapp ; exits this verison of the app
					Return
		}
		
		
	If String Contains id
	{
		Send {ctrl down}{x}{ctrl up}
	}else  {
		Send {SHift Down}{up} ; sends Shift down and then UP to the computer
		sleep 200 ; pauses script for .5 seconds
		send {shift up} ; Send shift up to the computer to release the shift key
		sleep 200 ; pauses script for .5 seconds
	
		
		Send {ctrl down}{x}{ctrl up} ; sends Ctrl + X to teh computer to cut the table contents out
		sleep 100
		Clipwait
		string = %clipboard% ; stores that data into the variable "String"
	}
	RegExMatch(string,"id=""(.*)""", BitInTheMiddle) ; Finds the Xref number (ie.. i00000001.37)
	newword := "`" BitInTheMiddle1 `"" ; puts that information into the "newword" variable
	NewwordGUi := BitInTheMiddle1 ; stores for table gui screen
	Fronttext := "<table frame=""all"" id=" ; Puts that information into the "fronttext" variable
	NewStrfront := SubStr(newword, 1 ,1)
	NewStrrear := SubStr(newword, 2 ,12)
	newwordftnote := (NewStrrear + .01)
	Newword := NewStrfront NewStrrear
	newwordftnote := NewStrfront newwordftnote
	;msgbox, newword is %newword%`, newwordftnote is %newwordftnote%
	gosub, TableChoiceGUI
	Pausescript()
	If Pgwd = Yes ; checks if the PGwd variable is yes
	{
		Pagewidecheck := " pgwide=""1""" ; adds the information to "pagewidecheck" variable
	}
	
	If Pgwd = no ; checks if pgwd is no
	{
		Pagewidecheck := ""  ; makes the variable blank
	}
	;msgbox, Tabletype is %Tabletype%
	
	If Tabletype = C2 ; If the "tabletype" variable is C2 then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup align=""center"" cols=""2"">
		<colspec colname=""col1"" colwidth=""33.12pt""/>
		<colspec colname=""col2"" colwidth=""2.00*""/>
		<thead>
		<row valign=""middle"">
		<entry nameend=""col2"" namest=""col1""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Parts List</entry>
		</row>
		<row valign=""middle"">
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?>Qty</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Part</entry>
		</row>
		</thead>
		<tbody>"
		
		Reartextrows := "<row valign=""middle"">
		<entry colname=""col1""></entry>
		<entry colname=""col2""><cpn-id><partno></partno><cpn></cpn></cpn-id></entry>
		</row>"
		
		Reartextrowstotal = 
		
		Loop, %Userrows%
		{
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		Reartextend := "</tbody>
		</tgroup>
		</table>"
		reartext := reartext reartextrowstotal reartextend
	}
	
	if tabletype = toolingtable
	{
		reartext := ">
		<tgroup align=""center"" cols=""3"">
		<colspec colname=""col1"" colwidth=""33.12pt""/>
		<colspec colname=""col2"" colwidth=""33.12pt""/>
		<colspec colname=""col3"" colwidth=""3.00*""/>
		<thead>
		<row valign=""middle"">
		<entry nameend=""col3"" namest=""col1""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Required Tools</entry>
		</row>
		<row valign=""middle"">
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?>Item</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Qty</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Part</entry>
		</row>
		</thead>
		<tbody>"
		
		Reartextrowstotal = 
		Letteroutput = 0
		Loopcounter = 1
		ASCII = 65	

		Loop, %Userrows%
		{
		
		Transform, OutputChar, Chr, %ASCII%
		
		If ASCii = 91
		{
		Ascii = 65
		Letteroutput++
		}
		
		If (ASCii = 79) || (ASCii = 81) || (ASCii = 73) 
		{
		Ascii++
		Transform, OutputChar, Chr, %ASCII%
		}
	
		
		If Letteroutput != 0
		{				
		Asciifirst := (64 + letteroutput)
		If Asciifirst = 73 | 79 | 81
		{
		Asciifirst++
		}
		Transform, OutputCharfirst, Chr, %Asciifirst%
		outputchar := OutputCharfirst outputchar
		}
		
		Reartextrows := "<row valign=""middle"">
		<entry colname=""col1"">" OutputChar "</entry>
		<entry colname=""col2""></entry>
		<entry colname=""col3""><cpn-id><partno></partno><cpn></cpn></cpn-id></entry>
		</row>"
		loopcounter++
		
		
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		AscII++
		}
		
		
		Reartextend := "</tbody>
		</tgroup>
		</table>"
		
		reartext := reartext reartextrowstotal reartextend
		
		
	}
	
	If tabletype = C5 ; If the "tabletype" variable is C5 then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup align=""center"" cols=""5"">
		<colspec colname=""col1"" colwidth=""33.12pt""/>
		<colspec colname=""col2"" colwidth=""33.12pt""/>
		<colspec colname=""col3"" colwidth=""70.77pt""/>
		<colspec colname=""col4"" colwidth=""2.51*""/>
		<colspec colname=""col5"" colwidth=""2.51*""/>
		<thead>
		<row valign=""middle"">
		<entry nameend=""col5"" namest=""col1""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Parts List</entry>
		</row>
		<row valign=""middle"">
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?>Item</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Qty</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>New Part</para><para>Number</para></entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Part Name</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>Former Part</para><para>Number</para> <fn id=""" newwordftnote """>
		<para>The former part number listed is for reference only and may differ.</para>
		</fn></entry>
		</row>
		</thead>
		<tbody>"
		
		
		Reartextrowstotal = 
		Loopcounter = 1
		Loop, %Userrows%
		{
		Reartextrows := "<row valign=""middle"">
		<entry colname=""col1"">" loopcounter "</entry>
		<entry colname=""col2""></entry>
		<entry colname=""col3""><partno></partno></entry>
		<entry colname=""col4""><cpn></cpn></entry>
		<entry colname=""col5""><partno></partno></entry>
		</row>"
		
		loopcounter++
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		Reartextend := "</tbody>
		</tgroup>
		</table>"
		
		reartext := reartext reartextrowstotal reartextend
	}
	
	If tabletype = C3 ; If the "tabletype" variable is C3 then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup align=""center"" cols=""3"">
		<colspec colname=""col1"" colwidth=""33.12pt""/>
		<colspec colname=""col2"" colwidth=""33.12pt""/>
		<colspec colname=""col3"" colwidth=""3.00*""/>
		<thead>
		<row valign=""middle"">
		<entry nameend=""col3"" namest=""col1""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Parts List</entry>
		</row>
		<row valign=""middle"">
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?>Item</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Qty</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Part</entry>
		</row>
		</thead>
		<tbody>"
		
		Reartextrowstotal = 
		Loopcounter = 1
		Loop, %Userrows%
		{
		Reartextrows := "<row valign=""middle"">
		<entry colname=""col1"">" loopcounter "</entry>
		<entry colname=""col2""></entry>
		<entry colname=""col3""><cpn-id><partno></partno><cpn></cpn></cpn-id></entry>
		</row>"
		loopcounter++
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		
		Reartextend := "</tbody>
		</tgroup>
		</table>"
		
		reartext := reartext reartextrowstotal reartextend
		
	}
	If tabletype = C5 ; If the "tabletype" variable is C5 then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup align=""center"" cols=""5"">
		<colspec colname=""col1"" colwidth=""33.12pt""/>
		<colspec colname=""col2"" colwidth=""33.12pt""/>
		<colspec colname=""col3"" colwidth=""70.77pt""/>
		<colspec colname=""col4"" colwidth=""2.51*""/>
		<colspec colname=""col5"" colwidth=""2.51*""/>
		<thead>
		<row valign=""middle"">
		<entry nameend=""col5"" namest=""col1""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Parts List</entry>
		</row>
		<row valign=""middle"">
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?>Item</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Qty</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>New Part</para><para>Number</para></entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?>Part Name</entry>
		<entry><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>Former Part</para><para>Number</para> <fn id=""" newwordftnote """>
		<para>The former part number listed is for reference only and may differ.</para>
		</fn></entry>
		</row>
		</thead>
		<tbody>"
		
		
		Reartextrowstotal = 
		Loopcounter = 1
		Loop, %Userrows%
		{
		Reartextrows := "<row valign=""middle"">
		<entry colname=""col1"">" loopcounter "</entry>
		<entry colname=""col2""></entry>
		<entry colname=""col3""><partno></partno></entry>
		<entry colname=""col4""><cpn></cpn></entry>
		<entry colname=""col5""><partno></partno></entry>
		</row>"
		
		loopcounter++
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		Reartextend := "</tbody>
		</tgroup>
		</table>"
		
		reartext := reartext reartextrowstotal reartextend
	}
	
	If tabletype = Jcode ; If the "tabletype" variable is Jcode then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup cols=""3"">
		<colspec colname=""col1""/>
		<colspec colname=""col2""/>
		<colspec colname=""col3""/>
		<thead>
		<row valign=""middle"">
		<entry align=""center""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?><para>J1939 Code and Description</para></entry>
		<entry align=""center""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?> <para>CDL Code and Description</para></entry>
		<entry align=""center""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?> <para>Comments</para></entry>
		</row>
		</thead>
		<tbody>"
		
		Reartextrows := "<row>
		<entry valign=""middle""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?><para><code></code></para><para><codedesc></codedesc></para></entry>
		<entry valign=""middle""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para><code></code></para><para><codedesc></codedesc></para></entry>
		<entry valign=""middle""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para></para></entry>
		</row>"
		
		Reartextrowstotal = 
		
		Loop, %Userrows%
		{		
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		Reartextend :=  "</tbody>
		</tgroup>
		</table>"
		
		reartext := reartext reartextrowstotal reartextend
	}
	
	
	If tabletype = Troubleshoot ; If the "tabletype" variable is Troublechoot then this data will be stored in "reartext" variable
	{
		reartext := ">
		<tgroup cols=""3"">
		<colspec colname=""col1"" colwidth=""1.50*""/>
		<colspec align=""center"" colname=""col2"" colwidth=""95.36pt""/>
		<colspec colname=""col3"" colwidth=""1.50*""/>
		<thead>
		<row>
		<entry valign=""top""><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Troubleshooting Test Steps</entry>
		<entry valign=""middle""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Values</entry>
		<entry valign=""top""><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?>Results</entry>
		</row>
		</thead>
		<tbody>"
		
		Userrows--
		Reartextrowstotal = 
		Loopcounter = 1
		Loop, %Userrows%
		{
		Reartextrows := "<row>
		<entry colname=""col1""><?Pub _newline?><para><emphasis> " Loopcounter ". </emphasis></para><?Pub _newline?><para><emphasis>A.</emphasis></para><?Pub _newline?></entry>
		<entry colname=""col2"" valign=""middle""><?Pub _newline?><para></para></entry>
		<entry colname=""col3""><?Pub _newline?><para><emphasis>Result:</emphasis></para><?Pub _newline?><para>Proceed to Test Step </para><?Pub _newline?><para><emphasis>Result:</emphasis></para><?Pub _newline?><para><emphasis>Repair:</emphasis></para><?Pub _newline?><para>If the problem is not resolved, proceed to Test Step</para><?Pub _newline?></entry>
		</row>"
		Loopcounter++
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		Reartextend := "<row>
		<entry colname=""col1""><?Pub _newline?><para><emphasis> " Loopcounter ". </emphasis></para><?Pub _newline?><para><emphasis>A.</emphasis></para><?Pub _newline?></entry>
		<entry colname=""col2"" valign=""middle""><?Pub _newline?><para></para></entry>
		<entry colname=""col3""><?Pub _newline?><para><emphasis>Result:</emphasis></para><?Pub _newline?><para>Proceed to Test Step </para><?Pub _newline?><para><emphasis>Result:</emphasis></para><?Pub _newline?><para><emphasis>Repair:</emphasis></para><?Pub _newline?><para>Verify that the repair eliminated the problem.</para><?Pub _newline?></entry>
		</row>
		</tbody>
		</tgroup>
		</table>"
		reartext := reartext reartextrowstotal reartextend
	}
	
	
	If Tabletype = Spec ; If the "tabletype" variable is spec then this data will be stored in "reartext" variable
	{
	
		reartext := ">
		<tgroup cols=""4"">
		<?PubTbl tgroup clmarg=""2.0pt"" crmarg=""2.0pt""?>
		<colspec colname=""col1"" colwidth=""37*""/>
		<colspec colname=""col2"" colwidth=""39*""/>
		<colspec colname=""col3"" colwidth=""75*""/>
		<colspec colname=""col4"" colwidth=""229*""/>
		<thead>
		<row>
		<entry align=""center"" nameend=""col4"" namest=""col1"" valign=""middle""><?Pub _cellfont Weight=""bold""?><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt"" border-top-width=""0.20pt""?><para>Specification for <cpn-id><partno></partno><cpn></cpn></cpn-id></para></entry>
		</row>
		<row>
		<entry align=""center"" valign=""middle""><?Pub _cellfont Weight=""bold""?><?PubTbl cell border-bottom-width=""0.20pt"" border-left-width=""0.20pt"" border-right-width=""0.20pt""?><para>Item</para></entry>
		<entry align=""center"" valign=""middle""><?Pub _cellfont Weight=""bold""?><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>Qty</para></entry>
		<entry align=""center"" valign=""middle""><?Pub _cellfont Weight=""bold""?><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>Part</para></entry>
		<entry align=""center"" valign=""middle""><?Pub _cellfont Weight=""bold""?><?PubTbl cell border-bottom-width=""0.20pt"" border-right-width=""0.20pt""?><para>Specification Description</para></entry>
		</row>
		</thead>
		<tbody>"

		
		Reartextrowstotal = 
		Loopcounter = 1
		Loop, %Userrows%
		{
		Reartextrows := "<row>
		<entry align=""center"" valign=""middle""><para>" Loopcounter "</para></entry>
		<entry align=""center"" valign=""middle""><para></para></entry>
		<entry align=""center"" valign=""middle""><para><cpn-id><partno></partno><cpn></cpn></cpn-id></para></entry>
		<entry></entry>
		</row>"
				
		loopcounter++
		Reartextrowstotal = %Reartextrowstotal%%Reartextrows%
		}
		
		Reartextend :=  "</tbody>
		</tgroup>
		</table>"
		reartext := reartext reartextrowstotal reartextend
	}
	
	Tabletext := Fronttext newword Pagewidecheck reartext ; combines all teh variables together and stores them into the "tabletext" variable
	
	clipboard = %Temptag% 
	Return tabletext ; sends the Tabletext variable information back
}              
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Loads HotKeys Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		SetHotKeys:
		{
			+++SetTitleMatchMode, 3 ; window title has to match exactly with text
			Hotkey, IfWinActive, %Search_Window_Title% ; hotkey only works in search window
			Hotkey, $%SearchHotKey%, SearchRapidArbor ; makes the contents of the searchhotkey variable go to SearchrapidSearch subroutine
			#IfWinActive ; clears the have to be in search window
			
			+++SetTitleMatchMode, 2 ; window title must contain the text
			HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
			Hotkey, $%CPNHotKey%, CPNRapid ; makes the contents of the CPNhotkey variable go to CPNrapid subroutine, also turn the hotkey on
			Hotkey, $^%CPNHotKey%, CPNRapidautofill  ; makes the Ctrl + contents of the  CPNhotkey variable go to CPNrapidautofill subroutine, also turn the hotkey on
			Hotkey, $%METHotKey%, METRapid ; makes the contents of the  METhotkey variable go to METrapid subroutine, also turn the hotkey on
			Hotkey, $%CHKHotKey%, CHKRapid ; makes the contents of the  CHKhotkey variable go to CHKRapid subroutine, also turn the hotkey on
			Hotkey, $%TableHotKey%, TableRapid ; makes the contents of the  Tablehotkey variable go to TableRapid subroutine, also turn the hotkey on
			Hotkey, $%SearchHotKey%, SearchRapidArbor ; makes the contents of the Searchhotkey variable go to SearchRapidArbor subroutine, also turn the hotkey on
			
			HotKey, IfWinActive,%Canvas_Service_Window_Title%; this hotkey only works in the cavas service window
			Hotkey, $%SearchHotKey%, SearchRapidCanvas ; makes the contents of the Searchhotkey variable go to SearchRapidCanvas subroutine, also turn the hotkey on
			
			Hotkey, IfWinActive,  %Canvas_Window_Title% ; this hotkey only works in Canvas 14 for windchill
			Hotkey, $%SearchHotKey%, CanvasRapid ; makes the contents of the Searchhotkey variable go to CanvasRapid subroutine, also turn the hotkey on
			Return
		}
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create the  Gui screens ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		
;This makes up the win+alt screen
Guiscreen:
{
	If GuiNumber !=0 ; If guiscreeen vairable is not 0
	Gui , %GuiNumber%:Destroy ; closes the gui screen
;Below is making the menu for the gui screen
		
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
	Gui ,%GuiNumber%:Add, Text, xs+3 ys+110 w465, If The Search Function seems to try to enter the CPN on the wrong location, Delete the image files in %Root_Folder_Location%/UserImages to reset the search parameters.
	
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
	Gui, %GuiNumber%:Add,Text, xp yp+20  BackgroundTrans gboxlink, %Program_Site%
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
IniWrite, %autocheckbox%, %Root_Folder_Location%\ArbortextMacroSettings.ini, Autofull, autocheckbox
Return
}

Howto:
{
	splashtexton,,Arbortext Macro, Loading PDF
	Run, %Root_Folder_Location%\How to use Arbortext Macros.pdf
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
	Run, %Program_Site%
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

	GuiControlGet, 
	
	If (CpnUN = "1")
	{
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
		Hotkey, $%CPNHotKey%, Off
		Hotkey, $^%CPNHotKey%, Off
		CPNHotKey = *
	}
	If (CpnUN != "1")
	{
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
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
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
		Hotkey, $%SearchHotKey%, Off
		
		HotKey, IfWinActive, %Canvas_Service_Window_Title% ; this hotkey only works in the cavas service window
		Hotkey, $%SearchHotKey%, Off
		Hotkey, IfWinActive,  %Canvas_Window_Title% ; this hotkey only works in Canvas  for windchill
		Hotkey, $%SearchHotKey%, Off
		
		+++SetTitleMatchMode, 3
		Hotkey, IfWinActive, %Search_Window_Title% ; hotkey only works in search window
		Hotkey, $%SearchHotKey%, Off
		
		SearchHotKey = *
		+++SetTitleMatchMode,2
	}
	
	
	If (SearchUN != "1")
	{
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		
		HotKey, IfWinActive, %Canvas_Service_Window_Title% ; this hotkey only works in the cavas service window
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		Hotkey, IfWinActive,  %Canvas_Window_Title%  ; this hotkey only works in Canvas 14 for windchill
		Hotkey, $%SearchHotKey%, SearchRapidArbor,on
		Hotkey, IfWinActive, %Search_Window_Title% ; hotkey only works in search window
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
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
		Hotkey, $%TableHotKey%, Off
		TableHotKey = *
	}
	
	If (TableUN != "1")
	{
		HOTKEY, IfWinActive, %Arbortext_Window_Title% ; these hotkeys work only in Arbortext
		Hotkey, $%TableHotKey%, TableRapid, on	
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
		
		
		/*		
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Canvas search screen Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
		*/
		
		
		+++SetTitleMatchMode, 2 ; sets window requirements to exact match
		
		;canvassucceed subroutine
		CavnasSucceed:
		{
			IfWinExist, %Canvas_Succeeded_Window_Title% ; checks to see if the ACM Save2WC Function Succeeded window exists
			{
				SetTimer, CavnasSucceed, off ; Turns off the timer
				Sleep 500 ; pauses script for .5 seconds
				Win_Activate(Canvas_Succeeded_Window_Title)
				Send {Enter} ; sends enter to window
				Sleep 300 ; pauses for 300 milliseconds
				ErrorLevel := Win_Activate(Search_Window_Title)				
				If ErrorLevel = 1 ; if times out, exists subroutine
				{
					Exit ; stops subroutine
				}
				else  {
					sleep 500
					Send {Enter} ; send enter key to window
					sleep 500
					WinWaitActive, Browser_Window_Title,,10 ; waits for the browser window to be opened and active window. waits 10 seconds before timeout
					If ErrorLevel = 1 ; if times out, stops subroutine
					{
						Exit ; stops subroutine
					}else  {
						Sleep 1000 ; pauses 1 second
					Win_Activate(Search_Window_Title)
					sleep 400 ;pauses .4 second
					Send {Esc} ; sends escape
					Sleep 500 ; pauses 500 miliseond
					Win_Activate(Browser_Window_Titles)
					SetTimer, CavnasSucceed, Off ; turns off the check every .5 second for ACM Save2wc window
					}}}
					Else IfWinNotExist, %Canvas_Succeeded_Window_Title%  ; if window does not exists, it just goes back to the previous function
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
				
				
				;Esc key will stop any loops in arbortext.
				+++SetTitleMatchMode, 2 ; window title must contain the wording
				#If WinActive(Arbortext_Window_Title) ; window must contain arbortext for Esc key to work this way
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
				
				#If ; stops any in only arbortext requirement
				
				/*		
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Saves to INI File Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
				*/
				
				Settings_save:
{
	if not (FileExist(Root_Folder_Location "\ArbortextMacroSettings.ini")) ; if ini file isnt there it makes one
	{
		FileAppend,, %Root_Folder_Location%\ArbortextMacroSettings.ini
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
	if not (FileExist(Root_Folder_Location "\ArbortextMacroSettings.ini"))
	{
		FileAppend,,%Root_Folder_Location%\ArbortextMacroSettings.ini
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
	GuiControl,, CPNF1, 1
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
					ErrorLevel := Win_Activate(Arbortext_Window_Title)
					If ErrorLevel = 1 ; if the search window is not open. subroutine will stop.
					{
						msgbox, error
						Return "2" ; returns 2 to say it timed out.
					}
					Sleep 500
					Send {Alt Down}{o}{Alt Up}{e} ; sends keystrokes to computer to open the search window
					sleep 300 ; delays program for 100 milliseconds
					WinWaitActive, %Search_Window_Title%,,10 ;Waits for search window to be the active window. Stops wait after 5 seconds
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
				
				Create_Tray_Menu()
				{
					
					Menu, tray, NoStandard
					Menu, tray, Add, Arbortext Macros  ,Guiscreen ;make the title of the menu
					Menu, tray, Default,Arbortext Macros  ; makes this the top line in the menu
					Menu,Tray, Disable, Arbortext Macros ; disables it so it is greyed out
					Menu, tray, add, Hotkey Cheat Sheet, Guiscreen ; Creates a new menu item. ; goes to gui screen
					Menu, tray, add, Options, Optionsmenu ; Goes to options screen
					Menu, tray, add, Check For Update, Versioncheck ; goes to version check
					Menu, tray, add, About, Aboutmenu ; OPens about menu
					Menu, tray, add, Quit, Quitapp ; quit macro
					
					IfExist, %Root_Folder_Location%\diag.Ini
					{
						IniRead, Tray_standard, %Root_Folder_Location%\diag.ini, Tray, Tray_standard
						If Tray_standard = 0
							Menu, tray, Standard
					}
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
					
					IfWinExist %Arbortext_Window_Title% ; if Arbortext window exists
					{
						+++SetTitleMatchMode, 3 ; sets search for window titles to be exact match
						IfWinExist %Search_Window_Title%  ; window has to say exactly Search in title and if search window is open
						{
							Win_Activate(Search_Window_Title)
							sleep 200
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
				
				Win_Activate(Canvas_Service_Window_Title)
				sleep 400
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
aX      := curMonLeft
ay      := curMonTop
aHeight := curMonBottom - curMonTop
aWidth  := curMonRight  - curMonLeft
return
}
}
}


	Pausescript()
		{
			Menu,Tray,Icon, %Root_Folder_Location%"\icons\paused.ico", ,1
			Pause,on
			Return
		}

		UnPausescript()
	{
		Menu,Tray,Icon, %Root_Folder_Location%"\icons\am.ico", ,1
		Pause,off
		Return
		}
		
		Licensinginfo()
			{
				Msgbox, Unless otherwise stated, All content of this script unless otherwise noted was created by Jarett Karnia for the use of Caterpillar, Inc `n This script Can be used and modified as needed. But Must give credit to Orginal creaters of the content (including the libraries) and state what was changed from the orginal source code.
				Return
			
			
			}
		
#`::Listlines              

#if 

/*
**********************************************************************************************************************************
************************************************* Version check section********************************************************
**********************************************************************************************************************************
*/

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



Win_Activate(Win_title)
{
	WinActivate %Win_title%
	Sleep 50
	WinWaitActive,  %Win_title%,,5
	Sleep 100
	return ErrorLevel
}
	

/*
********************************************************************************************************************************************************************************************************************************************************************
****************************************************************************** Load INI File Section ************************************************************************************************************************************************************
*****************************************************************************************************************************************************************************************************************************************************************
*/



Load_ini_file(inifile)
 {
	global
	
	Ini_var_store_array:= Object()
		loop,read,%inifile%
  {
	If A_LoopReadLine = 
		continue
	
    if regexmatch(A_Loopreadline,"\[(.*)?]")
      {
        Section :=regexreplace(A_loopreadline,"(\[)(.*)?(])","$2")
		StringReplace, Section,Section, %a_space%,,All
		continue
      }

    else if A_LoopReadLine != 
      { 
		StringGetPos, keytemppos, A_LoopReadLine, =,
		StringLeft, keytemp, A_LoopReadLine,%keytemppos%
		StringReplace, keytemp,keytemp,%A_SPace%,,All
		INIstoretemp := Keytemp ":" Section
			Ini_var_store_array.Insert(INIstoretemp)
		IniRead,%keytemp%, %inifile%, %Section%, %keytemp%	
      }
  }
	
	return
}


Write_ini_file(inifile)
{
	global

	for index, element in Ini_var_store_array 
	{	
	StringSplit, INI_Write,element, `:

	Varname := INI_Write1
			IniWrite ,% %INI_Write1%, %inifile%, %INI_Write2%, %INI_Write1%
		
      } 
	
	return
}


/*
********************************************************************************************************************************************************************************************************************************************************************
******************************************************************************Lib section ************************************************************************************************************************************************************
*****************************************************************************************************************************************************************************************************************************************************************
*/

; The credit to this library goes to HotKeyIt, who posted this code at https://autohotkey.com/board/topic/35566-rapidhotkey/
; His licensing information is stated as public domain and in this link: https://autohotkey.com/board/topic/60951-hotkeyits-default-license/
; I recommed you do not mess around with it as it is stable. 

RapidHotkey(keystroke, times="1", delay=.5, IsLabel=0)
{
	Pattern := Morse(delay*1000)
	If (StrLen(Pattern) < 2 and Chr(Asc(times)) != "1")
		Return
	If (times = "" and InStr(keystroke, """"))
	{
		Loop, Parse, keystroke,""	
			If (StrLen(Pattern) = A_Index+1)
				continue := A_Index, times := StrLen(Pattern)
	}
	Else if (RegExMatch(times, "^\d+$") and InStr(keystroke, """"))
	{
		Loop, Parse, keystroke,""
			If (StrLen(Pattern) = A_Index+times-1)
				times := StrLen(Pattern), continue := A_Index
	}
	Else if InStr(times, """")
	{
		Loop, Parse, times,""
			If (StrLen(Pattern) = A_LoopField)
				continue := A_Index, times := A_LoopField
	}
	Else if (times = "")
		continue := 1, times := 2
	Else if (times = StrLen(Pattern))
		continue = 1
	If !continue
		Return
	Loop, Parse, keystroke,""
		If (continue = A_Index)
			keystr := A_LoopField
	Loop, Parse, IsLabel,""
		If (continue = A_Index)
			IsLabel := A_LoopField
	hotkey := RegExReplace(A_ThisHotkey, "[\*\~\$\#\+\!\^]")
	IfInString, hotkey, %A_Space%
		StringTrimLeft, hotkey,hotkey,% InStr(hotkey,A_Space,1,0)
	backspace := "{BS " times "}"
	keywait = Ctrl|Alt|Shift|LWin|RWin
	Loop, Parse, keywait, |
		KeyWait, %A_LoopField%
	If ((!IsLabel or (IsLabel and IsLabel(keystr))) and InStr(A_ThisHotkey, "~") and !RegExMatch(A_ThisHotkey
	, "i)\^[^\!\d]|![^\d]|#|Control|Ctrl|LCtrl|RCtrl|Shift|RShift|LShift|RWin|LWin|Alt|LAlt|RAlt|Escape|BackSpace|F\d\d?|"
	. "Insert|Esc|Escape|BS|Delete|Home|End|PgDn|PgUp|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|AppsKey|"
	. "PrintScreen|CtrlDown|Pause|Break|Help|Sleep|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|"
	. "Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|MButton|RButton|LButton|"
	. "Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2"))
		Send % backspace
	If (WinExist("AHK_class #32768") and hotkey = "RButton")
		WinClose, AHK_class #32768
	If !IsLabel
		Send % keystr
	else if IsLabel(keystr)
		Gosub, %keystr%
	Return
}	
Morse(timeout = 400) { ;by Laszo -> http://www.autohotkey.com/forum/viewtopic.php?t=16951 (Modified to return: KeyWait %key%, T%tout%)
   tout := timeout/1000
   key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
   IfInString, key, %A_Space%
		StringTrimLeft, key, key,% InStr(key,A_Space,1,0)
	If Key in Shift,Win,Ctrl,Alt
		key1:="{L" key "}{R" key "}"
   Loop {
      t := A_TickCount
      KeyWait %key%, T%tout%
		Pattern .= A_TickCount-t > timeout
		If(ErrorLevel)
			Return Pattern
    If key in Capslock,LButton,RButton,MButton,ScrollLock,CapsLock,NumLock
      KeyWait,%key%,T%tout% D
    else if Asc(A_ThisHotkey)=36
		KeyWait,%key%,T%tout% D
    else
      Input,pressed,T%tout% L1 V,{%key%}%key1%
	If (ErrorLevel="Timeout" or ErrorLevel=1)
		Return Pattern
	else if (ErrorLevel="Max")
		Return
   }
}

