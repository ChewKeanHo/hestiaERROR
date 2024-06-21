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
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Symbolic_Link.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Create-Directory {
        param (
                [string]$___filepath
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if (
                ($(hestiaFS-Is-File $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaFS-Is-Socket $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaFS-Is-Symbolic-Link $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY}
        }

        if ($(hestiaFS-Is-Directory $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }



        # execute
        $___process = New-Item -ItemType Directory -Force -Path "${___filepath}"
        if ($___process) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # execute
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
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
. "${LIBS_HESTIA}/hestiaFS/Is_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Symbolic_Link.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Create_Directory() {
        #___filepath="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaFS_Is_File "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaFS_Is_Socket "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaFS_Is_Symbolic_Link "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi

        if [ $(hestiaFS_Is_Directory "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi


        # execute
        mkdir -p "$1"
        if [ $? -ne 0 ]; then
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
