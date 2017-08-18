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