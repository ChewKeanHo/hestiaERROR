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
. "${env:LIBS_HESTIA}\hestiaSTRING\IS_Empty.sh.ps1"




function hestiaSTRING-To-Titlecase {
        param (
                [string]$___content
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___content}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        $___buffer = ""
        $___resevoir = "${___content}"
        $___trigger = $true
        while ($___resevoir -ne "") {
                ## extract character
                $___char = $___resevoir.Substring(0, 1)
                if ($___char -eq "``") {
                        $___char = $___resevoir.Substring(0, 2)
                }
                $___resevoir = $___resevoir -replace "^${___char}", ""

                ## process character
                if ($___trigger ) {
                        $___char = $___char.ToUpper()
                } else {
                        $___char = $___char.ToLower()
                }
                $___buffer += $___char

                ## set next character action
                switch ("${___char}") {
                { $_ -in " ", "`r", "`n" } {
                        $___trigger = $true
                } default {
                        $___trigger = $false
                }}
        }


        # report status
        return $___buffer
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




hestiaSTRING_To_Titlecase() {
        #___content="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        ___buffer=""
        ___resevoir="$1"
        ___trigger=0
        while [ -n "$___resevoir" ]; do
                ## extract character
                ___char="$(printf -- "%.1s" "$___resevoir")"
                if [ "$___char" = '\' ]; then
                        ___char="$(printf -- "%.2s" "$___resevoir")"
                fi
                ___resevoir="${___resevoir#*${___char}}"

                ## process character
                if [ $___trigger -eq 0 ]; then
                        ___char="$(printf -- "%s" "$___char" | tr '[:lower:]' '[:upper:]')"
                else
                        ___char="$(printf -- "%s" "$___char" | tr '[:upper:]' '[:lower:]')"
                fi
                ___buffer="${___buffer}${___char}"

                ## set next character action
                case "$___char" in
                " "|"\r"|"\n")
                        ___trigger=0
                        ;;
                *)
                        ___trigger=1
                        ;;
                esac
        done


        # report status
        printf -- "%s" "$___buffer"
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
