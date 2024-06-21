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
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaLOCALE\Get_Lang.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Package_Failed.sh.ps1"




function hestiaCONSOLE-Log-Package-Failed {
        param (
                [string]$___appendix,
                [string]$___lang
        )


        # execute
        $___lang = hestiaLOCALE-Get-Lang $___lang
        $null = hestiaCONSOLE-Log error `
                "$(hestiaI18N-Translate-Package-Failed $___lang)`n" `
                $___lang `
                $___appendix


        # report status
        return 0
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
. "${LIBS_HESTIA}/hestiaCONSOLE/Log.sh.ps1"
. "${LIBS_HESTIA}/hestiaLOCALE/Get_Lang.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Package_Failed.sh.ps1"




hestiaCONSOLE_Log_Package_Failed() {
        #___appendix="$1"
        #___lang="$2"


        # execute
        ___lang="$(hestiaLOCALE_Get_Lang "$2")"
        hestiaCONSOLE_Log error \
                "$(hestiaI18N_Translate_Package_Failed "$___lang")\n" \
                "$___lang" \
                "$1"


        # report status
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
