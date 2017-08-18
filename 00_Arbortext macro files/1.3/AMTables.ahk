/*		
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\ /=\/=\/=\/=\/=\/=\/=\/=\/=\=========== Create Column Wide Tables Section ======/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\/=\
*/

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
	WinwaitActive, Table Insert,,5 ; waits for the Table INsert window to be active
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
	FoundPos := RegExMatch(String,"^`<table frame") ; looks to see if the copy action for a table tag in it
		;msgbox, %FoundPos%
		If FoundPos != 1 ; IF there is no table tag
		{
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,,,Please put cursor in approiate location to create a table,.5
		msgbox,Please put cursor in approiate location to create a table
		
		IfEqual, A_IsCompiled,1 ; this is here to restart to macro so it stops its current actions if the script is an EXE
					{
						Run, %A_ScriptFullPath% /Restart ; this methond allows the /restart to show in the command line, which prevents the splash image from loading on restart
					}
					
					;Below is here for when I am testing the macro out and it is not an exe file yet
					Run, %A_ScriptFullPath% /Restart ; this methond allows the /restart to show in the command line, which prevents the splash image from loading on restart
					exitapp ; exits this verison of the app
					Return
		}
		
		
	If String Contains id ; if the "string" variable has the word ID in it
	{
		Send {ctrl down}{x}{ctrl up} ; send crtl x 
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
	
	/*
	**************************************************************************************************************
	************************************************************************************************************
	Please note that the reartext, reartexrows, etc. are the info from a table if you copied it form arbortext and into notepad. I also had to make each quote mark into a double quote so that the
	scripting language knows that there is a quottation makr in that location. The only time a single quote mark is used is at the beginning and the very end.
	*/
	
	
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
		
		Reartextrowstotal =  ; clears out the variable
		Letteroutput = 0 ; sets this variable to 0
		Loopcounter = 1 ; sets this variable to 1
		ASCII = 65	;sets this variable to 65

		Loop, %Userrows% ; loops that amount of times the user puts for the row amount
		{
		
		Transform, OutputChar, Chr, %ASCII% ; makes the ascii char into a letter for tool table
		
		If ASCii = 91 ; if variable is 91 which is the letter z it resets to 65 (a)
		{
		Ascii = 65 ; resets var to 65
		Letteroutput++ ; adds one to the letteroutput variable
		}

;below is for is the ascii variable = 79, which is a I, 81 which is a q, or 73 which is a O, it will skip it for the table		
		If (ASCii = 79) || (ASCii = 81) || (ASCii = 73) 
		{
		Ascii++ ; adds one to variable
		Transform, OutputChar, Chr, %ASCII% ; converts the AScii number to a letter 
		}
	
		
		If Letteroutput != 0 ; if letteroutput variable is not 0
		{				
		Asciifirst := (64 + letteroutput) ;makes the 1st letter an A,B,C etc
		If Asciifirst = 73 | 79 | 81 ; this if statemtn ensure that the first letter is not a I,O, or Q
		{
		Asciifirst++
		}
		Transform, OutputCharfirst, Chr, %Asciifirst%
		outputchar := OutputCharfirst outputchar ; makes the outputchar variable a double letter
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