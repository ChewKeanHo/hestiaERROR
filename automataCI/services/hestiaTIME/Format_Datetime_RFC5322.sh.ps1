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
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaTIME-Format-Datetime-RFC5322 {
        param (
                [string]$___unix_epoch
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___unix_epoch}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        $___t = (Get-Date "1970-01-01 00:00:00.000Z") + ([TimeSpan]::FromSeconds($___unix_epoch))
        return $___t.ToString("ddd, dd MMM YYYY HH:mm:ss zzz")
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
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaTIME/Is_Available.sh.ps1"




hestiaTIME_Format_Datetime_RFC5322() {
        #___unix_epoch="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaTIME_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi


        # execute
        if [ "$(echo "$(uname)" | tr '[:upper:]' '[:lower:]')" = "darwin" ]; then
                printf -- "%b" "$(date -j -f "%s" "${1}" +"%a, %d %b %Y %H:%M:%S %z")"
        else
                printf -- "%b" "$(date --date="@${1}" +"%a, %d %b %Y %H:%M:%S %z")"
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
