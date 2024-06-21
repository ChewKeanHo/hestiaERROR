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
function hestiaZIP-Is-Available {
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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"




hestiaZIP_Is_Available() {
        # execute
        hestiaOS_Is_Command_Available "zip"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISSING
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        hestiaOS_Is_Command_Available "unzip"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISSING
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi


        # report status
        printf -- "%d" $hestiaKERNEL_ERROR_OK
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
