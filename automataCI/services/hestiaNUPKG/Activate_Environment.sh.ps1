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
. "${env:LIBS_HESTIA}\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaNUPKG\Is_Activated.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaNUPKG\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Vanilla.sh.ps1"




function hestiaNUPKG-Activate-Environment {
        param (
                [string]$___dotnet_directory
        )


        # validate input
        if ($(hestiaNUPKG-Is-Activated) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaNUPKG-Is-Available $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }


        # execute
        ${env:DOTNET_ROOT} = $___dotnet_directory
        ${env:PATH} += ";${env:DOTNET_ROOT};${env:DOTNET_ROOT}\bin"
        if ($(hestiaNUPKG-Is-Activated) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaNUPKG/Is_Activated.sh.ps1"
. "${LIBS_HESTIA}/hestiaNUPKG/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaNUPKG_Activate_Environment() {
        #___dotnet_directory="$1"


        # validate input
        if [ $(hestiaNUPKG_Is_Activated) -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaNUPKG_Is_Available "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi


        # execute
        DOTNET_ROOT="$1"
        alias dotnet="${1}/dotnet"
        if [ $(hestiaSTRING_Is_Empty "$DOTNET_CLI_TELEMETRY_OPTOUT") -ne $hestiaKERNEL_ERROR_OK ]; then
                DOTNET_CLI_TELEMETRY_OPTOUT=1
        fi

        if [ $(hestiaNUPKG_Is_Activated) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
