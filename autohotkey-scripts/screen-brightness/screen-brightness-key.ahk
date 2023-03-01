#NoEnv
#SingleInstance Force
#Persistent

;管理员身份运行，保证某些界面不失效
if not A_IsAdmin
{
Run *RunAs "%A_ScriptFullPath%" ; 需要 v1.0.92.01+
ExitApp
}

;================ 改变显示器亮度 ， ahk下载地址和思路：https://github.com/jNizM/Class_Monitor
#Include %A_ScriptDir%/Class_Monitor.ahk  ;包含当下目录的某AHK文件

;气泡提示框
; 参考：ToolTip - AutoHotkey 中文手册
; ToolTip - Syntax & Usage
tooltips(str, ms)  ;参数：显示的字符串，显示多少毫秒后消失
{
	CoordMode, ToolTip  ;为多个命令设置坐标模式，相对于活动窗口还是屏幕。
	ToolTip, %str%, 100, 100
	
	ms := 0 - ms
	SetTimer, RemoveToolTip, %ms%  ;设置持续时间
	return

	RemoveToolTip:
	ToolTip
	return
}

;减小亮度
#F5::
	Bright := Monitor.GetBrightness()["Current"]
	Monitor.SetBrightness(Bright - 10)
	
	;显示当前亮度
	Bright := Monitor.GetBrightness()["Current"]
	tooltips("亮度：" . Bright, 2000)  ; 【 . 】表示连接字符串
	
return

;增大亮度
#F6::
	Bright := Monitor.GetBrightness()["Current"]
	Monitor.SetBrightness(Bright + 10)

	;显示当前亮度
	Bright := Monitor.GetBrightness()["Current"]
	tooltips("亮度：" . Bright, 2000)  ; 【 . 】表示连接字符串

return