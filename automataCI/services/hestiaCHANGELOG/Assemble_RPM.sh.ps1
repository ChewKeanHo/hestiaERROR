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




function hestiaCHANGELOG-Assemble-RPM {
        param (
                [string]$___filepath,
                [string]$___data_directory,
                [string]$___date,
                [string]$___name,
                [string]$___email,
                [string]$___version,
                [string]$___cadence
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___filepath) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___data_directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___date) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___name) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___email) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___version) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___cadence) -eq ${env:hestiaKERNEL_ERROR_OK}) {
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
        $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___filepath)"


        # emit stanza
        $___process = hestiaFS-Write-File $___filepath "%%changelog`n"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # emit latest changelog
        if ($(hestiaFS-Is-File "${___data_directory}\latest") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $___process = hestiaFS-Append-File $___filepath @"
* ${___date} ${___name} <${___email}> - ${___version}-${___cadence}

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                foreach ($___line in (Get-Content "${___data_directory}\latest")) {
                        $___process = hestiaFS-Append-File $___filepath "- ${___line}`n"
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }
        } else {
                $___process = hestiaFS-Append-File $___filepath "# unavailable`n"
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }


        # emit tailing newline
        $___process = hestiaFS-Append-File $___filepath "`n"
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




hestiaCHANGELOG_Assemble_RPM() {
        #___filepath="$1"
        #___data_directory="$2"
        #___date="$3"
        #___name="$4"
        #___email="$5"
        #___version="$6"
        #___cadence="$7"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$4") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$5") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$7") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EXIST
        fi

        if [ $(hestiaFS_Is_Directory "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY
        fi


        # execute
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$1")"


        # emit stanza
        hestiaFS_Append_File "$1" "%%changelog\n"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        # emit latest changelog
        if [ $(hestiaFS_Is_File "${2}/latest") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Append_File "$1" "\
* ${3} ${4} <${5}> - ${6}-${7}
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                ___old_IFS="$IFS"
                while IFS="" read -r ___line || [ -n "$___line" ]; do
                        ___line="${___line%%#*}"
                        if [ $(hestiaSTRING_Is_Empty "$___line") -eq $hestiaKERNEL_ERROR_OK ]; then
                                continue
                        fi

                        hestiaFS_Append_File "$1" "- ${___line}\n"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                done < "${2}/latest"
                IFS="$___old_IFS"
                unset ___old_IFS
        else
                hestiaFS_Append_File "$1" "# unavailable\n"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi


        # emit tailing newline
        hestiaFS_Append_File "$1" "\n"
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
