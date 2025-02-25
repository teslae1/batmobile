
@echo off
setlocal enabledelayedexpansion

REM Get the search arg
set "searchStr=%1"

REM get the list arg
set "listArg=%2"

REM print help
if "%searchStr%"=="?" (
	echo welcome to __TERMINAL_RACER__
	echo  "c mydir" for cd into the first directory at a string contains match 
	echo  "c"       for cd..
	echo  "c mydir l" for listing all matches at string contains and prompting choice by index
	goto :EOF
)

REM if no arg - go one dir up
if "%searchStr%"=="" (
    endlocal
	cd..
	goto :EOF
    exit /b 1
)

REM if was argument with slash in just cd
echo %searchStr% | find "/">null && (
    endlocal
	cd %searchStr%
	goto :EOF
)

REM Initialize found flag
set "found=0"

REM Loop through directories in the current directory
if "%listArg%"=="" (
	for /d %%D in (*) do (
	    set "dirName=%%D"
	    if  not "!dirName:%searchStr%=!" == "!dirName!" (
	        set "found=1"
	        endlocal
	        cd %%D
	        goto :EOF
	    )

	)
) else (
   set "count=0"
    for /d %%D in (*) do (
        set "dirName=%%D"
        if not "!dirName:%searchStr%=!" == "!dirName!" (
            set /a count+=1
            echo !count!. %%D
        )
    )
    if "%count%"=="0" (
        echo No directory contains string '%searchStr%'
        goto :EOF
    )
    set /p choice="Enter the number of the directory to cd into: "
   set "count=0"
    for /d %%D in (*) do (
        set "dirName=%%D"
        if not "!dirName:%searchStr%=!" == "!dirName!" (
            set /a count+=1
			if !count!==!choice! (
	        	set "found=1"
	        	endlocal
	        	cd %%D
	        	goto :EOF
			)
        )
    )
	echo invalid index choice 
   	goto :EOF
)
 
if "%found%"=="0" (
    echo No directory contains string '%searchStr%'
)

