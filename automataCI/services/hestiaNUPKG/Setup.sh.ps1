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
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaNUPKG\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaNUPKG-Setup {
        param (
                [string]$___dotnet_directory,
                [string]$___dotnet_channel
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___dotnet_directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___dotnet_channel) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        if ($(hestiaFS-Is-Directory $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_NOT_DIRECTORY}
        }

        if ($(hestiaNUPKG-Is-Available $___dotnet_directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # execute
        $___arguments = "-ExecutionPolicy RemoteSigned " `
                + "${env:LIBS_HESTIA}\hestiaNUPKG\dotnet-install.ps1 " `
                + "-Channel ${___dotnet_channel} " `
                + "-InstallDir `"${___dotnet_directory}`""
        $___process = hestiaOS-Exec "powershell" "${___arguments}"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        if ($(hestiaNUPKG-Is-Available $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
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
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaNUPKG/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaNUPKG_Setup() {
        #___dotnet_directory="$1"
        #___dotnet_channel="$2"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENITTY_EMPTY
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_NOT_DIRECTORY
        fi

        if [ $(hestiaNUPKG_Is_Available "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi


        # execute
        "${LIBS_HESTIA}/hestiaNUPKG/dotnet-install.sh" --channel "$2" --install-dir "$1"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        if [ $(hestiaNUPKG_Is_Available "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
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
