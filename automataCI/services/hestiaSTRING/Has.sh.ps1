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




function hestiaSTRING-Has {
        param (
                [string]$___subject,
                [string]$___target
        )


        # validate input
        if ([string]::IsNullOrEmpty($___target)) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ([string]::IsNullOrEmpty($___subject)) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }


        # execute
        if ($("${___subject}" -replace "^.*${___target}", '') -ne "${___subject}") {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${hestiaKERNEL_ERROR_DATA_MISMATCHED}
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




hestiaSTRING_Has() {
        #___subject="$1"
        #___target="$2"


        # validate input
        if [ -z "$1" ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_ENTITY_EMPTY
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ -z "$2" ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_EMPTY
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ ! "${1##*${2}}" = "$1" ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_OK
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISMATCHED
        return $hestiaKERNEL_ERROR_DATA_MISMATCHED
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
