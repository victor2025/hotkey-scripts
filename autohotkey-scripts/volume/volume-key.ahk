RAlt & Up:: ; 音量加
RAlt & Down:: ; 音量减
;>!+::    ;音量+5
;<!-::  ;音量-5
;^!Up::   ;音量+1
;^!Down:: ;音量-1

Sound_Add := InStr(A_ThisHotkey, "^") ? 1 : 1 ; 定义加减的量
; 输入判断
If InStr(A_ThisHotkey, "Up")
    hyf_SoundSetWaveVolume("+", Sound_Add)
Else
    hyf_SoundSetWaveVolume("-", Sound_Add)
Return

>!Left::  ;静音 {{{2
>!Right:: ;音量最大 {{{2
; 声明函数
hyl_VolumeMinMax:
Sound_Add := InStr(A_ThisHotkey, "Left") ? 0 : 50
SoundSet, Sound_Add, , , DeviceNumber
hyf_tooltip("Volume  " . Sound_Add, 1, 0, A_ScreenWidth, A_ScreenHeight)
Return

; 调整音量函数
hyf_SoundSetWaveVolume(mode, n)
{ ;mode为"+"或"-"
    SoundGet, Sound_Get, , , DeviceNumber
    Sound_Get := Round(Sound_Get)
    If (n = 5 && (numMod := Mod(Floor(Sound_Get), 5))) ;调整到5的倍数
        Sound_Get -= numMod
    If (mode = "+")
    {
        Sound_Now := Floor(Sound_Get) + n
        If (Sound_Now > 100)
        {
            hyf_tooltip("Volume+  100", 1, 0, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    Else
    {
        Sound_Now := Floor(Sound_Get) - n
        If (Sound_Now < 0)
        {
            hyf_tooltip("Volume-  0", 1, 0, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    SoundSet, Sound_Now, , , DeviceNumber
    hyf_tooltip("Volume" . mode . "  " . Sound_Now, 1, 0, A_ScreenWidth, A_ScreenHeight)
    Return
}

; 显示提示
hyf_tooltip(str, t := 1, ExitScript := 0, x := "", y := "")  ;提示t秒并自动消失   {{{3
{
    t *= 1000
    ToolTip, %str%, %x%, %y%
    SetTimer, hyf_removeToolTip, -%t%
    If ExitScript
    {
        Gui, Destroy
        Exit
    }
}

; 清除提示
hyf_removeToolTip() ;清除ToolTip {{{3
{
    ToolTip
}