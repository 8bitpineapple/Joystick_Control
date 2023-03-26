#Persistent  ; Keep this script running until the user explicitly exits it.
global inputHistory := []
maxArrayLength := 10
SetTimer, WatchPOV, 5
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

processArray() {
    keepMaxSize()
    giant_swing := "r,n,l,dl,d,dr,r,x"
    giant_swing2 := "r,l,dl,d,dr,r,x"
    giant_swing3 := "r,l,dl,d,r,x"
    giant_swing4 := "r,n,l,dl,d,r,x"
    if seqCheck(giant_swing) or seqCheck(giant_swing2) or seqCheck(giant_swing3) or seqCheck(giant_swing4)
    {
        Run "C:\Program Files\VideoLAN\VLC\vlc.exe" giantswing.mp4 --fullscreen
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
    currentKey := "ul"
else if (POV = 0)      ; 0 to 45 degrees: Forward
    currentKey := "u"
else if (POV = 9000)  ; 45 degrees
     currentKey := "r"
else if (POV = 4500)  ; 135 degrees: Right
     currentKey := "ur"
else if (POV = 13500)  ; 90 degrees: Right
     currentKey := "dr"
else if (POV = 18000) ; 180 degrees: Down
    currentKey := "d"
else if (POV = 13500) ; 135 to 225 degrees: Down
     currentKey := "dr"
else if (POV = 27000) ; 225 to 315 degrees: Left
     currentKey := "l"
else if (POV = 22500) ; 225 to 315 degrees: Left
     currentKey := "dl"
else if (POV = 31500) ; 225 to 315 degrees: Left
     currentKey := "ul"


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
inputHistory.Push("x")
processArray()
return
}

Joy2::
{
inputHistory.Push("a")
processArray()
return
}

Joy3::
{
inputHistory.Push("b")
processArray()
return
}

Joy4::
{
inputHistory.Push("y")
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


