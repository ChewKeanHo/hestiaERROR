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
. "${env:LIBS_HESTIA}\hestiaGIT\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaGIT-Clone {
        param (
                [string]$___url,
                [string]$___directory
        )


        # validate input
        if ($(hestiaGIT-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___url) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaFS-Is-Exist $___directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EXISTS}
        }


        # execute
        $___process = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___directory)"
        if ($___process -ne $hestiaKERNEL_ERROR_OK) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        $___current_path = Get-Location
        $null = Set-Location "$(hestiaFS-Get-Directory $___directory)"
        $___process = hestiaOS-Exec "git" "clone `"${___url}`" `"${___directory}`""
        $null = Set-Location $___current_path
        $null = Remove-Variable ___current_path
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
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaGIT/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaGIT_Clone() {
        #___url="$1"
        #___directory="$2"


        # validate input
        if [ $(hestiaGIT_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaFS_Is_Exist "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EXISTS
        fi


        # execute
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$2")"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        ___current_path="$PWD"
        cd "$(hestiaFS_Get_Directory "$2")"
        git clone "$1" "$2"
        ___process=$?
        cd "$___current_path"
        unset ___current_path

        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
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
