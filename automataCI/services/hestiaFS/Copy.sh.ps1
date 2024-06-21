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
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Symbolic_Link.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Symbolic_Link.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Copy {
        param (
                [string]$___destination,
                [string]$___source,
                [string]$___resolve_link
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        if ($(hestiaFS-Is-Socket $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return hestiaFS-Copy-Socket $___destination $___source
        } elseif ($(hestiaFS-Is-Symbolic-Link $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaSTRING-Is-Empty $___resolve_link) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return hestiaFS-Copy-File $___destination $___source
                }

                return hestiaFS-Copy-Symbolic-Link $___destination $___source
        } elseif ($(hestiaFS-Is-Directory $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return hestiaFS-Copy-Directory $___destination $___source
        } elseif ($(hestiaFS-Is-File $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return hestiaFS-Copy-File $___destination $___source
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_UNSUPPORTED}
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
. "${LIBS_HESTIA}/hestiaFS/Copy_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_Symbolic_Link.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Symbolic_Link.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Copy() {
        #___destination="$1"
        #___source="$2"
        #___resolve_link="$3"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ $(hestiaFS_Is_Socket "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Copy_Socket "$1" "$2"
                return $?
        elif [ $(hestiaFS_Is_Symbolic_Link "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaSTRING_Is_Empty "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Copy_File "$1" "$2"
                        return $?
                fi

                hestiaFS_Copy_Symbolic_Link "$1" "$2"
                return $?
        elif [ $(hestiaFS_Is_Directory "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Copy_Directory "$1" "$2"
                return $?
        elif [ $(hestiaFS_Is_File "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Copy_File "$1" "$2"
                return $?
        fi


        # report status
        return $hestiaKERNEL_ERROR_UNSUPPORTED
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
