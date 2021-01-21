
mkdir THP

@echo OFF
setlocal EnableDelayedExpansion

set arg1=%1
set FPS=25
set WIDTH=320
set HEIGHT=240
set DURATION=30
set QUALITY=80
set "NOAUDIO=--noaudio"
REM set "SKIP=--frameskip"


if "%~1" == "" goto TESTFOLDER


: TESTFOLDER
FOR %%i IN (%arg1%) DO IF EXIST %%~si\NUL GOTO FOLDER


:FILE
set MOVIEFILE=%~1
set THPFILE=%~n1.thp

setlocal DISABLEDELAYEDEXPANSION

.\bin\ffmpeg.exe -y -i "%~1" -filter:v "fps=fps=%FPS%, drawbox= w=iw : h=ih : t=6 : color=black" -q:v 0 -c:a copy "THP\tempz.mp4"

.\bin\avthp.exe -s %WIDTH%x%HEIGHT% -t %DURATION% -q %QUALITY% %NOAUDIO% %SKIP% "THP\tempz.mp4" "THP\%THPFILE%"

endlocal
GOTO QUIT


:FOLDER
setlocal disabledelayedexpansion
 for /f "delims=: tokens=1*" %%A in ('dir /b /s /a-d %arg1%^|findstr /n "^"') do (

.\bin\ffmpeg.exe -y -i "%%B" -filter:v "fps=fps=%FPS%, drawbox= w=iw : h=ih : t=6 : color=black" -q:v 0 -c:a copy "THP\tempz.mp4"

.\bin\avthp.exe -s %WIDTH%x%HEIGHT% -t %DURATION% -q %QUALITY% %NOAUDIO% %SKIP% "THP\tempz.mp4" "THP\%%~nB.thp"
 )
setlocal EnableDelayedExpansion


GOTO QUIT

:QUIT
rm "THP\tempz.mp4"
pause


