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
function hestiaI18N-Translate-Publish-Skipped {
        param (
                [string]$___locale
        )


        # execute
        switch -Wildcard ($___locale) {
        "zh-hans*" {
                # 简体中文
                return "跳过发布步骤。"
        } default {
                # fallback to default english
                return "publish skipped."
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
hestiaI18N_Translate_Publish_Skipped() {
        #___locale="$1"


        # execute
        case "$1" in
        zh-hans*)
                # 简体中文
                printf -- "%s" "跳过发布步骤。"
                ;;
        *)
                # fallback to default english
                printf -- "%s" "publish skipped."
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>