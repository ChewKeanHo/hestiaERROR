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




function hestiaFS-Is-Exist {
        param (
                [string]$___target
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        if ($(hestiaFS-Is-Directory $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaFS-Is-File $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaFS-Is-Socket $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaFS-Is-Symbolic-Link $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                if (Test-Path -Path "$((Get-Item $___target).Target)") {
                        return ${env:hestiaKERNEL_ERROR_OK}
                }

                return ${env:hestiaKERNEL_ERROR_DATA_DEAD}
        }

        if (Test-Path -PathType Any -Path $___target) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_DATA_BAD}
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




hestiaFS_Is_Exist() {
        #___target="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "$hestiaKERNEL_ERROR_DATA_EMPTY"
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ $(hestiaFS_Is_Directory "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaFS_Is_File "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaFS_Is_Socket "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaFS_Is_Symbolic_Link "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                if [ -e "$1" ]; then
                        printf -- "$hestiaKERNEL_ERROR_OK"
                        return $hestiaKERNEL_ERROR_OK
                fi

                printf -- "$hestiaKERNEL_ERROR_DATA_DEAD"
                return $hestiaKERNEL_ERROR_DATA_DEAD
        fi

        if [ -e "$1" ]; then
                printf -- "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "$hestiaKERNEL_ERROR_DATA_BAD"
        return $hestiaKERNEL_ERROR_DATA_BAD
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
