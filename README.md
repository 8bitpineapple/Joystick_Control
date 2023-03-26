# Joystick_Control
An Autohotkey script that allows you to use a fightstick or xbox controller to run programs/scripts with fighting game style motion inputs

Whenever you press a button on your controller it is appended to the end of "inputHistory" and "processArray" is called.
Process array first keeps the size of the array at the maxArrayLength.
After this you can add functions to check if current input history matches an input and do what you want.

# Notation
There are two scripts, "Tekken_Notation" and "Xbox_Notation"
In Tekken notation things are stored as:
b, db, d, df, f, uf, u, ub to mean: back, downback, down, down+forward, forward, up+forwards, up+back
and  the buttons are 1,2,3,4 which on an xbox controller are x,y,a,b

Meanwhile on Xbox notation the inputs are stored as
l, dl, d, dr, r, ur, u, ul, to mean: left, down+left, down, down+right, up+right, up, up+left
And the buttons are stored as x,y,a,b

# Adding new functions
To add a new functionality for now you have to modify processArray()
You can make use of the seqCheck function that will accept a string such as "f,n,d,df,2"
With an if statement you can make it so whenever those inputs are pressed something happens.

E.g. Suppose you want to load a calculator everytime you do a hudoken input "f,n,d,df,2"
You could change the processArray() function to include
if seqCheck("f,n,d,df,2")
{
run calc.exe
inputHistory := []
}

Cleaning the array with inputHistory := [] seems like a good idea to me.
Otherwise you may get unwanted behavior

# Current Functions
For now there's just one function in Tekken_notation.ahk.
If you do a giant swing input with Tekken_notation.ahk it will load tekken 7 via start_Tekken.bat
For now the script is terminated while Tekken is loaded, and then reloaded by the batch file when Tekken closes.
This is to provent things in the script being activated while you are trying to play.

Xbox_Notation.ahk is slightly different. It is set to play a giantswing.mp4 video in VLC when you input giant swing.
For the video to load it should be placed in the same location as the script.

Giant swing isn't neccicarily the easiest input to do. If the script doesn't seem to be working try including an easier motion input.
