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
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaSHASUM-Create-From-File {
        param (
                [string]$___target,
                [string]$___algo
        )


        # validate input
        if (
                ($(hestiaSTRING-Is-Empty "${___target}") -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty "${___algo}") -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ""
        }

        if ($(hestiaFS-Is-File "${___target}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        switch ($___algo) {
        '1' {
                $___hasher = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
        } '224' {
                return ""
        } '256' {
                $___hasher = New-Object System.Security.Cryptography.SHA256CryptoServiceProvider
        } '384' {
                $___hasher = New-Object System.Security.Cryptography.SHA384CryptoServiceProvider
        } '512' {
                $___hasher = New-Object System.Security.Cryptography.SHA512CryptoServiceProvider
        } '512224' {
                return ""
        } '512256' {
                return ""
        } Default {
                return ""
        }}

        $___fileStream = [System.IO.File]::OpenRead($___target)
        $___hash = $___hasher.ComputeHash($___fileStream)
        return [System.BitConverter]::ToString($___hash).Replace("-", "").ToLower()
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
. "${LIBS_HESTIA}/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaSHASUM_Create_From_File() {
        #___target="$1"
        #___algo="$2"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        case "$2" in
        1|224|256|384|512|512224|512256)
                ;;
        *)
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_INVALID
                ;;
        esac


        # execute
        if [ ! $(hestiaOS_Is_Command_Available "shasum") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi
        ___output="$(shasum -a "$2" "$1")"
        printf -- "%s" "${___output%% *}"


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
