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
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaHTTP\Is_Available.sh.ps1"




function hestiaNUPKG-Publish {
        param (
                [string]$___url,
                [string]$___target,
                [string]$___auth_token
        )


        # validate input
        if ($(hestiaHTTP-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISSING}
        }

        if (($(hestiaSTRING-Is-Empty "${___url}") -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty "${___auth_token}") -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty "${___target}") -eq ${env:hestiaKERNEL_ERROR_OK})) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        $___arguments = "--request PUT " +
                        "--header `"X-NuGet-ApiKey: ${___auth_token}`"" +
                        "--header `"Authorization: ${___auth_token}`"" +
                        "--form `"package=@${___target}`"" +
                        "${___url}"
        $___process = hestiaOS-Exec "curl" "${___arguments}"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
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
. "${LIBS_HESTIA}/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaHTTP/Vanilla.sh.ps1"




hestiaNUPKG_Publish() {
        ___url="$1"
        ___auth_token="$2"
        ___target="$3"


        # validate input
        if [ $(hestiaHTTP_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi

        if [ $(hestiaSTRING_Is_Empty "$___url") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$___auth_token") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$___target") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        curl --request "PUT" \
                --header "X-NuGet-ApiKey: ${___auth_token}" \
                --header "Authorization: ${___auth_token}" \
                --form "package=@${___target}" \
                "$___url"
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
