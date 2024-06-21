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
function hestiaSHASUM-Is-Available {
        # execute
        if (-not [System.Security.Cryptography.SHA1]::Create("SHA1")) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if (-not [System.Security.Cryptography.SHA256]::Create("SHA256")) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if (-not [System.Security.Cryptography.SHA384]::Create("SHA384")) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if (-not [System.Security.Cryptography.SHA512]::Create("SHA512")) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
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
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"




hestiaSHASUM_Is_Available() {
        # execute
        if [ $(hestiaOS_Is_Command_Available "shasum") -ne $hestiaKERNEL_ERROR_OK ]; then
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
