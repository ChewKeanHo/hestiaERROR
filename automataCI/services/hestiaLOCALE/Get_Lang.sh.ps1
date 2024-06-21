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
function hestiaLOCALE-Get-Lang {
        param (
                [string]$___lang
        )


        # execute
        if (-not [string]::IsNullOrEmpty($___lang)) {
                return $___lang
        } elseif (-not [string]::IsNullOrEmpty(${env:PROJECT_LANG})) {
                return "${env:PROJECT_LANG}"
        } elseif (-not [string]::IsNullOrEmpty(${env:AUTOMATACI_LANG})) {
                return "${env:AUTOMATACI_LANG}" # compatible with AutomataCI
        }


        # fallback to getting from system settings
        $___lang = Get-WinSystemLocale
        $___lang = $___lang -replace '[_-][A-Z]*$', ''
        $___lang = $___lang -replace '_', '-'
        return $___lang
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
hestiaLOCALE_Get_Lang() {
        #___lang="$1"


        # execute
        if [ ! "$1" = "" ]; then
                printf -- "%s" "$1"
                return 0
        elif [ ! "$PROJECT_LANG" = "" ]; then
                printf -- "%s" "$PROJECT_LANG"
                return 0
        elif [ ! "$AUTOMATACI_LANG" = "" ]; then
                printf -- "%s" "$AUTOMATACI_LANG" # comaptible with AutomataCI
                return 0
        fi


        # fallback to getting from system settings
        ___lang="${LC_ALL:$LANG}"
        ___lang="${___lang%.*}"
        ___lang="${___lang%_[A-Z]*}"
        ___lang="$(printf -- "%b" "$___lang" | tr '_' '-')"
        if [ "$___lang" = "C" ] || [ "$___lang" = "" ]; then
                ___lang="en" # fallback to english then
        fi
        printf -- "%s" "$___lang"


        # report status
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
