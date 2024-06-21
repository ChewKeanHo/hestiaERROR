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
. "${env:LIBS_HESTIA}\hestiaFS\Copy.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Create_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Get_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Remove.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Merge-Directories {
        param (
                [string]$___destination,
                [string]$___source,
                [string]$___override_existing,
                [string]$___resolve_symlink
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaFS-Is-Directory $___destination) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY}
        }

        if ($(hestiaFS-Is-Directory $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY}
        }


        # execute
        foreach ($___src in (Get-ChildItem -File -Recurse -Path $___source)) {
                $___dest = $___src -replace [regex]::Escape("${___source}\"), ''
                $___dest = "${___destination}\${___dest}"

                if ($(hestiaFS-Is-File $___dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        if ($(hestiaSTRING-Is-Empty $___override_existing) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                continue
                        }

                        $___process = hestiaFS-Remove $___dest
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }

                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___dest)"
                $___process = hestiaFS-Copy $___dest $___src $___resolve_symlink
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
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
. "${LIBS_HESTIA}/hestiaFS/Copy.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Create_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Remove.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Merge_Directories() {
        #___destination="$1"
        #___source="$2"
        #___override_existing="$3"
        #___resolve_symlink="$4"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi

        if [ $(hestiaFS_Is_Directory "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY
        fi


        # execute
        ___old_IFS="$IFS"
        while IFS= read -r ___src || [ -n "$___src" ]; do
                ___dest="${1}/${___src##*${2}/}"

                if [ $(hestiaFS_Is_File "$___dest") -eq $hestiaKERNEL_ERROR_OK ]; then
                        if [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ]; then
                                continue
                        fi

                        hestiaFS_Remove "$___dest"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi

                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$___dest")"
                hestiaFS_Copy "$___dest" "$___src" "$4"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done <<EOF
$(find -L "$2" -type f 2>/dev/null)
EOF
        IFS="$___old_IFS" && unset ___old_IFS


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
