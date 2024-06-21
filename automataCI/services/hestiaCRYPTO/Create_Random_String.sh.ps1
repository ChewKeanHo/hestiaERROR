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
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCRYPTO\Create_Random_Data.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaCRYPTO-Create-Random-String {
        param (
                [long]$___length,
                [string]$___charset
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___charset) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $___charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                $___charset += "abcdefghijklmnopqrstuvwxyz"
                $___charset += "0123456789"
        }


        # execute
        return hestiaCRYPTO-Create-Random-Data $___length $___charset
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




hestiaCRYPTO_Create_Random_String() {
        #___length="$1"
        #___charset="$2"


        # validate input
        printf -- "%s" "$(hestiaCRYPTO_Create_Random_Data "$1" "${2:-a-zA-Z0-9}")"
        return $?
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
