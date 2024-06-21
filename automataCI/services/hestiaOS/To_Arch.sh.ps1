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
function hestiaOS-To-Arch {
        param (
                [string]$___value
        )


        # execute
        switch ($___value.ToLower()) {
        { $_ -in "i686-64", "ia64" } {
                return "ia64"
        } { $_ -in "386", "i386", "486", "i486", "586", "i586", "686", "i686", "x86" } {
                return "i386"
        } { $_ -match "ip*" } {
                return "mips"
        } { $_ -in "x86_64", "x64" } {
                return "amd64"
        } "sun4u" {
                return "sparc"
        } { $_ -in "power macintosh" } {
                return "powerpc"
        } default {
                return $___value.ToLower()
        }}
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
hestiaOS_To_Arch() {
        #___value="$1"


        # execute
        case "$(printf -- "%b" "$1" | tr '[:upper:]' '[:lower:]')" in
        i686-64|ia64)
                printf -- "%s" "ia64"
                ;;
        386|i386|486|i486|586|i586|686|i686|x86)
                printf -- "%s" "i386"
                ;;
        x86_64|x64)
                printf -- "%s" "amd64"
                ;;
        sun4u)
                printf -- "%s" "sparc"
                ;;
        "power macintosh")
                printf -- "%s" "powerpc"
                ;;
        ip*)
                printf -- "%s" "mips"
                ;;
        *)
                printf -- "%s" "$1" | tr '[:upper:]' '[:lower:]'
                ;;
        esac
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
