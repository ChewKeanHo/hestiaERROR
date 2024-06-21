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
. "${env:LIBS_HESTIA}\hestiaLOCALE\Get_Lang.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Done.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Error.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Info.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Note.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_OK.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Success.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Warning.sh.ps1"




function hestiaCONSOLE-Log {
        param(
                [string]$___mode,
                [string]$___message,
                [string]$___lang,
                [string]$___appendix
        )


        # execute
        $___lang = hestiaLOCALE-Get-Lang $___lang
        $___color = ""
        $___foreground_color = "Gray"
        switch ($___mode) {
        error {
                $___tag = hestiaI18N-Translate-Error $___lang
                $___color = "31"
                $___foreground_color = "Red"
        } warning {
                $___tag = hestiaI18N-Translate-Warning $___lang
                $___color = "33"
                $___foreground_color = "Yellow"
        } info {
                $___tag = hestiaI18N-Translate-Info $___lang
                $___color = "36"
                $___foreground_color = "Cyan"
        } note {
                $___tag = hestiaI18N-Translate-Note $___lang
                $___color = "35"
                $___foreground_color = "Magenta"
        } success {
                $___tag = hestiaI18N-Translate-Success $___lang
                $___color = "32"
                $___foreground_color = "Green"
        } ok {
                $___tag = hestiaI18N-Translate-OK $___lang
                $___color = "36"
                $___foreground_color = "Cyan"
        } done {
                $___tag = hestiaI18N-Translate-Done $___lang
                $___color = "36"
                $___foreground_color = "Cyan"
        } default {
                $___tag = ""
                $___color = ""
                $___foreground_color = ""
        }}

        if (-not [string]::IsNullOrEmpty($___tag)) {
                $___tag = "⦗ $($___tag.ToUpper()) ⦘"
                $___tag = "$("{0,-14} " -f $___tag)"
        }

        if (-not [string]::IsNullOrEmpty($___appendix)) {
                $___message ="${___appendix} ➞ ${___message}"
        }

        if (
                ($Host.UI.RawUI.ForegroundColor -ge "DarkGray") -or
                (${env:TERM} -eq "xterm-256color") -or
                (${env:COLORTERM} -eq "truecolor", "24bit") -and
                (
                        (-not ([string]::IsNullOrEmpty($___color))) -and
                        (-not ([string]::IsNullOrEmpty($___foreground_color)))
                )
        ) {
                # terminal supports color mode
                $null = Write-Host `
                        -NoNewLine `
                        -ForegroundColor $___foreground_color @"
$([char]0x1b)[1;${___color}m${___tag}$([char]0x1b)[0;${___color}m${___message}$([char]0x1b)[0m
"@
        } else {
                $null = Write-Host -NoNewLine "${___tag}${___message}"
        }
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
. "${LIBS_HESTIA}/hestiaLOCALE/Get_Lang.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Done.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Error.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Info.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Note.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_OK.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Success.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Warning.sh.ps1"




hestiaCONSOLE_Log() {
        #___mode="$1"
        #___message="$2"
        #___lang="$3"
        #___appendix="$4"


        # execute
        ___lang="$(hestiaLOCALE_Get_Lang "$3")"
        ___color=""
        case "$1" in
        error)
                ___tag="$(hestiaI18N_Translate_Error "$___lang")"
                ___color="31"
                ;;
        warning)
                ___tag="$(hestiaI18N_Translate_Warning "$___lang")"
                ___color="33"
                ;;
        info)
                ___tag="$(hestiaI18N_Translate_Info "$___lang")"
                ___color="36"
                ;;
        note)
                ___tag="$(hestiaI18N_Translate_Note "$___lang")"
                ___color="35"
                ;;
        success)
                ___tag="$(hestiaI18N_Translate_Success "$___lang")"
                ___color="32"
                ;;
        ok)
                ___tag="$(hestiaI18N_Translate_OK "$___lang")"
                ___color="36"
                ;;
        done)
                ___tag="$(hestiaI18N_Translate_Done "$___lang")"
                ___color="36"
                ;;
        *)
                # do nothing
                ;;
        esac

        if [ ! "$___tag" = "" ]; then
                ___tag="⦗ $(printf -- "%s" "$___tag" | tr '[:lower:]' '[:upper:]') ⦘"
                ___tag="$(printf -- "%-17s " "$___tag")"
        fi

        ___msg="$2"
        if [ ! -z "$4" ]; then
                ___msg="${4} ➞ ${___msg}"
        fi

        if ([ ! -z "$COLORTERM" ] || [ "$TERM" = "xterm-256color" ]) && [ ! -z "$___color" ]; then
                # terminal supports color mode
                1>&2 printf -- "\033[1;${___color}m%s\033[0;${___color}m %b\033[0m" \
                        "$___tag" \
                        "$___msg"
        else
                1>&2 printf -- "%s%b" "$___tag" "$___msg"
        fi
        unset ___color ___tag ___lang ___msg


        # report status
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
