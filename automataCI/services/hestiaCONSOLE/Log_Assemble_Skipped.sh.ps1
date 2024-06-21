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
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Assemble_Skipped.sh.ps1"




function hestiaCONSOLE-Log-Assemble-Skipped {
        param (
                [string]$___appendix,
                [string]$___lang
        )


        # execute
        $___lang = hestiaLOCALE-Get-Lang $___lang
        $null = hestiaCONSOLE-Log warning `
                "$(hestiaI18N-Translate-Assemble-Skipped $___lang)`n" `
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
. "${LIBS_HESTIA}/hestiaI18N/Translate_Assemble_Skipped.sh.ps1"




hestiaCONSOLE_Log_Assemble_Skipped() {
        #___appendix="$1"
        #___lang="$1"


        # execute
        ___lang="$(hestiaLOCALE_Get_Lang "$1")"
        hestiaCONSOLE_Log warning \
                "$(hestiaI18N_Translate_Assemble_Skipped "$___lang")\n" \
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
