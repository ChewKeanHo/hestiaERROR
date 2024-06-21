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
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaTAR\Is_Available.sh.ps1"




function hestiaTAR-Unpack {
        param (
                [string]$___destination,
                [string]$___source,
                [string]$___compression
        )


        # validate input
        if ($(hestiaTAR-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISSING}
        }

        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_IS_EMPTY}
        }

        if ($(hestiaFS-Is-Exist $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaFS-Is-Directory $___destination) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY}
                }
        }

        if ($(hestiaFS-Is-File $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }


        # execute
        $null = hestiaFS-Create-Directory $___destination
        switch ($___compression) {
        { $_ -in "xz", "XZ" } {
                $___process = hestiaOS-Exec "tar" "-C `"${___destination}`" -xf `"${___source}`""
        } { $_ -in "gz", "GZ" } {
                $___process = hestiaOS-Exec "tar" "-C `"${___destination}`" -xzf `"${___source}`""
        } default {
                $___process = hestiaOS-Exec "tar" "-C `"${___destination}`" -xf `"${___source}`""
        }}

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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaTAR/Is_Available.sh.ps1"




hestiaTAR_Unpack() {
        ___destination="$1"
        ___source="$2"
        ___compression="$3"


        # validate input
        if [ $(hestiaTAR_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_IS_EMPTY
        fi

        if [ $(hestiaFS_Is_Exist "$1") -eq $hestiaKERNEL_ERROR_OK ] &&
                [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi

        if [ $(hestiaFS_Is_File "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi


        # execute
        hestiaFS_Create_Directory "$1"
        case "$3" in
        xz|XZ)
                tar -C "$1" -xf "$2"
                ___process=$?
                ;;
        gz|GZ)
                tar -C "$1" -xzf "$2"
                ___process=$?
                ;;
        *)
                tar -C "$1" -xf "$2"
                ___process=$?
                ;;
        esac

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
