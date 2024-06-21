echo \" <<'RUN_AS_BATCH' >/dev/null ">NUL "\" \`" <#"
@ECHO OFF
REM LICENSE CLAUSES HERE
REM ----------------------------------------------------------------------------




REM ############################################################################
REM # Windows BATCH Codes                                                      #
REM ############################################################################
where /q powershell
if errorlevel 1 (
        echo "ERROR: missing powershell facility."
        exit /b 1
)

copy /Y "%~nx0" "%~n0.ps1" >nul
timeout /t 1 /nobreak >nul
powershell -executionpolicy remotesigned -Command "& '.\%~n0.ps1' %*"
start /b "" cmd /c del "%~f0" & exit /b %errorcode%
REM ############################################################################
REM # Windows BATCH Codes                                                      #
REM ############################################################################
RUN_AS_BATCH
#> | Out-Null




echo \" <<'RUN_AS_POWERSHELL' >/dev/null # " | Out-Null
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
. "${env:LIBS_HESTIA}\hestiaKERNEL\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Vanilla.sh.ps1"




function hestiaOS-Exec {
        param (
                [string]$___command,
                [string]$___arguments,
                [string]$___log_stdout,
                [string]$___log_stderr
        )


        # validate input
        if (Test-Path -Path "${___command}" -ErrorAction SilentlyContinue) {
                $___program = "${___command}"
        } else {
                $___program = Get-Command $___command -ErrorAction SilentlyContinue
                if (-not ($___program)) {
                        return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
                }
        }


        # execute command
        if ($(hestiaSTRING-Is-Empty "${___arguments}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                if (($(hestiaSTRING-Is-Empty "${___log_stdout}") -ne ${env:hestiaKERNEL_ERROR_OK}) -or
                        ($(hestiaSTRING-Is-Empty "${___log_stderr}") -ne ${env:hestiaKERNEL_ERROR_OK})) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -RedirectStandardOutput "${___log_stdout}" `
                                                -RedirectStandardError "${___log_stderr}"
                } elseif ($(hestiaSTRING-Is-Empty "${___log_stdout}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -RedirectStandardOutput "${___log_stdout}"
                } elseif ($(hestiaSTRING-Is-Empty "${___log_stderr}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -RedirectStandardError "${___log_stderr}"
                } else {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru
                }
        } else {
                if (($(hestiaSTRING-Is-Empty "${___log_stdout}") -ne ${env:hestiaKERNEL_ERROR_OK}) -or
                        ($(hestiaSTRING-Is-Empty "${___log_stderr}") -ne ${env:hestiaKERNEL_ERROR_OK})) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -ArgumentList "${___arguments}" `
                                                -RedirectStandardOutput "${___log_stdout}" `
                                                -RedirectStandardError "${___log_stderr}"
                } elseif ($(hestiaSTRING-Is-Empty "${___log_stdout}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -ArgumentList "${___arguments}" `
                                                -RedirectStandardOutput "${___log_stdout}"
                } elseif ($(hestiaSTRING-Is-Empty "${___log_stderr}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -ArgumentList "${___arguments}" `
                                                -RedirectStandardError "${___log_stderr}"
                } else {
                        $___process = Start-Process -Wait `
                                                -FilePath "${___program}" `
                                                -NoNewWindow `
                                                -PassThru `
                                                -ArgumentList "${___arguments}"
                }
        }
        if ($___process.ExitCode -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
return
<#
RUN_AS_POWERSHELL




################################################################################
# Unix Main Codes                                                              #
################################################################################
. "${LIBS_HESTIA}/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"




hestiaOS_Exec() {
        ___command="$1"
        ___argument="$2"
        ___log_stdout="$3"
        ___log_stderr="$4"


        # validate input
        if [ $(hestiaOS_Is_Command_Available "$___command") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute command
        if [ $(hestiaSTRING_Is_Empty "$___arguments") -eq $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaSTRING_Is_Empty "$___log_stdout") -ne $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$___log_stderr") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" 1>"$___log_stdout" 2>"$___log_stderr"
                        ___process=$?
                elif [ $(hestiaSTRING_Is_Empty "$___log_stdout") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" 1>"$___log_stdout"
                        ___process=$?
                elif [ $(hestiaSTRING_Is_Empty "$___log_stderr") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" 2>"$___log_stderr"
                        ___process=$?
                else
                        "$___command"
                        ___process=$?
                fi
        else
                if [ $(hestiaSTRING_Is_Empty "$___log_stdout") -ne $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$___log_stderr") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" $___arguments 1>"$___log_stdout" 2>"$___log_stderr"
                        ___process=$?
                elif [ $(hestiaSTRING_Is_Empty "$___log_stdout") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" $___arguments 1>"$___log_stdout"
                        ___process=$?
                elif [ $(hestiaSTRING_Is_Empty "$___log_stderr") -ne $hestiaKERNEL_ERROR_OK ]; then
                        "$___command" $___arguments 2>"$___log_stderr"
                        ___process=$?
                else
                        "$___command" $___arguments
                        ___process=$?
                fi
        fi

        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
