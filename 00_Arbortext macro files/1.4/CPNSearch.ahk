#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir   %A_MyDocuments%\AutoHotkey\Lib\ ; Ensures a consistent starting directory.

#include <Gdip>
#include <Gdip_ImageSearch>

#NoTrayIcon
SystemCursor("On")
pToken := Gdip_Startup()

Mousemove, 100,100
SetKeyDelay, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetBatchLines -1
ox =
oy= 
needlecount = 0
CurrMon := 
FileCount := 
Scrollcount = 0
+++SetTitleMatchMode, 2
WinActivate, Arbortext
Sleep 500
WinGetTitle, Temptitle,a
Iniread, Scrolldown, C:\ArbortextMacros\ArbortextMacroSettings.ini, Autofull, autocheckbox
ToolTip, Loading image files for CPN search
SetTimer, RemoveToolTip, 1500
;Gosub, Monitorareas
Filecount := ComObjCreate("Shell.Application").NameSpace("C:\ArbortextMacros\UserImages").Items.Count
Filecountend = %Filecount%
Loop, %Filecount%
{
Needlecount++
FileName := "C:\ArbortextMacros\UserImages\User_" needlecount ".png"
bmpNeedle%needlecount% := Gdip_CreateBitmapFromFile(FileName)
sleep 50
}
OnExit,EXIT_LABEL
BreakLoop := 0
sleep 100
;CoordMode, mouse, Screen
;Gosub, MaxArbortext
;WinMove, Arbortext,, X, Y, aaWidth, aaHeight
;msgbox, pause

Gosub, ArborFullScreenCPN
Sleep 500
WinActivate, %Temptitle%
Mousemove 500,500
Send {Click}
sleep 100
Send {Ctrl Down}{Pgup}{Ctrl Up}
sleep 300
If filecount = 0
{
Gosub, GUImessagebox
exit
}
;CoordMode, mouse, Relative
WinActivate %Temptitle%
mousemove 100, 100
Counter = 0
currMon := GetCurrentMonitor(Temptitle)
pToken := Gdip_Startup()
Gosub, Findloop
Return


Findloop:
{
Counter = 0

Loop, %needlecount%
	{
		Counter++
		bmpHaystack := Gdip_BitmapFromScreen(currMon)
		Sleep 150
		RETSearch := Gdip_ImageSearch(bmpHaystack,bmpNeedle%counter%,List,0,0,0,0,0,0,0,0)
		sleep 100
		If RETSearch > 0
		{
			mousemove, 100,100
			sleep 100
			GoSub, FillingCPN
			Gosub, EnterCPn
			
				If Scrolldown = 1
					{
					Foundcpn = 1
					Send {Pgdn}
					Sleep 500
					Gosub, Findloop					
					}
					ELse
					Gosub, finished
					
		}
		
		If RETSearch = 0
			{
				If Foundcpn = 1
				{
				send {Pgup}
				Gosub, finished
				break
				}
				Else 
					{
					Gdip_Shutdown(pToken)
					Gosub, GUImessagebox
					Return
					}			
			}
			
	}
	
	Return
}

EnterCPn:
{
CoordMode, mouse, Relative
Loop, Parse, LIST, `n
{
WinActivate, %Temptitle%
sleep 100
StringSplit, Coord, A_LoopField, `,
Gosub, Errorwindow
Sleep 50
winactivate, %Temptitle%
Sleep 50
Coord1 += 35
Coord2 += 8
Sleep 50
MouseMove, %Coord1%, %Coord2%, 0
Sleep 100
Click
sleep 100
GoSub, CPN
Sleep 50
GoSub, Errorwindow
}
Gosub, Errorwindow

}

Fillingcpn:
{
ToolTip, Finding and Filling CPN Tags. Press the ESC key to stop Autofill.
SetTimer, RemoveToolTip, 5000
Return
}
Errorwindow:
{
WinGetTitle, Title, A
If Title = PTC Arbortext Editor Response
{
Sleep 750
Send {esc}
Sleep 1000
Send {Esc}
Return
}
return
}
Errorwindowendstop:
{
SetTimer,Errorwindow, Off
return
}
CPN:
{
WinActivate, %Temptitle%
sleep 100
Send {Alt Down}{c}{Alt Up}
Sleep 100
Send {Enter}{Enter}
Sleep 300
Return
}

finished:
{
Gosub , Errorwindowendstop
ToolTip, Done
Sleep 2000
SetTimer, RemoveToolTip, 2000
Loop, %counter%
{
Gdip_DisposeImage(bmpNeedle%counter%)
counter--
}

ExitApp
}


GUImessagebox:
{
WinGetPos,px,py,ph,pw, Arbortext
ph /= 4
pw /= 3
px += %pw%
py += %ph%
Gui Color, White
Gui Add, Text, x10 y8 w419, Unable to find the Empty CPN tags. Please help me find them by using the buttons below. If There are no Empty CPN Tags shown, then Press the "Cancel" button and have an empty CPN tag shown in the Arbortext window. 
gui, add, text, xp yp+50 w419, If there are Empty CPN tags, then Click on the "Select Empty CPN Tags" button and follow the onscreen Directions to ensure that this does not happen again for the Zoom Level.
Gui Add, Button, xp+10 yp+75 w120 h50 gButtonCancel, Cancel
Gui Add, Button, xp+275 yp w120 h50 gButtonCPNtags +Default, Select Empty CPN tags

Gui Show,,Oops!!!
Gui, +AlwaysOnTop
WinMove Oops!!!,,px,py
return
}

ButtonCancel:
{
Gui, Destroy
ExitApp
}
ButtonCPNtags:
{
Gui, Destroy
Gosub, SelectCPNTagInst
return
}

SelectCPNTagInst:
{
Gui Add, Text, x10 y16 w490 , After You press the Okay Button the following will happen:
Gui Add, Text, xp yp+30 w490 , 1. The mouse cursor will become a red box and then the mouse and Arbortext window will become maximixed if it isnt already.
Gui Add, Text, xp yp+50 w490 , 2. You need to move the middle of the red box to the middle of the empty CPN tags. The box does not need to cover the entire tags. Just needs to be centered.
Gui Add, Text, xp yp+50 w490 , 3. Once the red box is centered, click the mouse.
Gui Add, Button, xp+50 yp+50 w75 h23 gdesSelectCPNTag, OK
Gui Show,, Instructions
Gui, +AlwaysOnTop
WinMove Instructions,,px,py
Return
}


desSelectCPNTag:
{
Gui, Destroy
Gosub, SelectCPNTag
return
}

SelectCPNTag:
{

WinActivate, %Temptitle%

Mousemove 100,100
sleep 300
countLoop := 1
Gosub, loopFileName
SystemCursor("Off")
WinActivate %Temptitle%
Gosub, Windowshow
KeyWait LButton,d
MouseGetPos Mox, Moy
SetTimer, watchcursor, Off
Gui Destroy
WinActivate, %Temptitle%
sleep 200

MouseGetPos Mox, Moy

SetTimer, Mouselock, 10
Sleep 100
Click
Send {Left}{Left}{Left}{Left}{Left}
WinActivate %Temptitle%
Sleep 100
Gosub, Capture
Sleep 500
SystemCursor("On")
SetTimer, Mouselock, Off
sleep 1000
Reload
Return
}

Mouselock:
{
mousemove %Mox%, %Moy%
Return
}

Capture:
{
;Coordmode, Mouse, screen


monitorar := GetCurrentMonitor(Temptitle)
;msgbox, %monitorar%
WinActivate %Temptitle%
Gosub,take_snapshot
return
}
loopFileName:
{
countLoopString := countLoop
newFileName := "C:\ArbortextMacros\UserImages\User_" countLoopString ".png"
IfExist, % newFileName
{
countLoop++
Goto, loopFileName
}
Return
}


take_snapshot:
{
WinActivate, %Temptitle%
activeMonitorInfo(amonX,AmonY,AmonW,AmonH,mx,my)
if PToken = 0
pToken := Gdip_Startup()

raster:=0x40000000 + 0x00CC0020
pBitmap := Gdip_BitmapFromScreen(monitorar,raster)
;Gdip_SaveBitmapToFile(pBitmap,imagesave)
pBitmap2 := Gdip_CreateBitmap(70,16)
G2 := Gdip_GraphicsFromImage(pBitmap2), Gdip_SetSmoothingMode(G2, 4), Gdip_SetInterpolationMode(G2, 7)
Gdip_DrawImage(G2, pBitmap, 0, 0, 70, 16, mox, moy, 70, 16)
Gdip_SaveBitmapToFile(pBitmap2, newFileName)
Gdip_DeleteGraphics(G2), Gdip_DisposeImage(pBitmap), Gdip_DisposeImage(pBitmap2)
Gdip_Shutdown(pToken)
return
}

Windowshow:
{
settimer, watchcursor,  5
gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
gui,  margin, 0, 0
Gui Add, Picture, x0 y0 w60 h16, C:\ArbortextMacros\ProgramImages\Box.png
Gui Show, w70 h16, movinggui
Gui, Color, FFFFFF
WinSet, TransColor, FFFFFF
Gui, +AlwaysOnTop
Winactivate %Temptitle%
return
}

WatchCursor:
{
CoordMode, mouse, screen
MouseGetPos, oX, oY
WinMove, movinggui,,oX, oY
return
}


SystemCursor(OnOff=1)
{
static AndMask, XorMask, $, h_cursor
,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13
, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13
, h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13
if (OnOff = "Init" or OnOff = "I" or $ = "")
{
$ = h
VarSetCapacity( h_cursor,4444, 1 )
VarSetCapacity( AndMask, 32*4, 0xFF )
VarSetCapacity( XorMask, 32*4, 0 )
system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
StringSplit c, system_cursors, `,
Loop %c0%
{
h_cursor   := DllCall( "LoadCursor", "Ptr",0, "Ptr",c%A_Index% )
h%A_Index% := DllCall( "CopyImage", "Ptr",h_cursor, "UInt",2, "Int",0, "Int",0, "UInt",0 )
b%A_Index% := DllCall( "CreateCursor", "Ptr",0, "Int",0, "Int",0
, "Int",32, "Int",32, "Ptr",&AndMask, "Ptr",&XorMask )
}
}
if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
$ = b
else
$ = h
Loop %c0%
{
h_cursor := DllCall( "CopyImage", "Ptr",%$%%A_Index%, "UInt",2, "Int",0, "Int",0, "UInt",0 )
DllCall( "SetSystemCursor", "Ptr",h_cursor, "UInt",c%A_Index% )
}
}

#IfWinActive
~esc::
{
BreakLoop := 1
SystemCursor("On")
GoSub, EXIT_LABEL
ExitApp
}
EXIT_LABEL:
{
SystemCursor("On")
Exitapp
}

+++Settitlematchmode,2
GetCurrentMonitor(Temptitlea)
{
SysGet, numberOfMonitors, MonitorCount
WinGetPos, winX, winY, winWidth, winHeight, %temptitlea%
winMidX := winX + winWidth / 2
winMidY := winY + winHeight / 2
Loop %numberOfMonitors%
{
SysGet, monArea, Monitor, %A_Index%
if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop)
return A_Index
}
SysGet, MonitorPrimary, MonitorPrimary
return "No Monitor Found"
}

activeMonitorInfo( ByRef aX, ByRef aY, ByRef aWidth,  ByRef  aHeight, ByRef mouseX, ByRef mouseY  )
{
CoordMode, Mouse, Relative
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
mouseX := Mousex
Mousey := Mousey
return
}
}
}

CoordMode, Mouse, Screen
GetCurrentMonitorst()
{
SysGet, numberOfMonitors, MonitorCount
WinGetPos, winX, winY, winWidth, winHeight, Arbortext
winMidX := winX + winWidth / 2
winMidY := winY + winHeight / 2
Loop %numberOfMonitors%
{
SysGet, monArea, Monitor, %A_Index%
if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop)
return A_Index
}
SysGet, MonitorPrimary, MonitorPrimary
return "No Monitor Found"
}
activeMonitorInfost( ByRef aX, ByRef aY, ByRef aWidth,  ByRef  aHeight, ByRef mouseX, ByRef mouseY  )
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
RemoveToolTip:
{
SetTimer, RemoveToolTip, Off
Tooltip
Return
}

Monitorareas:
{
msgbox, monitor areas
 SysGet, MonitorCount, 80                     ; Get the number of display monitors making up the desktop
   SysGet, MonitorPrimary, MonitorPrimary       ; Get the index of the primary monitor (1 in a single-monitor system) in case it's useful
   Loop %MonitorCount%                          ; For each monitor ...
   {  SysGet, Pos, MonitorWorkArea, %A_Index%   ; Get the monitor work area coordinates
      MonitorWorkArea[%A_Index%] := {l:PosLeft,r:PosRight,t:PosTop,b:PosBottom}   ; Save the coordinates in the MonitorWorkArea array
   }
   Msgbox, %MonitorCount% monitors
   Return
   }
   
   
   ArborFullScreencpn:
{

	wingetTitle,Titlearbor,A
	WinGetPos, Xarbor,yarbor,warbor,harbor, %titlearbor%
	currMoncpn := GetCurrentMonitorst()

	 SysGet, Aarea, Monitor, %currMoncpn%
	;SysGet,Aarea,MonitorWorkArea,%currMoncpn% ; THis is here for if ACM ever not goes over the taskbar.
	
	WidthA := AareaRight- AareaLeft
	HeightA := aareaBottom - aAreaTop
	leftt := aAreaLeft - 4
	topp := AAreaTop - 4
	MouseGetPos mmx,mmy
	If yarbor = %topp%
	{
		If xarbor = %leftt%
		;Msgbox, win maxed
		Return
	}
	Else
		;msgbox, not maxed
	CoordMode, mouse, Relative
	MouseMove 300,10
	Click 2
	Coordmode, mouse, screen
	MouseMove, mmx, mmy
	return
}
   
#`::
listvars
Pause, on
Return