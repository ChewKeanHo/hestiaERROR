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
function hestiaOS-To-Arch-MSFT {
        param (
                [string]$___value
        )


        # execute
        switch ($___value) {
        "alpha" {
                return "Alpha"
        } "arm" {
                return "ARM"
        } "arm64" {
                return "ARM64"
        } "ia64" {
                return "ia64"
        } "i386" {
                return "x86"
        } "mips" {
                return "MIPs"
        } "amd64" {
                return "x64"
        } "powerpc" {
                return "PowerPC"
        } default {
                return ""
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
hestiaOS_To_Arch_MSFT() {
        #___value="$1"


        # execute
        case "$(printf -- "%b" "$1" | tr '[:upper:]' '[:lower:]')" in
        alpha)
                printf -- "%s" "Alpha"
                ;;
        arm)
                printf -- "%s" "ARM"
                ;;
        arm64)
                printf -- "%s" "ARM64"
                ;;
        ia64)
                printf -- "%s" "ia64"
                ;;
        i386)
                printf -- "%s" "x86"
                ;;
        mips)
                printf -- "%s" "MIPs"
                ;;
        amd64)
                printf -- "%s" "x64"
                ;;
        powerpc)
                printf -- "%s" "PowerPC"
                ;;
        *)
                printf -- ""
                ;;
        esac
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
