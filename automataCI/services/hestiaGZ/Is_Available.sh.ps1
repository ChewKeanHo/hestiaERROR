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
. "${env:LIBS_HESTIA}\hestiaOS\Is_Available.sh.ps1"




function hestiaGZ-Is-Available {
        # execute
        if ($(hestiaOS-Is-Command-Available "gzip") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaOS-Is-Command-Available "gunzip") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
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
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"




hestiaGZ_Is_Available() {
        # execute
        if [ $(hestiaOS_Is_Command_Available "gzip") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_OK
                return $hestiaKERNEL_ERROR_OK
        elif [ $(hestiaOS_Is_Command_Available "gunzip") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_OK
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "%d" $hestiaKERNEL_ERROR_NOT_POSSIBLE
        return $hestiaKERNEL_ERROR_NOT_POSSIBLE
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
