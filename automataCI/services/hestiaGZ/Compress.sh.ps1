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
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaOS\Vanilla.sh.ps1"




function hestiaGZ-Compress {
        param (
                [string]$___source
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaFS-Is-File $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_FILE}
        }


        # execute
        $___source = $___source -replace "\.gz$"
        if ($(hestiaOS-Is-Command-Available "gzip") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $___process = hestiaOS-Exec "gzip" "-9 `"${___source}`""
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                return ${env:hestiaKERNEL_ERROR_OK}
        } elseif ($(hestiaOS-Is-Command-Available "gunzip") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $___process = hestiaOS-Exec "gunzip" "-9 `"${___source}`""
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
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
. "${LIBS_HESTIA}/hestiaFS/Is_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaGZ_Compress() {
        #___source="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaFS_Is_File "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_FILE
        fi


        # execute
        ___source="${1%.gz*}"
        if [ $(hestiaOS_Is_Command_Available "gzip") -eq $hestiaKERNEL_ERROR_OK ]; then
                gzip -9 "$___source"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                return $hestiaKERNEL_ERROR_OK
        elif [ $(hestiaOS_Is_Command_Available "gunzip") -eq $hestiaKERNEL_ERROR_OK ]; then
                gunzip -9 "$___source"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        return $hestiaKERNEL_ERROR_NOT_POSSIBLE
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>