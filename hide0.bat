@echo off
setlocal EnableDelayedExpansion

set PASSWD=1122
set MAX_TRIES=3

for /L %%i in (1,1,%MAX_TRIES%) do (
	set /p wd=Directory : 
	set /p inputPWD=PASSCODE : 
	if !inputPWD! == %PASSWD% (
		goto correctPWD
	) else (
		if %%i == 3 (
			goto maxTriesExceeded
		) else (
			echo Tried %%i out of %MAXTRIES% times
		)
	)
)

:correctPWD
cls
echo ACCESS GRANTED!
set /p action=Activate/Deactivate (A/D) :
if  /I %action% == A (
	goto activate
) else if /I %action% == D (
	goto deactivate
) else (
	goto invalidInput
)

:activate
attrib +s +h "%wd%"
goto exit

:deactivate
attrib -s -h "%wd%"
goto exit

:maxTriesExceeded
cls
echo "ACCESS DENIED!"
pause
goto exit

:invalidInput
echo "INVALID INPUT!"
pause
goto exit

:exit
cls
endlocal
exit /b %ERRORLEVEL%