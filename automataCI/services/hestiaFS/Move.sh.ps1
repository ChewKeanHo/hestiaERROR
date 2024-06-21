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
. "${env:LIBS_HESTIA}\hestiaFS\Is_Exist.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Move {
        param (
                [string]$___destination,
                [string]$___source
        )


        # validate input
       if ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
              return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
       }

       if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
              return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
       }

       if ($(hestiaFS-Is-Exist $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
              return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
       }

       if ($(hestiaFS-Is-Exist $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
              return ${env:hestiaKERNEL_ERROR_ENTITY_EXISTS}
       }


        # execute
        try {
                Move-Item -Force -Path $___source -Destination $___destination
                if ($?) {
                        $___process = ${env:hestiaKERNEL_ERROR_OK}
                } else {
                        $___process = ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } catch {
                $___process = ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # execute
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
. "${LIBS_HESTIA}/hestiaFS/Is_Exist.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Move() {
        #___destination="$1"
        #___source="$2"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_Exist "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaFS_Is_Exist "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EXISTS
        fi


        # execute
        mv "$2" "$1"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
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
