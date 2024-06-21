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
. "${env:LIBS_HESTIA}\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaZIP\Pack.sh.ps1"




function hestiaNUPKG-Package {
        param (
                [string]$___destination,
                [string]$___directory,
                [string]$___id,
                [string]$___version,
                [string]$___description,
                [string]$___author,
                [string]$___project_url,
                [string]$___license_file,
                [string]$___icon,
                [string]$___readme,
                [string]$___license_acceptance,
                [string]$___source_url,
                [string]$___title
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty "${___destination}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISSING}
        }

        if ($(hestiaFS-Is-Exist "${___destination}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_MISSING}
        }

        if ($(hestiaFS-Is-Directory "${___destination}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_IS_NOT_FILE}
        }

        if ($(hestiaSTRING-Is-Empty "${___directory}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_IS_EMPTY}
        }

        if ($(hestiaFS-Is-Directory "${___directory}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_DESCRIPTOR}
        }

        if ($(hestiaSTRING-Is-Empty "${___id}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___version}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___description}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___author}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___project_url}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___license_file}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-File "${___directory}\${___license_file}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaSTRING-Is-Empty "${___icon}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-File "${___directory}\${___icon}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaSTRING-Is-Empty "${___readme}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-File "${___directory}\${___readme}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($___license_acceptance -ne "yes") {
                $___license_acceptance = "no"
        }

        if ($(hestiaSTRING-Is-Empty "${___source_url}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty "${___title}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }


        # execute
        $___nuspec = ""
        foreach ($___file in (
                Get-ChildItem -File -Path "${___directory}" `
                | Where-Object { $_.Name -like "*.nuspec" }
        )) { $___file = $___file.FullName
                if ($(hestiaFS-Get-File "${___file}") -eq ".nuspec") {
                        return ${env:hestiaKERNEL_ERROR_BAD_DESCRIPTOR}
                }

                if ($(hestiaSTRING-Is-Empty "${___nuspec}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_TOO_MANY_REFERENCES}
                }

                $___nuspec = $___file -replace [regex]::Escape("${___directory}\"), ''
        }

        if ($(hestiaSTRING-Is-Empty "${___nuspec}") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # missing nuspec - create one
                $___nuspec = "${___directory}\${___id}.nuspec"
                $___process = hestiaFS-Write-File "${___nuspec}" @"
<?xml version='1.0' encoding='utf-8'?>
<package xmlns='http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd'>
	<metadata>
		<id>${___id}</id>
		<version>${___version}</version>
		<description>${___description}</description>
		<authors>${___author}</authors>
		<owners>${___author}</owners>
		<projectUrl>${___project_url}</projectUrl>
		<license type='file'>${___license_file}</license>
		<icon>${___icon}</icon>
		<readme>${___readme}</readme>
		<requireLicenseAcceptance>${___license_acceptance}</requireLicenseAcceptance>
		<repository url='${___source_url}' />
		<title>${___title}</title>
	</metadata>
	<files>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # loop through each detected files and register into the nuspec
                foreach ($___file in
                        (Get-ChildItem -File -Recurse -Path "${___directory}")
                ) { $___file = $___file.FullName
                        if (
                                ("$($___file -replace ".*\.nuspec$", '')" -ne "${___file}") -or
                                ("$($___file -replace ".*Chocolatey.*", '')" -ne "${___file}") -or
                                ("$($___file -replace ".*chocolatey.*", '')" -ne "${___file}")
                        ) {
                                continue
                        }

                        # valid payload - register
                        $___file = $___file -replace [regex]::Escape("${___directory}\"), ''
                        $___process = hestiaFS-Append-File "${___nuspec}" @"
		<file src="${___file}" target="${___file}" />

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # close the nuspec
                $___process = hestiaFS-Append-File "${___nuspec}" @"
	</files>
</package>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }


        # package the file
        $___process = hestiaZIP-Pack "${___destination}" "${___directory}"
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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaZIP/Pack.sh.ps1"




hestiaNUPKG_Package() {
        ___destination="$1"
        ___directory="$2"
        ___id="$3"
        ___version="$4"
        ___description="$5"
        ___author="$6"
        ___project_url="$7"
        ___license_file="$8"
        ___icon="$9"
        ___readme="${10}"
        ___license_acceptance="${11}"
        ___source_url="${12}"
        ___title="${13}"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$___destination") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi

        if [ $(hestiaFS_Is_Exist "$___destination") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_MISSING
        fi

        if [ $(hestiaFS_Is_Directory "$___destination") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_FILE
        fi

        if [ $(hestiaSTRING_Is_Empty "$___directory") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_IS_EMPTY
        fi

        if [ $(hestiaFS_Is_Directory "$___directory") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_DESCRIPTOR
        fi

        if [ $(hestiaSTRING_Is_Empty "$___id") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___version") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___description") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___author") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___project_url") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___license_file") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "${___directory}/${___license_file}") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaSTRING_Is_Empty "$___icon") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "${___directory}/${___icon}") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaSTRING_Is_Empty "$___readme") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "${___directory}/${___readme}") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ ! "$___license_acceptance" = "yes" ]; then
                ___license_acceptance="no"
        fi

        if [ $(hestiaSTRING_Is_Empty "$___source_url") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$___title") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        ___nuspec=""
        ___old_IFS="$IFS"
        while IFS= read -r ___file || [ -n "$___file" ]; do
                if [ "$(hestiaFS_Get_File "$___file")" = ".nuspec" ]; then
                        return $hestiaKERNEL_ERROR_BAD_DESCRIPTOR
                fi

                if [ $(hestiaSTRING_Is_Empty "$___nuspec") -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_TOO_MANY_REFERENCES
                fi

                ___nuspec="${___file##*${___directory}/}"
        done <<EOF
$(find "$___directory" -type f -name '*.nuspec' 2> /dev/null)
EOF
        IFS="$___old_IFS" && unset ___old_IFS

        if [ $(hestiaSTRING_Is_Empty "$___nuspec") -eq $hestiaKERNEL_ERROR_OK ]; then
                # missing nuspec - create one
                ___nuspec="${___directory}/${___id}.nuspec"
                hestiaFS_Write_File "$___nuspec" "\
<?xml version='1.0' encoding='utf-8'?>
<package xmlns='http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd'>
	<metadata>
		<id>${___id}</id>
		<version>${___version}</version>
		<description>${___description}</description>
		<authors>${___author}</authors>
		<owners>${___author}</owners>
		<projectUrl>${___project_url}</projectUrl>
		<license type='file'>${___license_file}</license>
		<icon>${___icon}</icon>
		<readme>${___readme}</readme>
		<requireLicenseAcceptance>${___license_acceptance}</requireLicenseAcceptance>
		<repository url=\"${___source_url}\" />
		<title>${___title}</title>
	</metadata>
	<files>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # loop through each detected files and register into the nuspec
                ___old_IFS="$IFS"
                while IFS= read -r ___file || [ -n "$___file" ]; do
                        if [ ! "${___file%%.nuspec*}" = "$___file" ] ||
                                [ ! "${___file%%Chocolatey*}" = "$___file" ] ||
                                [ ! "${___file%%chocolatey*}" = "$___file" ]; then
                                continue
                        fi

                        # valid payload - register
                        ___file="${___file#*${___directory}/}"
                        hestiaFS_Append_File "$___nuspec" "\
		<file src=\"${___file}\" target=\"${___file}\" />
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                done <<EOF
$(find "$___directory" -type f 2> /dev/null)
EOF
                IFS="$___old_IFS" && unset ___old_IFS


                # close the nuspec
                hestiaFS_Append_File "$___nuspec" "\
	</files>
</package>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi


        # package the file
        hestiaZIP_Pack "$___destination" "$___directory"
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
