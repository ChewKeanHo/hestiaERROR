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
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Is-Filename-Has {
        param (
                [string]$___filepath,
                [string]$___target
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___filepath}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___target}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        if ($("${___filepath}" -replace ".*${___target}", '') -ne "${___filepath}") {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # execute
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
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Is_Filename_Has() {
        #___filepath="$1"
        #___target="$2"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_ENTITY_EMPTY
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_EMPTY
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ ! "${1#*${2}}" = "$1" ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_OK
                return $hestiaKERNEL_ERROR_OK
        fi


        # execute
        printf -- "%d" $hestiaKERNEL_ERROR_DATA_BAD
        return $hestiaKERNEL_ERROR_DATA_BAD
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>