
@echo off
setlocal enabledelayedexpansion

REM Get the search arg
set "searchStr=%1"

REM get the list arg
set "secondArg=%2"

REM print help
if "%searchStr%"=="?" (
	echo __BATMOBILE__ 
	echo --     "c mydir"     cd into the first directory with string contains match 
	echo --     "c my dir"    cd into the first directory with string contains match for both arguments
	echo --     "c"           cd..
	echo --     "c mydir -l"  for when it gets the search wrong and there are multiple matches - listing all matches at string contains and remembers your choice within the current terminal session and next time you use "c mydir" it will use the directory at the index you chose last time 
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
if not "!searchStr:/=!" == "!searchStr!" ( 
    endlocal
	cd %searchStr%
	goto :EOF
)

set "found=0"

REM handle normal case
if "%secondArg%"=="" (
	set "currentCombinedPathAndSearch=%CD%%searchStr%%"
	if DEFINED "!currentCombinedPathAndSearch!" (
	        set "found=1"
	        endlocal
			for /f "tokens=2 delims==" %%a in ('set %CD%%searchStr%') do cd %%a
	        goto :EOF
	) else if "!currentCombinedPathAndSearch!" == "!currentCombinedPathAndSearch: =!" (
		 if DEFINED !currentCombinedPathAndSearch! (
	         set "found=1"
	         endlocal
		 	for /f "tokens=2 delims==" %%a in ('set %CD%%searchStr%') do cd %%a
	         goto :EOF
		 )
	)
	REM first check for exact match - has highest priority
	for /d %%D in (*) do (
	    set "dirName=%%D"
	    if  "!searchStr!" == "!dirName!" (
	        set "found=1"
	        endlocal
	        cd %%D
	        goto :EOF
	    )
	)
	REM check for string contains match
	for /d %%D in (*) do (
	    set "dirName=%%D"
	    if  not "!dirName:%searchStr%=!" == "!dirName!" (
	        set "found=1"
	        endlocal
	        cd %%D
	        goto :EOF
	    )
	)
REM handle list choice
) else if "%secondArg%"=="-l" (
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
				set %CD%%searchStr%=%%D
	        	cd %%D
	        	goto :EOF
			)
        )
    )
	echo invalid index choice 
   	goto :EOF
REM handle multi string search
) else (
	for /d %%D in (*) do (
	    set "dirName=%%D"
	    if not "!dirName:%searchStr%=!" == "!dirName!"  (
			if not  "!dirName:%secondArg%=!" == "!dirName!"  (
	        	set "found=1"
	        	endlocal
	        	cd %%D
	        	goto :EOF
	    )
	)
	)
)
 
if "%found%"=="0" (
    echo No directory contains string '%searchStr%'
)

