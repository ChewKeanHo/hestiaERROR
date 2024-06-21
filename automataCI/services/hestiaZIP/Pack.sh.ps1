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
. "${env:LIBS_HESTIA}\hestiaZIP\Is_Available.sh.ps1"




function hestiaZIP-Pack {
        param (
                [string]$___destination,
                [string]$___source,
                [string]$___compression
        )


        # validate input
        if ($(hestiaZIP-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
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
        if ($(hestiaFS-Get-Directory $___destination) -ne $___destination) {
                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___destination)"
        }


        # archive to zip
        # IMPORTANT: to prevent CVE-2022-21675 from happening, hestiaZIP shall
        #            change directory explictly into the archive root directory
        #            and form the relative pathings.
        $___current_path = Get-Location
        $null = Set-Location $___source

        try {
                switch ($___compression) {
                { $_ -in "none", "None", "NONE" } {
                        $null = Compress-Archive -Update `
                                -CompressionLevel NoCompression `
                                -DestinationPath $___destination `
                                -Path "."
                } { $_ -in "speed", "Speed", "SPEED" } {
                        $null = Compress-Archive -Update `
                                -CompressionLevel Fastest `
                                -DestinationPath $___destination `
                                -Path "."
                } default {
                        $null = Compress-Archive -Update `
                                -CompressionLevel Optimal `
                                -DestinationPath $___destination `
                                -Path "."
                }}

                $___process = hestiaFS-Is-File $___destination
        } catch {
                $___process = ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        $null = Set-Location $___current_path
        $null = Remove-Variable -name ___current_path

        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaFS-Remove $___destination
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
. "${LIBS_HESTIA}/hestiaZIP/Is_Available.sh.ps1"




hestiaZIP_Pack() {
        #___destination="$1"
        #___source="$2"
        #___compression="$3"


        # validate input
        if [ $(hestiaZIP_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
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
        if [ ! "$(hestiaFS_Get_Directory "$1")" = "$1" ]; then
                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$1")"
        fi


        # archive to zip
        # IMPORTANT: to prevent CVE-2022-21675 from creation, hestiaZIP shall
        #            change directory into the archive root directory and form
        #            the relative pathings.
        ___current_path="$PWD"
        cd "$2"

        case "$3" in
        none|None|NONE)
                zip -0 -r "$1" "."
                ___process=$?
                ;;
        speed|Speed|SPEED)
                zip -1 -r "$1" "."
                ___process=$?
                ;;
        *)
                zip -9 -r "$1" "."
                ___process=$?
                ;;
        esac

        cd "$___current_path"
        unset ___current_path

        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Remove "$1"
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
