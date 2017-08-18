;Creates the needed Folders if they dont Exist

IfNotExist,  c:\ArbortextMacros
{
	FileCreateDir, c:\ArbortextMacros
}

IfNotExist, C:\ArbortextMacros\UserImages
{
	FileCreateDir, C:\ArbortextMacros\UserImages
}
IfNotExist, C:\ArbortextMacros\Icons
{
	FileCreateDir, C:\ArbortextMacros\Icons
}
IfNotExist, C:\ArbortextMacros\ProgramImages
{
	FileCreateDir, C:\ArbortextMacros\ProgramImages
}

IfNotExist, C:\ArbortextMacros\ArbortextMacroSettings.ini
{
	;below takes the files fron the marcosn folder on computer and embeds them into the exe file. 
	FileInstall, C:\ArbortextMacrosn\ArbortextMacroSettings.ini, C:\ArbortextMacros\ArbortextMacroSettings.ini
	Firstrun = 1
}

FileInstall, C:\ArbortextMacrosn\How to use Arbortext Macros.pdf, C:\ArbortextMacros\How to use Arbortext Macros.pdf,1

IfNotExist, C:\ArbortextMacros\icons\paused.ico
{
	;below takes the files fron the marcosn folder on my computer and embeds them into the exe file. 
	FileInstall,C:\ArbortextMacrosn\icons\paused.ico, C:\ArbortextMacros\icons\paused.ico
}

IfNotExist, C:\ArbortextMacros\icons\am.ico
{
	;below takes the files fron the marcosn folder on my computer and embeds them into the exe file. 
	FileInstall,C:\ArbortextMacrosn\icons\am.ico, C:\ArbortextMacros\icons\am.ico
}

;================================================================

; INstalls the needed files for the auto search

FileInstall,C:\ArbortextMacrosn\ProgramImages\Box.png, C:\ArbortextMacros\ProgramImages\Box.png,0     

FileInstall,C:\ArbortextMacrosn\ProgramImages\SplashinmageAM.png, C:\ArbortextMacros\ProgramImages\SplashinmageAM.png,1

FileInstall, C:\ArbortextMacrosn\CPNSearch.exe, C:\ArbortextMacros\CPNSearch.exe,1

IfExist, C:\ArbortextMacros\ProgramImages\BG.png
	FileDelete, C:\ArbortextMacros\ProgramImages\BG.png


IfExist, C:\ArbortextMacros\Change Log.txt
{
	FileDelete, C:\ArbortextMacros\Change Log.txt
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