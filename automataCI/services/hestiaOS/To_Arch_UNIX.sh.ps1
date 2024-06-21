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
function hestiaOS-To-Arch-UNIX {
        param (
                [string]$___value
        )


        # execute
        switch ($___value.ToLower()) {
        "any" {
                return "all"
        } { $_ -in "386", "i386", "486", "i486", "586", "i586", "686", "i686" } {
                return "i386"
        } "armle" {
                return "armel"
        } "mipsle" {
                return "mipsel"
        } "mipsr6le" {
                return "mipsr6el"
        } "mipsn32le" {
                return "mipsn32el"
        } "mipsn32r6le" {
                return "mipsn32r6el"
        } "mips64le" {
                return "mips64el"
        } "mips64r6le" {
                return "mips64r6el"
        } "powerpcle" {
                return "powerpcel"
        } "ppc64le" {
                return "ppc64el"
        } default {
                return $___value.ToLower()
        }}
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
hestiaOS_To_Arch_UNIX() {
        #___value="$1"


        # execute
        case "$(printf -- "%b" "$1" | tr '[:upper:]' '[:lower:]')" in
        any)
                printf -- "%s" "all"
                ;;
        386|i386|486|i486|586|i586|686|i686)
                printf -- "%s" "i386"
                ;;
        armle)
                printf -- "%s" "armel"
                ;;
        mipsle)
                printf -- "%s" "mipsel"
                ;;
        mipsr6le)
                printf -- "%s" "mipsr6el"
                ;;
        mipsn32le)
                printf -- "%s" "mipsn32el"
                ;;
        mipsn32r6le)
                printf -- "%s" "mipsn32r6el"
                ;;
        mips64le)
                printf -- "%s" "mips64el"
                ;;
        mips64r6le)
                printf -- "%s" "mips64r6el"
                ;;
        powerpcle)
                printf -- "%s" "powerpcel"
                ;;
        ppc64le)
                printf -- "%s" "ppc64el"
                ;;
        *)
                printf -- "%b" "$1" | tr '[:upper:]' '[:lower:]'
                ;;
        esac
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
