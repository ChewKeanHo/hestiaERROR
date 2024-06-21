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
. "${env:LIBS_HESTIA}\hestiaKERNEL\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Vanilla.sh.ps1"




function hestiaOS-Is-Command-Available {
        param (
                [string]$___command
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___command}") -eq ${env:hestiaERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }


        # execute
        $___process = Get-Command $___command -ErrorAction SilentlyContinue
        if ($___process) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
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
. "${LIBS_HESTIA}/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Vanilla.sh.ps1"




hestiaOS_Is_Command_Available() {
        #___command="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISSING
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi


        # execute
        if [ $(hestiaSTRING_Is_Empty "$(type -t "$1")") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_OK
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISSING
        return $hestiaKERNEL_ERROR_DATA_MISSING
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
