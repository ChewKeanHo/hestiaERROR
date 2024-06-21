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
. "${env:LIBS_HESTIA}\hestiaGZ\Compress.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaTAR\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaOS\Exec.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaXZ\Compress.sh.ps1"




function hestiaTAR-Pack {
        param (
                [string]$___destination,
                [string]$___source,
                [string]$___compression,
                [string]$___owner,
                [string]$___group
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
                return ${env:hestiaKERNEL_ERROR_ENTITY_EXISTS}
        }

        if ($(hestiaFS-Is-Directory $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_FILE}
        }

        if ($(hestiaFS-Is-Directory $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        if ($(hestiaFS-Is-Directory-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        if ($($___destination -replace '\.txz$') -ne $___destination) {
                $___dest = $___destination -replace '\.txz$', ''
        } elseif ($($___destination -replace '\.tgz$') -ne $___destination) {
                $___dest = $___destination -replace '\.tgz$', ''
        } else {
                $___dest = $___destination -replace '\.tar.*$', ''
        }
        $___dest = "${___dest}.tar"

        if ($(hestiaFS-Get-Directory $___destination) -ne $___destination) {
                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___destination)"
        }


        # archive to tar
        # IMPORTANT: to prevent CVE-2022-21675 from happening, hestiaTAR shall
        #            change directory explictly into the archive root directory
        #            and form the relative pathings.
        $___current_path = Get-Location
        $null = Set-Location $___source

        ## IMPORTANT NOTICE:
        ## Currently, windows' TAR does not support UNIX UGID system and there
        ## isn't a way to determine yet. Hence, we will use a flag switch to
        ## place the control codes but disabling it for now.
        $___supported = $false
        if (
                ($___supported) -and
                ($(hestiaSTRING-Is-Empty $___owner) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                ($(hestiaSTRING-Is-Empty $___group) -ne ${env:hestiaKERNEL_ERROR_OK})
        ) {
                $___process = hestiaOS-Exec "tar" @"
--numeric-owner --group=`"${___group}`" --owner=`"${___owner}`" " -cvf `"${___dest}`" `".`"
"@
        } else {
                $___process = hestiaOS-Exec "tar" "-cvf `"${___dest}`" `".`""
        }

        $null = Set-Location $___current_path
        $null = Remove-Variable -name ___current_path

        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaFS-Remove $___dest
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # handles compression
        switch ($___compression) {
        { $_ -in "xz", "XZ" } {
                $___process = hestiaXZ-Compress $___dest
                $___dest = "${___dest}.xz"
        } { $_ -in "gz", "GZ" } {
                $___process = hestiaGZ-Compress $___dest
                $___dest = "${___dest}.gz"
        } default {
                $___process = ${env:hestiaKERNEL_ERROR_OK}
        }}

        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaFS-Remove $___dest
                return ${env:hestiaKERNEL_ERROR_BAD_PIPE}
        }


        # export to non-standard naming convention's destination
        if ($___dest -ne $___destination) {
                $___process = hestiaFS-Move $___destination $___dest
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaFS-Remove $___dest
                        return ${env:hestiaKERNEL_ERROR_BAD_STREAM_PIPE}
                }
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
. "${LIBS_HESTIA}/hestiaGZ/Compress.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaTAR/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaXZ/Compress.sh.ps1"




hestiaTAR_Pack() {
        #___destination="$1"
        #___source="$2"
        #___compression="$3"
        #___owner="$4"
        #___group="$5"


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

        if [ $(hestiaFS_Is_Exist "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EXISTS
        fi

        if [ $(hestiaFS_Is_Directory "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_FILE
        fi

        if [ $(hestiaFS_Is_Directory "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        if [ $(hestiaFS_Is_Directory_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        if [ ! "${1%%.txz*}" = "$1" ]; then
                ___dest="${1%%.txz*}"
        elif [ ! "${1%%.tgz*}" = "$1" ]; then
                ___dest="${1%%.tgz*}"
        else
                ___dest="${1%%.tar*}"
        fi
        ___dest="${___dest}.tar"

        if [ ! "$(hestiaFS_Get_Directory "$1")" = "$1" ]; then
                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$1")"
        fi


        # archive to tar
        # IMPORTANT: to prevent CVE-2022-21675 from happening, hestiaTAR shall
        #            change directory explictly into the archive root directory
        #            and form the relative pathings.
        ___current_path="$PWD"
        cd "$2"

        if [ $(hestiaSTRING_Is_Empty "$5") -ne $hestiaKERNEL_ERROR_OK ] &&
                [ $(hestiaSTRING_Is_Empty "$5") -ne $hestiaKERNEL_ERROR_OK ]; then
                tar --numeric-owner --group "$5" --owner "$4" -cvf "$___dest" "."
                ___process=$?
        else
                tar -cvf "$___dest" "."
                ___process=$?
        fi

        cd "$___current_path"
        unset ___current_path

        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Remove "$___dest"
                return $hestiaKERNEL_ERROR_OK
        fi


        # handles compression
        case "$3" in
        xz|XZ)
                hestiaXZ_Compress "$___dest"
                ___process=$?
                ___dest="${___dest}.xz"
                ;;
        gz|GZ)
                hestiaGZ_Compress "$___dest"
                ___process=$?
                ___dest="${___dest}.gz"
                ;;
        *)
                ___process=$hestiaKERNEL_ERROR_OK
                ;;
        esac

        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Remove "$___dest"
                return $hestiaKERNEL_ERROR_BAD_PIPE
        fi


        # export to non-standard naming convention's destination
        if [ ! "$___dest" = "$1" ]; then
                hestiaFS_Move "$1" "$___dest"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Remove "$___dest"
                        return $hestiaKERNEL_ERROR_BAD_STREAM_PIPE
                fi
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
