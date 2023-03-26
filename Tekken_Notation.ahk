#Persistent  ; Keep this script running until the user explicitly exits it.
global inputHistory := []
maxArrayLength := 10
SetTimer, WatchPOV, 3
return

seqCheck(seq)
{
    seqArray := StrSplit(seq, ",")
    lenSeq := seqArray.Length()
    lenArray := inputHistory.Length()
    if (lenArray >= lenSeq) {
        isMatch := true
        Loop % (lenSeq)
        {
            if(seqArray[A_Index] != inputHistory[lenArray - lenSeq + A_Index])
            {
                isMatch := False
                Break
            }
        }
    }
    return isMatch
}

keepMaxSize()
{
    if (inputHistory.Length > maxArrayLength) {
        inputHistory.Remove(1, inputHistory.Length() - maxArrayLength)
    }
}

giantSwingFunction()
{
    ;Old code to play a video as a test
    ;Run "C:\Program Files\VideoLAN\VLC\vlc.exe" D:\My_Stuff\Videos\giantswing.mp4 --fullscreen
    ;Start Tekken using the batch file and exit the script
    run start_Tekken.bat
    ExitApp
}

processArray() {
    keepMaxSize()

    ;In tekken 7 giant swing will come out even if you miss the df input
    ;Also, if you somehow don't get a neutral between f and b it should still come out.
    giant_swing := "f,n,b,db,d,df,f,1"
    giant_swing2 := "f,b,db,d,df,f,1"
    giant_swing3 := "f,b,db,d,f,1"
    giant_swing4 := "f,n,b,db,d,f,1"
    ;I feel like these or statements were less responsive but don't understand why
    ; if seqCheck(giant_swing) or seqCheck(giant_swing2) or seqCheck(giant_swing3) or seqCheck(giant_swing4)
    ; {
    ;     ; Run "C:\Program Files\VideoLAN\VLC\vlc.exe" D:\My_Stuff\Videos\giantswing.mp4 --fullscreen
    ;     giantSwingFunction()
    ;     inputHistory := []
    ; }
    if seqCheck(giant_swing)
    {
        ; 
        giantSwingFunction()
        inputHistory := []
    }

    if seqCheck(giant_swing2)
    {
        ; Run "C:\Program Files\VideoLAN\VLC\vlc.exe" D:\My_Stuff\Videos\giantswing.mp4 --fullscreen
        giantSwingFunction()
        inputHistory := []
    }
    if seqCheck(giant_swing3)
    {
        ; Run "C:\Program Files\VideoLAN\VLC\vlc.exe" D:\My_Stuff\Videos\giantswing.mp4 --fullscreen
        giantSwingFunction()
        inputHistory := []
    }
    if seqCheck(giant_swing4)
    {
        ; Run "C:\Program Files\VideoLAN\VLC\vlc.exe" D:\My_Stuff\Videos\giantswing.mp4 --fullscreen
        giantSwingFunction()
        inputHistory := []
    }
}

f11::
    processArray()

WatchPOV:
POV := GetKeyState("JoyPOV")  ; Get position of the POV control.
prevKey := currentKey  ; Prev now holds the key that was down before (if any).

; Some joysticks might have a smooth/continous POV rather than one in fixed increments.
; To support them all, use a range:
if (POV < 0)   ; No angle to report
    currentKey := "n"
else if (POV = 31500)
    currentKey := "bl"
else if (POV = 0)      ; 0 to 45 degrees: Forward
    currentKey := "u"
else if (POV = 9000)  ; 45 degrees
     currentKey := "f"
else if (POV = 4500)  ; 135 degrees: Right
     currentKey := "uf"
else if (POV = 13500)  ; 90 degrees: Right
     currentKey := "df"
else if (POV = 18000) ; 180 degrees: Down
    currentKey := "d"
else if (POV = 13500) ; 135 to 225 degrees: Down
     currentKey := "df"
else if (POV = 27000) ; 225 to 315 degrees: Left
     currentKey := "b"
else if (POV = 22500) ; 225 to 315 degrees: Left
     currentKey := "db"
else if (POV = 31500) ; 225 to 315 degrees: Left
     currentKey := "ub"


if (currentKey = prevKey)  ; The correct key is already down (or no key is needed).
    return  ; Do nothing.

; ; Otherwise, release the previous key and press down the new key:
; SetKeyDelay -1  ; Avoid delays between keystrokes.
; if prevKey   ; There is a previous key to release.
;     Send, {%prevKey% up}  ; Release it.
; if currentKey   ; There is a key to press down.
;     Send, {%currentKey% down}  ; Press it down.
inputHistory.Push(currentKey)
processArray()
return

Joy1::
{
inputHistory.Push("1")
processArray()
return
}

Joy2::
{
inputHistory.Push("3")
processArray()
return
}

Joy3::
{
inputHistory.Push("4")
processArray()
return
}

Joy4::
{
inputHistory.Push("2")
processArray()
return
}

Joy5::
{
inputHistory.Push("l")
processArray()
return
}

Joy6::
{
inputHistory.Push("r")
processArray()
return
}

Joy7::
{
inputHistory.Push("l2")
processArray()
return
}

Joy8::
{
inputHistory.Push("r2")
processArray()
return
}

Joy9::
{
inputHistory.Push("select")
processArray()
return
}

Joy10::
{
inputHistory.Push("start")
processArray()
return
}


