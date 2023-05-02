#noenv
#SingleInstance Force
#MaxThreads 5
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
SetBatchLines,		-1
SetWinDelay,		-1
SetControlDelay,	-1
CoordMode,	Tooltip,Screen
Coordmode,	Mouse,	Screen
Coordmode,	caret,	Screen
Coordmode,	pixel,	Screen
gosub,Varz
gosub,onMsgs

gObj.W:= 132, gObj.H:= 225 ;calc_gui_pos;
gObj.X:= a_screenwidth -132
gObj.Y:= a_screenheight-399

opt_AutoCopyAnswer:= False

;-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~

goto,GuiInit ;return,;settimer,Sidebar_ApplyTrans,-20
;-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~-=-~

ReCheckZone:
mousegetpos,xxx,yyy
if(xxx<gObj.x) {
	if(gObjOOB++)>1 { ;out of bounds count;
		settimer,recheckzone,off
		Win_Animate(cMainhWnd,"hide slide hpos",100)
		gObjOOB:= 0, Active_thisApp:=false
	}
} ;tt("guitest mouse-OOB-zone " xxx " - " gObj.x)
return,

GuiInit:
menu,tray,add,% "Auto-copy",autocopytoggle
menu,tray,% (opt_AutoCopyAnswer? "Check" : "uncheck"),% "Auto-copy"
menu,tray,add,%  "DtopMe" BB,Parent2DTop
menu,tray,Icon,% "DtopMe" BB,% "C:\Icon\32\34gL3_32.ico"
gui,m:New,-dpiscale +hwndcMainhWnd  +AlwaysonTop -Caption -SysMenu +toolwindow -border
gui,m:Font,s8,continuum
gui,m:Add,picture,x0 y0 w132 h225 +backgroundtrans,% a_scriptdir "\resources\calcbg-nq8.png"
gui,m:Add,Text,x4 y16 w40 +backgroundtrans ,In1:
gui,m:Add,Text,x4 w45 y56 +backgroundtrans,In2:
gui,m:Add,Text,x4 w45 y96 +backgroundtrans,0P:
gui,m:Add,Text,x4 w45 y128 +backgroundtrans,0u7:
Gui,m:Add,Custom,% "g1lbl vNum1 x" (e1x:= 54) " Y" (e1y:= 16) " W" (e1w:= 69) " H" (e1h:= 28) " ClassRichEdit50W hwnde1cwnd -0x100000",6
Gui,m:Add,Custom,% "g2lbl vNum2 x" (e2x:= 54) " Y" (e2y:= 56) " W" (e2w:= 69) " H" (e2h:= 28) " ClassRichEdit50W hwnde2cwnd -0x100000",6
Gui,m:Add,Custom,% "g3lbl vNum3 x" (e3x:= 54) " Y" (e3y:= 96) " W" (e3w:= 69) " H" (e3h:= 28) " ClassRichEdit50W hwnde3cwnd -0x100000",*
Gui,m:Add,Custom,% "g4lbl vNum4 x" (e4x:= 54) " Y" (e4y:=128) " W" (e4w:= 69) " H" (e4h:= 28) " ClassRichEdit50W hwnde4cwnd -0x100000"
gui,m:Add,Button, gButtonQ3D x39 y174 h32 w55 hwndbuttwnd default,Q3D ; The label ButtonQ3D (if it exists) will be run when ;the button is pressed.
; The label ButtonQ3D (if it exists) will be run when ;the button is pressed.
gui,m:Show,% "NA Hide W" (gObj.W) " H" (gObj.H) " X" (gObj.X) " Y" (gObj.Y)
(cMainhWnd,"Activate Slide HNeg",190)
Active_thisApp:= True ;msgbox % e2y w
sleep,100
b:= wingetpos(cMainhWnd) ;sendmessage,0x443, ,0x804000,,ahk_id %e1cwnd% ;bgcol
sleep,100
styleset(cMainhWnd,"-0x0c00000")
exstyleset(cMainhWnd,"+0x0800000")
sleep,500
yval:=b.y, xval:=b.x
gui,TP:New,-dpiscale +hwndTPwnd +parentm +AlwaysonTop -Caption -SysMenu -border
gui,TP:color,ff7700
gui,LP:New,-dpiscale +hwndLPwnd +AlwaysonTop -Caption -SysMenu +toolwindow -border
gui,LP:show,% "na hide" "X " gObj.x " Y" gObj.y " W" gObj.w " h" gObj.h
trans(LPwnd,3)
Win_Animate(LPwnd,"activate slide hneg",249)
winSet,AlwaysOnTop,On,ahk_id %Lpwind%
Win_Animate(TPwnd,"activate slide hneg",249)
settimer,recheckzone,2000
gui,TP:show,% "NA X" gObj.x " Y" gObj.y " W" gObj.w " H" gObj.h
loop,4 {
	(d%a_index%x)+=xval, (d%a_index%y)+=yval
	gui,d%a_index%:New,-dpiscale +AlwaysonTop +parentTP -Caption -SysMenu +toolwindow ;
	gui,d%a_index%:+hwndd%a_index%hwnd -border +0x46000000
	gui,d%a_index%:color,% coleditcover:="ffdd44"
	trans(d%a_index%hwnd,200)
	gui,d%a_index%:Show,% "x" 54 " y" -30 +(a_index*40) " w" 69 " h" 28
	winget,sbarwnd,id,ahk_exe sidebar.exe ahk_Class 7 Sidebar
	(e%a_index%x)+=xval, (e%a_index%y)+=yval
	gui,e%a_index%:New,-dpiscale +AlwaysonTop +parentLP -Caption -SysMenu +toolwindow ;
	gui,e%a_index%:+hwnde%a_index%hwnd -border +0x46000000
	gui,e%a_index%:color,% coleditcover:="ffdd44"
	trans(e%a_index%hwnd,40)
	gui,e%a_index%:Show,% "x" 54 " y" -30 +(a_index*40) " w" 69 " h" 28
	winget,sbarwnd,id,ahk_exe sidebar.exe ahk_Class 7 Sidebar
} EnableBlur(cMainhWnd)
Win_Animate(cMainhWnd,"activate slide hneg",100)
Win_Animate(cMainhWnd,"hide slide hneg",100)
global Active_thisApp:= True
return,

ButtonQ3D:
cGuiPos:= wingetpos(cMainhWnd)
;HideBalloon(winexist(),1)
ssleep(100) ;Save the input from the user to each control's associated variable.
gui,Submit,nohide ;if bub:= winExist("ahk_Class tooltips_class32 ahk_exe AutoHotkey.exe");winclose(bub)
if(((!num1)?i:=1)||((!num2)?ii:=2)||((!num3)?iii:=3)) { ;if(!num1); if(!num2); if(!num3)
	if( i ) {
		SendMessage,0x0028,1,0,,ahk_id %e1cwnd%
	} if(ii) {
		SendMessage,0x0028,1,0,,ahk_id %e2cwnd%
	} if(iii) {
		SendMessage,0x0028,1,0,,ahk_id %e3cwnd%
	} i:= ii:= iii:= ""
	return,
} else {
	Switch,Num3 {
		Case,"+"  : Result:= Num1 +  Num2
		Case,"-"  : Result:= Num1 -  Num2
		Case,"^"  : Result:= Num1 ^  Num2
		Case,"/"  : Result:= Num1 /  Num2
		Case,"//" : Result:= Num1 // Num2
		Case,"*"  : Result:= Num1 *  Num2
		Case,"**" : Result:= Num1 ** Num2
		Case,"!"  : Result:= Num1 !  Num2
		Case,"&"  : Result:= Num1 &  Num2
		Case,"&&" : Result:= Num1 && Num2
		Case,"|"  : Result:= Num1 |  Num2
		Case,"||" : Result:= Num1 || Num2
		Default   : a:="Unknown Operator: " Num3
	} try,gui,Submit,nohide
	(Num4:= Result), opt_AutoCopyAnswer? clipboard:= Result : ()
	try gui,Submit,nohide ;guicontrol,Focus,e4cwnd
	mousegetpos,xMouse,yMouse
		gui,Font,s12,continuum light
	guicontrol,,% e4cwnd,% Result
} return,

WM_LBD(wParam="",lParam="",uMsg="",hwnd="") {
	global
	mousegetpos,,,mhwnd
	winget,pid,pid,ahk_id %mhwnd%
	if(pid=r_pid)
		return,
	Xs:= (lParam &0xffff), ys:= lParam>> 16
	hwnd:= Format("{:#x}",hwnd) 
	switch,hwnd {
		case,% cMainhWnd: SendMessage,0x0028,% e1cwnd
		case,% e1hwnd	: GuiControl,Focus,% e1cwnd
		case,% e2hwnd	: GuiControl,Focus,% e2cwnd
		case,% e3hwnd	: GuiControl,Focus,% e3cwnd
		case,% e4hwnd	: GuiControl,Focus,% e4cwnd
			gui,submit,nohide
			gosub,ButtonQ3D
			GuiControl,Focus,% e2cwnd
			clipboard:= num4
		case,% e1cwnd	: GuiControl,Focus,% e1cwnd
		case,% e2cwnd	: GuiControl,Focus,% e2cwnd
		case,% e3cwnd	: GuiControl,Focus,% e3cwnd
		case,% e4cwnd	: GuiControl,Focus,% e4cwnd
		default: return,
	} return,
}

WM_LBU(wParam,lParam,uMsg,hwnd_) {
	global
	static v1, v2, hwnd
	VarSetCapacity(v1,8,0),	VarSetCapacity(v2,8,0)
	Xs:= (lParam &0xffff) -8, ys:= lParam>> 16
	hwnd:= Format("{:#x}",hwnd_)
	switch,hwnd {
		case,cMainhWnd : return,1
		case,e1hwnd : SendMessage,0x0028,%e1cwnd%
		case,e2hwnd : SendMessage,0x0028,%e4cwnd%
		case,e3hwnd : SendMessage,0x0028,0,0,,ahk_id %e3cwnd%
			GuiControl,Focus,% e3cwnd
			SendMessage,0x0028,0,0,,ahk_id %e3cwnd%
		case,e4hwnd : GuiControl,Focus,% e4cwnd
			SendMessage,0x0006,2,%e4cwnd%,,ahk_id %cMainhWnd% ;WM_ACTIVATE: nonclick source simulation
		case,e1cwnd : GuiControl,Focus,% e1cwnd
			SendMessage,0xB0,&v1,&v2,,ahk_id %e1cwnd% ;EM_SETSEL 177 0xB1
			sleep,20
			first:=NumGet(v1,"uchar"), sec:=NumGet(v2,"uchar") ;tt( first " " sec) ;if first=1&&sec=0
			if(first!=0&&sec!=0) { ;tt("dfdf")
				SendMessage,0xB1,-1,-1,,ahk_id %e1cwnd% ;EM_SETSEL 177 0xB1
				SendMessage,0xB1,0,-1,,ahk_id %e1cwnd% ;EM_SETSEL 177 0xB1
			} else,return,1 ;supressed deselction by unclick
		case,e2cwnd : GuiControl, Focus,% e2cwnd	;tooltip,e2c,,,2
			SendMessage, 0xB0,&v1,&v2,,ahk_id %e2cwnd% ;EM_SETSEL 177 0xB1
			sleep,20
			first:=NumGet(v1,"uchar"), sec:=NumGet(v2,"uchar") ;tt( first " " sec) ;if first=1&&sec=0
			if(first!=0&&sec!=0) {
				SendMessage,0xB1,-1,-1,,ahk_id %e2cwnd% ;EM_SETSEL 177 0xB1
				SendMessage,0xB1,0,-1,,ahk_id %e2cwnd% ;EM_SETSEL 177 0xB1
			} else,return,1 ;supressed deselction by unclick
		case,e3cwnd : GuiControl, Focus,% e3cwnd
			SendMessage,0xB0,&v1,&v2,,ahk_id %e3cwnd% ;EM_SETSEL 177 0xB1
			sleep,20
			first:=NumGet(v1,"uchar"), sec:=NumGet(v2,"uchar") ;tt( first " " sec) ;if first=1&&sec=0
			if(first!=0&&sec!=0) {
				SendMessage,0xB1,-1,-1,,ahk_id %e3cwnd% ;EM_SETSEL 177 0xB1
				SendMessage,0xB1,0,-1,,ahk_id %e3cwnd% ;EM_SETSEL 177 0xB1
			} else,return,1 ;supressed deselction by unclick
		case,e4cwnd : GuiControl,Focus,% e4cwnd
			SendMessage,0xB0,&v1,&v2,,ahk_id %e1cwnd% ;EM_SETSEL 177 0xB1
			sleep,20
			first:=NumGet(v1,"uchar"), sec:=NumGet(v2,"uchar") ;tt( first " " sec) ;if first=1&&sec=0
			if(first!=0&&sec!=0) {
				SendMessage,0xB1,-1,-1,,ahk_id %e4cwnd% ;EM_SETSEL 177 0xB1
				SendMessage,0xB1,0,-1,,ahk_id %e4cwnd% ;EM_SETSEL 177 0xB1
			} else,return,1 ;supress deselction by un-click
		default: ControlClick,x5 y5,ahk_id %e1cwnd%,,,,Pos
			SendMessage,0x0028,0,0,,ahk_id %e1cwnd%
			return,
	} return,
}

WM_LbDbl(wParam,lParam,uMsg,hwnd) {
	global
	Xs:= (lParam &0xffff) -8, ys:= lParam>> 16
	hwnd:= Format("{:#x}",hwnd)
	switch,hwnd {
		case,% LPWnd : gui,LP:show,% "na x " gObj.x " y" gObj.y " w" gObj.w " H" gObj.h
			Win_Animate(cMainhWnd,"hide slide hpos",100)
			Active_thisApp:=False
		case,% e1hwnd :
			ControlClick,x5 y5,ahk_id %e1cwnd%,,,,Pos
			SendMessage,0x0028,%e1cwnd%
		case,% e2hwnd : ControlClick,x5 y5,ahk_id %e1cwnd%,,,,Pos
			SendMessage,0x0028,%e4cwnd%
		case,% e3hwnd : SendMessage,0x0028,0,0,,ahk_id %e3cwnd%
			GuiControl, Focus,% e3cwnd
			SendMessage,0x0028,0,0,,ahk_id %e3cwnd%
	;	case,% e4hwnd :;GuiControl,Focus,% e4cwnd ;tooltip,e4,,,2
		default: return,
	}
}

_HOVER(wParam,lParam,bum,hwnd) {
	global
	settimer,recheckzone,1400
	gosub,recheckzone
	mousegetpos,,,mhwnd
	Active_thisApp:= DllCall("IsWindowVisible","Ptr",cMainhWnd)
	focused:= winExist("A")
	if(!Active_thisApp) {
		sleep,100
		if(!(Active_thisApp:= DllCall("IsWindowVisible","Ptr",cMainhWnd))){
			Win_Animate(cMainhWnd,"activate slide hneg",100)
			Active_thisApp:=True
			return,
		}
	} return,
}

DeActivate(wParam="",lParam="",bum="",hwnd="") {
	static global r_pid
	mousegetpos,,,mhwnd
	winget,pid,pid,ahk_id %mhwnd%
	if(pid=r_pid)
		return,0
	if(wParam=1)
		return,1
	else,if(Active_thisApp) {
		sleep,200
		if(mhwnd!=cMainhWnd) {
			Win_Animate(cMainhWnd,"hide slide hpos",100)
			Gui,M: Show, NoActivate hide
			Active_thisApp:=False
			return,
		} else,if(Active_thisApp:= DllCall("IsWindowVisible","Ptr",cMainhWnd))
			return,
	} switch,hwnd {
		case,% cMainhWnd : return,0
		case,% LPwnd : return,0
	}
}

; WM_MOUSEMOVE(wparam="",lparam="",juicybum="",hwnd="") {
	; global	;static global init:=OnMessage(0x200, "WM_MCtLTTip")
	; if(Init) { ; _TT is kept blank for use by the ToolTip command below.
		; static CurrControl, PrevControl, _TT
		; Init:= False ;Run 1ce-only;
	; } If((CurrControl:= A_GuiControl) <> PrevControl and not InStr(CurrControl, " ")) {
		; PrevControl:= CurrControl
		; tooltip
		; SetTimer,DisplayToolTip,-1100
	; } return,
; }

guiEscape:
guiClose:
tt("exiting",b.x-120,b.y,2)
sleep,900
exitapp,

Parent2DTop:
dtopWinKidnap(cMainhWnd)
return,

dtopWinKidnap(byref Child="") {
	global A_new_hWnd,dtopchildren ;(Child=""? Child:= A_new_hWnd);(stylemen_invoked);
	WinGetPos,ChildX,ChildY,Child_W,Child_H,ahk_id %Child%
	winget,style,style,ahk_id %Child%
	Surrogate:= DesktoP()
	DllCall("SetParent","ptr",Child,"ptr",Surrogate)
	WinMove,ahk_id %Child%,,%ChildX%,%ChildY%,%Child_W%,%Child_H%
	win_move(child,"","",child_w+10,Child_h+10)
	return,
}

DESKTOP(def="") { ;mw wip
	DetectHiddenWindows,On
	DetectHiddenText,On
	SetTitleMatchMode,2
	SetTitleMatchMode,Slow
	WinGet,LL,List,ahk_class WorkerW
	loop,% LL {
		va:= LL%A_Index%
		winget,deskhandle,id,ahk_id %va%
		controlget,desklistviewhnd,hwnd,,SysListView321 , ahk_id %va%
		SendMessage, 0x1004, 0, 0,, Ahk_ID %desklistviewhnd%
		if(!(errorlevel = "FAIL")) {
			itemcount:=errorlevel
			return,va
		}
	} return,va
}

WinMove(hWnd="",X="",Y="",W="",H="") { ;Flags=""
	return,DllCall("SetWindowPos","uint",hWnd,"uint",0,"int",x,"int",y,"int",w,"int",h,"uint",0x4005)
}

activate() {
	tt("activate")
}

Sidebar_ApplyTrans() {
	process,exist,% "sidebar.exe"
	spid:= errorlevel
	winget,hwnd,list,% "ahk_class 7 Sidebar ahk_pid" spid
	loop,% hwnd {
		trans(hwnd%a_index%,1)
		winset,exstyle,+0x00000020,% "ahk_id " hwnd%a_index%
		winset,style,-0x10000000,% "ahk_id " hwnd%a_index%
		winset,transparent,250,% "ahk_id " hwnd%a_index%
	}	winget,hw0,id,% "ahk_class 7 SidebarMain ahk_pid" spid
	exstyleset(hw0,+0x20)
	return,% errorlevel
}

EnableBlur(hWnd) {  ;Function by qwerty12 and jNizM (found on https://autohotkey.com/boards/viewtopic.php?t=18823) ;WindowCompositionAttribute  ;AccentState
	static WCA_ACCENT_POLICY:= 19, ACCENT_DISABLED:= 0, ACCENT_ENABLE_GRADIENT:= 1
	, ACCENT_ENABLE_TRANSPARENTGRADIENT:= 2, ACCENT_ENABLE_BLURBEHIND:= 3, ACCENT_INVALID_STATE:= 4
	, SzAccentStruc:= VarSetCapacity(AccentPolicy,4*4,0), padding:= A_PtrSize==8 ? 4 : 0
	NumPut(ACCENT_ENABLE_BLURBEHIND,AccentPolicy,0,"UInt")
	VarSetCapacity(WindowCompositionAttributeData,4 +padding +A_PtrSize +4 +padding)
	NumPut(WCA_ACCENT_POLICY,WindowCompositionAttributeData,0,"UInt")
	NumPut(&AccentPolicy,WindowCompositionAttributeData,4 +padding,"Ptr")
	NumPut(SzAccentStruc,WindowCompositionAttributeData,4 +padding +A_PtrSize,"UInt")
	return,DllCall("SetWindowCompositionAttribute","Ptr",hWnd,"Ptr",&WindowCompositionAttributeData)
}

trans(hwnd,val) {
	winset,transparent,%val%,ahk_id %hwnd%
}

ExStyleSet(hwnd="",exstyle="") {
	winset,exstyle,% exstyle,ahk_id %hwnd%
	return,
}

StyleSet(hwnd="",style="") {
	winset,style,% style,% "ahk_id " hwnd
	return,
}

LoWord(Dword,Hex=0) {
	static WORD:= 0xFFFF
	return,(!Hex)? (Dword&WORD) : Format("{1:#x}",(Dword&WORD))
}

HiWord(Dword,Hex=0) {
	static BITS:= 0x10, WORD:= 0xFFFF
	return,(!Hex)? ((Dword>>BITS)&WORD) : Format("{1:#x}",((Dword>>BITS)&WORD))
}

MakeLONG(LOWORD,HIWORD,Hex=0) {
	static BITS:= 0x10, WORD:= 0xFFFF
	return,(!Hex)? ((HIWORD<<BITS)|(LOWORD&WORD)) : Format("{1:#x}"
	, ((HIWORD<<BITS)|(LOWORD&WORD)))
}

onMsgs:
onexit,guiclose
 onmessage(0x201,"WM_LBD")
,onmessage(0x202,"WM_LBU")
,onmessage(0x203,"WM_LBdbl")
,onmessage(0x200,"_HOVER") ;OnMessage(0x200,"WM_MOUSEMOVE")
,onmessage(0x86,"deactivate")
,onmessage(0x6,"activate")
return,

TipDisplay:
SetTimer,DisplayToolTip,Off
ToolTip,% %CurrControl%_TT
SetTimer,RemoveToolTip,-3000
return,

TipRemove:
SetTimer,RemoveToolTip,Off
ToolTip,
return,

AutoCopyToggle:
(opt_AutoCopyAnswer:=!opt_AutoCopyAnswer)
menu,tray,% (opt_AutoCopyAnswer? "Check" : "uncheck"),% "Auto-copy"
return,

1lbl:
2lbl:
3lbl:
4lbl:
indx:= strreplace(a_thislabel,"lbl")
gui,submit,nohide
return,

Varz:
global cMainhWnd, e1hwnd, e1cwnd, e2hwnd, e2cwnd, e3hwnd, e3cwnd, e4hwnd, e4cwnd
, b, num1, num2, num3, num4, result, xx, gObj, hedit, Active_thisApp, focused
, opt_AutoCopyAnswer
, gObjOOB:= 0
, Msftedit:= DllCall("LoadLibrary","Str","Msftedit.dll")
, r_pid:= DllCall("GetCurrentProcessId")
gObj:= {}, WM_MCtLTTip()
return,