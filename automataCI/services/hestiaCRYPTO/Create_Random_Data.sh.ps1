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




function hestiaCRYPTO-Create-Random-Data {
        param (
                [long]$___length,
                [string]$___charset
        )


        # validate input
        if ($___length -le 0) {
                $___length = 33
        }

        if ($(hestiaSTRING-Is-Empty $___charset) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        $___outcome = [char[]]@(0) * $___length
        $___bytes = [byte[]]@(0) * $___length
        $___crypter = [System.Security.Cryptography.RandomNumberGenerator]::Create()
        $null = $___crypter.GetBytes($___bytes)
        $null = $___crypter.Dispose()

        for ($___i = 0; $___i -lt $___length; $___i++) {
                $___index = [int] ($___bytes[$___i] % $___charset.Length)
                $___outcome[$___i] = [char] $___charset[$___index]
        }


        # report status
        return $___outcome -join "";
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
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaCRYPTO_Create_Random_Data() {
        #___length="$1"
        #___charset="$2"


        # validate input
        if [ -n "$1" -a $1 -eq $1 2> /dev/null -a $1 -gt 0 ]; then
                ___length=$1
        else
                ___length=33
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaOS_Is_Command_Available "dd") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaOS_Is_Command_Available "tr") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaFS_Is_Exist "/dev/urandom") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi


        # execute
        ___output=""
        ___count=0

        # NOTE:
        #   (1) MacOS's 'tr' won't break itself when reading directly from
        #       /dev/urandom source.
        #   (2) Using 'dd' directly against /dev/urandom cannot warrant the
        #       output length we wanted.
        #   (3) So, we do not have a choice but to perform loop capturing until
        #       we get exactly what we wanted.
        #   (4) If you have better idea without compromising crypto-randomness
        #       while improving the performance, please inform the maintainers.
        #   (5) For now, this is what we have. Blame note (1) for behaving
        #       weirdly especially coming from an organ-selling priced hardware.
        while [ $___count -ne $___length ]; do
                ___char="$(dd bs=1 if=/dev/urandom count=1 2> /dev/null \
                                | LC_ALL=C tr -dc "$2" 2> /dev/null)"
                if [ -z "$___char" ]; then
                        continue
                fi

                ___output="${___output}${___char}"

                # increase counter for successful capture
                ___count=$(($___count + ${#___char}))
        done


        # report status
        printf -- "%s" "$___output"
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
