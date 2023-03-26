start steam://rungameid/389730
@echo off
sleep 3
:loop
tasklist | find /i "Tekken 7.exe" > nul && goto loop
start "" G:\Projects\AHK_Scripts\Joystick_Control\Tekken_Notation.ahk
exit