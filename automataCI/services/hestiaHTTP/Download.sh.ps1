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
. "${env:LIBS_HESTIA}\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaHTTP\Call.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaHTTP\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSHASUM\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaHTTP-Download {
        param (
                [string]$___method,
                [string]$___url,
                [string]$___filepath,
                [string]$___headers,
                [string]$___shasum_type,
                [string]$___shasum_value,
                [string]$___data
        )


        # validate input
        if ($(hestiaHTTP-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKENREL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___method) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        if ($(hestiaSTRING-Is-Empty $___url) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }


        # execute
        ## clean up workspace
        $null = hestiaFS-Remove $___filepath
        $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___filepath)"

        ## make the call
        $null =  hestiaHTTP-Call $___method $___url $___headers $___data $___filepath
        if ($(hestiaFS-Is-File $___filepath) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        ## checksum payload
        if (
                ($(hestiaSTRING-Is-Empty $___shasum_type) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___shasum_value) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_OK}
        }

        if ($(hestiaSHASUM-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_UNSUPPORTED}
        }

        if (-not "$(hestiaSHASUM-Create-From-File $___filepath $___shasum_type)" -eq $___shasum_value) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISMATCHED}
        }


        # report status
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
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaHTTP/Call.sh.ps1"
. "${LIBS_HESTIA}/hestiaHTTP/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSHASUM/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaHTTP_Download() {
        #___method="$1"
        #___url="$2"
        #___filepath="$3"
        #___headers="$4"
        #___shasum_type="$5"
        #___shasum_value="$6"
        #___data="$7"


        # validate input
        if [ $(hestiaHTTP_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKENREL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi


        # execute
        ## clean up workspace
        hestiaFS_Remove "$3"
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$3")"

        ## download payload
        hestiaHTTP_Call "$1" "$2" "$4" "$7" "$3"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Remove "$3"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        if [ $(hestiaFS_Is_File "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        ## checksum payload
        if [ $(hestiaSTRING_Is_Empty "$5") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi

        if [ $(hestiaSHASUM_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_UNSUPPORTED
        fi

        if [ ! "$(hestiaSHASUM_Create_From_File "$3" "$5")" = "$6" ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISMATCHED
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
