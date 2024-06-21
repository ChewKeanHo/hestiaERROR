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
function hestiaI18N-Translate-Recreate {
        param (
                [string]$___locale,
                [string]$___name
        )


        # execute
        if ($___name -eq "") {
                $___name = "???"
        }

        switch -Wildcard ($___locale) {
        "zh-hans*" {
                # 简体中文
                return "从新制作着‘${___name}’。。。"
        } default {
                # fallback to default english
                return "recreating '${___name}'..."
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
hestiaI18N_Translate_Recreate() {
        #___locale="$1"
        #___name="$2"


        # execute
        case "$1" in
        zh-hans*)
                # 简体中文
                printf -- "%s" "从新制作着‘${2:-???}’。。。"
                ;;
        *)
                # fallback to default english
                printf -- "%s" "recreating '${2:-???}'..."
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
