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
. "${env:LIBS_HESTIA}\hestiaGZ\Compress.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaCHANGELOG-Assemble-DEB {
        param (
                [string]$___filepath,
                [string]$___data_directory,
                [string]$___version
        )


        # validate input
        if ($(hestiaGIT-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___data_directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___version) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if (
                ($(hestiaFS-Is-File $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaFS-Is-File "${___filepath}.gz") -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EXIST}
        }

        if ($(hestiaFS-Is-Directory $___data_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY}
        }


        # execute
        $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory "${___filepath}")"


        # write the latest first
        if ($(hestiaFS-Is-File "${___data_directory}\latest") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        $___initiated = ${env:hestiaKERNEL_DATA_MISSING}
        foreach ($___line in (Get-Content "${___data_directory}\latest")) {
                $___process = hestiaFS-Append-File $___filepath "${___line}`n"
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $___initiated = ${env:hestiaKERNEL_ERROR_OK}
        }


        # loop through each git tag and append accordingly
        foreach ($___tag in (Invoke-Expression "git tag --sort -version:refname")) {
                if ($(hestiaFS-Is-File "${___data_directory}\$($___tag -replace ".*v", '')") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
                }

                foreach ($___line in (Get-Content "${___data_directory}\$($___tag -replace ".*v", '')")) {
                        $___process = hestiaFS-Append-File $___filepath "${___line}`n"
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        if ($___initiated -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                $___process = hestiaFS-Append-File $___filepath "`n`n"
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }

                        $___initiated = ${env:hestiaKERNEL_ERROR_OK}
                }
        }


        # gunzip the target
        $___process = hestiaGZ-Compress $___filepath
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
. "${LIBS_HESTIA}/hestiaGZ/Compress.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaCHANGELOG_Assemble_DEB() {
        #___filepath="$1"
        #___data_directory="$2"
        #___version="$3"


        # validate input
        if [ $(hestiaGIT_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaFS_Is_File "${1}.gz") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EXIST
        fi

        if [ $(hestiaFS_Is_Directory "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY
        fi


        # execute
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$1")"


        # write the latest first
        if [ $(hestiaFS_Is_File "${2}/latest") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        ___initiated=$hestiaKERNEL_DATA_MISSING
        ___old_IFS="$IFS"
        while IFS="" read -r ___line || [ -n "$___line" ]; do
                hestiaFS_Append_File "$1" "${___line}\n"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                ___initiated=$hestiaKERNEL_ERROR_OK
        done < "${2}/latest"
        IFS="$___old_IFS"
        unset ___old_IFS


        # loop through each git tag and append accordingly
        for ___tag in $(git tag --sort -version:refname); do
                if [ $(hestiaFS_Is_File "${2}/${___tag##*v}") -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_DATA_INVALID
                fi

                if [ $___initiated -eq $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Append_File "$1" "\n\n"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi

                ___old_IFS="$IFS"
                while IFS="" read -r ___line || [ -n "$___line" ]; do
                        hestiaFS_Append_File "$1" "${___line}\n"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ___initiated=$hestiaKERNEL_ERROR_OK
                done < "${2}/${___tag##*v}"
                IFS="$___old_IFS"
                unset ___old_IFS
        done


        # gunzip the target
        hestiaGZ_Compress "$1"
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
