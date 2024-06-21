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
. "${env:LIBS_HESTIA}\hestiaFS\Get_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaWASM\Is_Target_Valid.sh.ps1"




function hestiaWASM-Is-Target-Valid-JS {
        param (
                [string]$___target
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___target}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaWASM-Is-Target-Valid "${___target}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }


        # execute
        $___target = hestiaFS-Get-File "${___target}"
        if ($("${___target}" -replace '.*\.js$', '') -ne "${___target}") {
                return ${env:hestiaKERNEL_ERROR_OK}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_DATA_MISMATCHED}
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
. "${LIBS_HESTIA}/hestiaFS/Get_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaWASM/Is_Target_Valid.sh.ps1"




hestiaWASM_Is_Target_Valid_JS() {
        #___target="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_MISSING
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaWASM_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" $hestiaKERNEL_ERROR_DATA_INVALID
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi


        # execute
        ___target="$(hestiaFS_Get_File "$1")"
        if [ ! "${___target%%.js*}" = "$___target" ]; then
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
