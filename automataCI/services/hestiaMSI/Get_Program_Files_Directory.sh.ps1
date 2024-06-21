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
function hestiaMSI-Get-Program-Files-Directory {
        param (
                [string]$___arch
        )


        # execute
        switch ($___arch) {
        { $_ -in "amd64", "arm64" } {
                return "ProgramFiles64Folder"
        } { $_ -in "i386", "arm" } {
                return "ProgramFilesFolder"
        } default {
                return "ProgramFiles6432Folder"
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
hestiaMSI_Get_Program_Files_Directory() {
        #___arch="$1"


        # execute
        case "$1" in
        amd64|arm64)
                printf -- "%s" "ProgramFiles64Folder"
                ;;
        i386|arm)
                printf -- "%s" "ProgramFilesFolder"
                ;;
        *)
                printf -- ""
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
