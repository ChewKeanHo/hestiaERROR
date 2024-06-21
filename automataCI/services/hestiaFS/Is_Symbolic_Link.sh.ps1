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




function hestiaFS-Is-Symbolic-Link {
        param (
                [string]$___target
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if (-not (Test-Path -PathType Any -Path $___target -ErrorAction SilentlyContinue)) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }


        # execute
        try {
                $___link = (Get-Item $___target).LinkType
                if (
                        ($___link -eq "HardLink") -or
                        ($___link -eq "SymbolicLink")
                ) {
                        return ${env:hestiaKERNEL_ERROR_OK}
                }
        } catch {
                # something bad happened during the Get-Item
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_LINK}
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




hestiaFS_Is_Symbolic_Link() {
        #___target="$1"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "$hestiaKERNEL_ERROR_DATA_EMPTY"
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ ! -e "$1" ]; then
                printf -- "$hestiaKERNEL_ERROR_DATA_EMPTY"
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ -L "$1" ]; then
                printf -- "$hestiaKERNEL_ERROR_OK"
                return $hestiaKERNEL_ERROR_OK
        fi


        # report status
        printf -- "$hestiaKERNEL_ERROR_DATA_IS_NOT_LINK"
        return $hestiaKERNEL_ERROR_DATA_IS_NOT_LINK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
