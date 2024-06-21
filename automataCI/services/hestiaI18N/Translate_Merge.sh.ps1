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
function hestiaI18N-Translate-Merge {
        param (
                [string]$___locale,
                [string]$___destination,
                [string]$___source
        )


        # execute
        if ($___destination -eq "") {
                $___destination = "???"
        }

        if ($___source -eq "") {
                $___source = "???"
        }

        switch -Wildcard ($___locale) {
        "zh-hans*" {
                # 简体中文
                return "合并着‘${___source}’进入‘${___destination}’。。。"
        } default {
                # fallback to default english
                return "merging '${___source}' into '${___destination}'..."
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
hestiaI18N_Translate_Merge() {
        #___locale="$1"
        #___destination="$2"
        #___source="$3"


        # execute
        case "$1" in
        zh-hans*)
                # 简体中文
                printf -- "%s" "合并着‘${3:-???}’进入‘${2:-???}’。。。"
                ;;
        *)
                # fallback to default english
                printf -- "%s" "merging '${3:-???}' into '${2:-???}'..."
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
