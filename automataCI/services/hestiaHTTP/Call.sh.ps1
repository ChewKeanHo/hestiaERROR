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
. "${env:LIBS_HESTIA}\hestiaHTTP\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaHTTP-Call {
        param (
                [string]$___method,
                [string]$___url,
                [string]$___headers,
                [string]$___data,
                [string]$___filepath
        )


        # validate input
        if ($(hestiaHTTP-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }

        if ($(hestiaSTRING-Is-Empty $___method) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }

        if ($(hestiaSTRING-Is-Empty $___url) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }

        if (
                ($(hestiaSTRING-Is-Empty $___data) -eq ${env:hestiaKERNEL_ERROR_OK}) -and
                ($(hestiaSTRING-Is-Empty $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ""
        }


        # execute
        ## prepare baseline arguments
        $___arguments = "--location --request '${___method}' --url `"${___url}`""

        ## prepare header arguments
        $___has_user_agent = $false
        if ($(hestiaSTRING-Is-Empty $___headers) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                foreach ($___line in ($___headers.Split("`n"))) {
                        if ($(hestiaSTRING-Is-Empty $___line) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                continue
                        }

                        if ($($___line -replace "^User-Agent:", '') -ne $___line) {
                                $___has_user_agent = $true
                        }

                        $___arguments = "${___arguments} --header `"${___line}`""
                }
        }

        if (-not $___has_user_agent) {
                $___arguments = "${___arguments} --header 'User-Agent: "
                $___arguments += "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                $___arguments += "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 "
                $___arguments += "Safari/605.1.15"
                $___arguments += "'"
        }

        ## prepare data arguments
        if ($(hestiaSTRING-Is-Empty $___data) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                foreach ($___line in ($___data.Split("`n"))) {
                        if ($(hestiaSTRING-Is-Empty $___line) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                continue
                        }

                        $___arguments = "${___arguments} --data-binary `"${___line}`""
                }
        }

        ## prepare output argument
        if ($(hestiaSTRING-Is-Empty $___filepath) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaFS-Is-Exist $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        return ""
                }

                $___arguments = "${___arguments} --output `"${___filepath}`""
        }

        ## make the call
        try {
                $___output = Get-Command 'curl' -ErrorAction SilentlyContinue
                $___output = Invoke-Expression -Command "${___output} ${___arguments}"
                if ($LASTEXITCODE -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        if ($(hestiaSTRING-Is-Empty $___filepath) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $null = hestiaFS-Remove $___filepath
                        }
                }

                return $___output
        } catch {
                return ""
        }
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
. "${LIBS_HESTIA}/hestiaHTTP/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaHTTP_Call() {
        #___method="$1"
        #___url="$2"
        #___headers="$3"
        #___data="$4"
        #___filepath="$5"


        # validate input
        if [ $(hestiaHTTP_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKENREL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi


        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$4") -eq $hestiaKERNEL_ERROR_OK ] &&
                [ $(hestiaSTRING_Is_Empty "$5") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi


        # execute
        ## prepare baseline arguments
        ___arguments="--location --request '${1}' --url \"$2\""

        ## prepare header arguments
        ___has_user_agent=1
        if [ $(hestiaSTRING_Is_Empty "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___old_IFS="$IFS"
                while IFS= read -r ___line || [ -n "$___line" ]; do
                        if [ $(hestiaSTRING_Is_Empty "$___line") -eq $hestiaKERNEL_ERROR_OK ]; then
                                continue
                        fi

                        if [ ! "${___line##*User-Agent:}" = "${___line}" ]; then
                                ___has_user_agent=0
                        fi

                        ___arguments="${___arguments} --header \"${___line}\""
                done <<EOF
${3}
EOF
                IFS="$___old_IFS" && unset ___old_IFS
        fi

        if [ $___has_user_agent -ne 0 ]; then
                ___arguments="${___arguments} --header \"\
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) \
AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 \
Safari/605.1.15\""
        fi

        ## prepare data arguments
        if [ $(hestiaSTRING_Is_Empty "$4") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___old_IFS="$IFS"
                while IFS= read -r ___line || [ -n "$___line" ]; do
                        if [ $(hestiaSTRING_Is_Empty "$___line") -eq $hestiaKERNEL_ERROR_OK ]; then
                                continue
                        fi

                        ___arguments="${___arguments} --data-binary \"${___line}\""
                done <<EOF
${4}
EOF
                IFS="$___old_IFS" && unset ___old_IFS
        fi

        ## prepare output argument
        if [ $(hestiaSTRING_Is_Empty "$5") -ne $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaFS_Is_Exist "$5") -eq $hestiaKERNEL_ERROR_OK ]; then
                        printf -- ""
                        return $hestiaKERNEL_ERROR_ENTITY_EXISTS
                fi

                ___arguments="${___arguments} --output \"${5}\""
        fi

        ## make the call
        # IMPORTANT NOTICE (UNIX)
        #       (1) It appears that curl cannot interpret expanded $___arguments
        #           properly (it takes any quoted argument with space and split
        #           them illegally). One good case is the 'User-Agent: ' header
        #           above being illegally interpreted as multiple URLs instead
        #           (despite --url is being properly set).
        #       (2) Fortunately, the classical but evil 'eval' is still working
        #           so we will use it here with this notice.
        eval "curl $___arguments"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaSTRING_Is_Empty "$5") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Remove "$5"
                fi

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
