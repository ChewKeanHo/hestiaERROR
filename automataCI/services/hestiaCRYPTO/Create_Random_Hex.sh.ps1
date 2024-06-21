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
. "${env:LIBS_HESTIA}\hestiaCRYPTO\Create_Random_Data.sh.ps1"




function hestiaCRYPTO-Create-Random-Hex {
        param (
                [long]$___length
        )


        # execute
        return hestiaCRYPTO-Create-Random-Data $___length "0123456789ABCDEF"
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
. "${LIBS_HESTIA}/hestiaCRYPTO/Create_Random_Data.sh.ps1"




hestiaCRYPTO_Create_Random_Hex() {
        #___length="$1"


        # validate input
        printf -- "%s" "$(hestiaCRYPTO_Create_Random_Data "$1" 'A-F0-9')"
        return $?
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
