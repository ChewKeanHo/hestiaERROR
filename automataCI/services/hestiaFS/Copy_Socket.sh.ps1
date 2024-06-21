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
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Copy-Socket {
        param (
                [string]$___destination_directory,
                [string]$___source
        )

        # validate input
        if ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-Socket $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_SOCKET}
        }

        if ($(hestiaFS-Is-Directory $___destination_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_INVALID}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_UNSUPPORTED} # windows does not have socket file
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
. "${LIBS_HESTIA}/hestiaFS/Get_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Exist.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Copy_Socket() {
        #___destination_directory="$1"
        #___source="$2"


        # validate input
        if [ $(hestiaOS_Is_Command_Available "tar") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_Socket "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_SOCKET
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_INVALID
        fi


        # execute
        ___current_directory="$PWD" && cd "$(hestiaFS_Get_Directory "$2")"
        tar -cpf- "$(hestiaFS_Get_File "$2")" | tar -xf- -C "$1"
        ___process=$?
        cd "$___current_directory" && unset ___current_directory
        if [ $___process -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        return $hestiaKERNEL_ERROR_BAD_EXEC
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
