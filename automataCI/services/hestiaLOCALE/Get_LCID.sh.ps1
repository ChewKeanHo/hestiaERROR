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
## More Info:
## https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lcid/70feba9f-294e-491e-b6eb-56532684c37f
function hestiaLOCALE-Get-LCID {
        param(
                [string]$___locale
        )


        # execute
        switch ($___locale) {
        "en" {
                return 9
        } { $_ -in "en-US", "en-us" } {
                return 1033
        } "zh" {
                return 30724
        } { $_ -in "zh-CN", "zh-cn" } {
                return 2052
        } { $_ -in "zh-Hans", "zh-hans" } {
                return 4
        } default {
                return 0
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
## More Info:
## https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lcid/70feba9f-294e-491e-b6eb-56532684c37f
hestiaLOCALE_Get_LCID() {
        #___locale="$1"


        # execute
        case "$1" in
        en)
                printf -- "%d" 9
                ;;
        en-US|en-us)
                printf -- "%d" 1033
                ;;
        zh)
                printf -- "%d" 30724
                ;;
        zh-CN|zh-cn)
                printf -- "%d" 2052
                ;;
        zh-Hans|zh-hans)
                printf -- "%d" 4
                ;;
        *)
                printf -- "%d" 0
                return 0
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
