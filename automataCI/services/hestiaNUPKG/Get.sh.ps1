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
. "${env:LIBS_HESTIA}\hestiaHTTP\Download.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaZIP\Unpack.sh.ps1"




function hestiaNUPKG-Get {
        param (
                [string]$___dotnet_directory,
                [string]$___base_url,
                [string]$___product,
                [string]$___version,
                [string]$___purge_cache,
                [string]$___destination,
                [string]$___extractions,
                [string]$___shasum_type,
                [string]$___shasum_value
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___dotnet_directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___base_url) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___product) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        $___version = hestiaSTRING-To-Lowercase $___version
        if ($(hestiaSTRING-Is-Empty $___version) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $___version = "latest"
        }

        if ($(hestiaFS-Is-Exist $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaFS-Create-Directory $___dotnet_directory
        }

        if ($(hestiaFS-Is-Directory $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY}
        }


        # execute
        $___pkg = "${___dotnet_directory}\${___product}_${___version}"

        ## clean up existing package
        $___should_cleanup = $false

        if ($___version -eq "latest") {
                $___should_cleanup = $true
        }

        if ($(hestiaSTRING-Is-Empty $___purge_cache) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $___should_cleanup = $true
        }

        if ($(hestiaSTRING-Is-Empty $___extractions) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                foreach ($___target in ($___extractions -split "`n")) {
                        $___src = "${___pkg}\${___target}"

                        if ($(hestiaSTRING-Is-Empty $___target) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $___should_cleanup = $false
                        }
                }
        }

        if ($___should_cleanup) {
                $null = hestiaFS-Remove $___pkg
        }


        ## begin sourcing nupkg when required
        if ($(hestiaFS-Is-Directory $___pkg) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $___provider_url = "${___base_url}\${___product}"
                if ($___version -ne "latest") {
                        $___provider_url = "${___provider_url}/${___version}"
                }

                $null = hestiaFS-Create-Directory $___pkg

                $___process = hestiaHTTP-Download `
                        "GET" `
                        $___provider_url `
                        "${___pkg}\nupkg.zip" `
                        "" `
                        $___shasum_type `
                        $___shasum_value `
                        ""
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaFS-Remove $___pkg
                        return ${env:hestiaKERNEL_ERROR_DATA_REMOTE_ERROR}
                }

                if ($(hestiaFS-Is-File "${___pkg}\nupkg.zip") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaFS-Remove $___pkg
                        return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
                }

                $___process = hestiaZIP-Unpack $___pkg "${___pkg}\nupkg.zip"
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaFS-Remove $___pkg
                        return ${env:hestiaKERNEL_ERROR_DATA_BAD}
                }
        }

        ## begin extraction
        if (
                ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) -and
                ($(hestiaSTRING-Is-Empty $___extractions) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_DATA_OK} # not requested
        }

        if ($(hestiaSTRING-Is-Empty $___destination) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        if ($(hestiaSTRING-Is-Empty $___extractions) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISSING}
        }

        if (
                ($(hestiaFS-Is-Exist $___extractions) -eq ${env:hestiaKERNEL_ERROR_OK}) -and
                ($(hestiaFS-Is-Directory $___extractions) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY}
        }

        $null = hestiaFS-Create-Directory $___destination
        foreach ($___target in ($___extractions -split "`n")) {
                if ($(hestiaSTRING-Is-Empty $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        continue
                }

                $___src = "${___pkg}\${___target}"
                $___dest = "${___destination}\$(hestiaFS-Get-File $___target)"

                if ($(hestiaFS-Is-File $___src) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
                }

                if ($(hestiaFS-Is-File $___dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_ENTITY_EXISTS}
                }

                $___process = hestiaFS-Copy-File $___dest $___src
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_DATA_FAULTY}
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
. "${LIBS_HESTIA}/hestiaHTTP/Download.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaZIP/Unpack.sh.ps1"




hestiaNUPKG_Get() {
        #___dotnet_directory="$1"
        #___base_url="$2"
        #___product="$3"
        #___version="$4"
        #___purge_cache="$5"
        #___destination="$6"
        #___extractions="$7"
        #___shasum_type="$8"
        #___shasum_value="$9"


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

        ___version="$(hestiaSTRING_To_Lowercase "$4")"
        if [ $(hestiaSTRING_Is_Empty "$___version") -eq $hestiaKERNEL_ERROR_OK ]; then
                ___version="latest"
        fi

        if [ $(hestiaFS_Is_Exist "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Create_Directory "$1"
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi


        # execute
        ___pkg="${1}/${3}_${4}"

        ## clean up existing package
        ___should_cleanup=1

        if [ "$___version" = "latest" ]; then
                ___should_cleanup=0
        fi

        if [ $(hestiaSTRING_Is_Empty "$5") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___should_cleanup=0
        fi

        if [ $(hestiaSTRING_Is_Empty "$7") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___old_IFS="$IFS"
                while IFS= read -r ___target || [ -n "$___target" ]; do
                        ___src="${___pkg}/${___target}"

                        if [ $(hestiaFS_Is_File "$___src") -ne $hestiaKERNEL_ERROR_OK ]; then
                                ___should_cleanup=0
                                break
                        fi
        done << EOF
$7
EOF
                IFS="$___old_IFS" && unset ___old_IFS
        fi

        if [ $___should_cleanup -eq 0 ]; then
                hestiaFS_Remove "$___pkg"
        fi


        ## begin sourcing nupkg when required
        if [ $(hestiaFS_Is_Directory "$___pkg") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___provider_url="${2}/${3}"
                if [ ! "$___version" = "latest" ]; then
                        ___provider_url="${___provider_url}/${___version}"
                fi

                hestiaFS_Create_Directory "$___pkg"

                hestiaHTTP_Download \
                        "GET" \
                        "$___provider_url" \
                        "${___pkg}/nupkg.zip" \
                        "" \
                        "$8" \
                        "$9" \
                        ""
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Remove "$___pkg"
                        return $hestiaKERNEL_ERROR_DATA_REMOTE_ERROR
                fi

                # making sure remote is not doing something funky
                if [ $(hestiaFS_Is_File "${___pkg}/nupkg.zip") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Remove "$___pkg"
                        return $hestiaKERNEL_ERROR_DATA_MISSING
                fi

                hestiaZIP_Unpack "$___pkg" "${___pkg}/nupkg.zip"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Remove "$___pkg"
                        return $hestiaKERNEL_ERROR_DATA_BAD
                fi
        fi


        ## begin extraction
        if [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ] &&
                [ $(hestiaSTRING_Is_Empty "$7") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK # not requested
        fi

        if [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        if [ $(hestiaSTRING_Is_Empty "$7") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi

        if [ $(hestiaFS_Is_Exist "$6") -eq $hestiaKERNEL_ERROR_OK ] &&
                [ $(hestiaFS_Is_Directory "$6") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi

        hestiaFS_Create_Directory "$6"
        ___old_IFS="$IFS"
        while IFS= read -r ___target || [ -n "$___target" ]; do
                if [ $(hestiaSTRING_Is_Empty "$___target") -eq $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                ___src="${___pkg}/${___target}"
                ___dest="${6}/$(hestiaFS_Get_File "$___target")"

                if [ $(hestiaFS_Is_File "$___src") -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_DATA_MISSING
                fi

                if [ $(hestiaFS_Is_File "$___dest") -eq $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_ENTITY_EXISTS
                fi

                hestiaFS_Copy_File "$___dest" "$___src"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_DATA_FAULTY
                fi
        done << EOF
$7
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
