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
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"




function hestiaFS-Is-Socket {
        param (
                [string]$___target
        )


        # execute
        return ${env:hestiaKERNEL_ERROR_UNSUPPORTED} # windows does not have socket file
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
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Is_Socket() {
        #___target="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" "$hestiaKERNEL_ERROR_DATA_EMPTY"
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ -S "$1" ]; then
                printf -- "%d" "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "%d" "$hestiaKERNEL_ERROR_DATA_BAD"
        return $hestiaKERNEL_ERROR_DATA_BAD
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
