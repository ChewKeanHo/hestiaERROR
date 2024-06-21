# Copyright 2023 (Holloway) Chew, Kean Ho <hollowaykeanho@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at:
#                 http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.




# initialize
if (-not (Test-Path -Path $env:PROJECT_PATH_ROOT)) {
        Write-Error "[ ERROR ] - Please run from automataIC\ci.sh.ps1 instead!`n"
        return
}

. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNUPKG\Package.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNPM\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaOS\Is_Command_Available.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaRUST\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaTAR\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaZIP\Vanilla.sh.ps1"

. "${env:LIBS_AUTOMATACI}\__package-assemble-default-doc_windows-any.ps1"
. "${env:LIBS_AUTOMATACI}\__package-assemble-default-metadata_windows-any.ps1"




function PACKAGE-ARCHIVE {
        param (
                [string]$__filename,
                [string]$__target,
                [string]$__target_os,
                [string]$__target_arch,
                [string]$__package_time,
                [string]$__directory_output,
                [string]$__arguments
        )




        # validate input
        $null = hestiaCONSOLE-Log-Check-Availability "TAR"
        if ($(hestiaTAR-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Check-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        $null = hestiaCONSOLE-Log-Check-Availability "ZIP"
        if ($(hestiaZIP-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Check-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # prepare workspace and required values
        $__package_sku = ${env:PROJECT_SKU}
        if ($(hestiaFS-Is-Filename-Has $__target ${env:PROJECT_DOCS_ID}) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__package_sku = "${env:PROJECT_SKU}-${env:PROJECT_DOCS_ID}"
        } elseif ($(hestiaFS-Is-Filename-Has $__target "lib") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__package_sku = "lib${env:PROJECT_SKU}"

                if ($(hestiaNPM-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        # npm package
                        $__package_sku = "${env:PROJECT_SKU}-${env:PROJECT_NODE_NPM_ID}"
                } elseif ($(hestiaRUST-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        # rust crate package
                        $__package_sku = "${env:PROJECT_SKU}-${env:PROJECT_RUST_ID}"
                } elseif ($(hestiaFS-Is-Filename-Has $__target ${env:PROJECT_C_ID}) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        # complied c package
                        $__package_sku = "lib${env:PROJECT_SKU}-${env:PROJECT_C_ID}"
                }
        }




        # remake workspace
        $__directory_source = "packagers-archive-${__package_sku}_${__target_os}-${__target_arch}"
        $__directory_source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\${__directory_source}"
        $null = hestiaCONSOLE-Log-Recreate $__directory_source
        $___process = hestiaFS-Recreate-Directory $__directory_source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble project specified files to the workspace
        $__cmd = "PACKAGE-Assemble-ARCHIVE-Content"
        $null = hestiaCONSOLE-Log-Check-Availability $__cmd

        $__file_assembly = "${env:PROJECT_PATH_CI}\package-archive_windows-any.ps1"
        $__file_assembly = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\${__file_assembly}"
        if ($(hestiaFS-Is-File $__file_assembly) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Check-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
        . $__file_assembly

        if ($(hestiaOS-Is-Command-Available $__cmd) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Check-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # execute assembly function
        $null = hestiaCONSOLE-Log-Run $__cmd
        $___process = PACKAGE-Assemble-ARCHIVE-Content `
                $__target `
                $__directory_source `
                $__target_filename `
                $__target_os `
                $__target_arch
        switch ($___process) {
        ${env:hestiaKERNEL_ERROR_CANCELLED} {
                $null = hestiaCONSOLE-Log-Run-Skipped $___process
                return ${env:hestiaKERNEL_ERROR_OK}
        } ${env:hestiaKERNEL_ERROR_OK} {
                # proceed further
        } default {
                $null = hestiaCONSOLE-Log-Run-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }}




        # archive the assembled payload
        $__package = "${__package_sku}_${env:PROJECT_VERSION}_${__target_os}-${__target_arch}"




        # assemble all default metadata files
        $___process = PACKAGE-Assemble-Default-Metadata $__directory_source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble all default documentatons
        $___process = PACKAGE-Assemble-Default-Doc $__directory_source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble icon.png
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\icons\icon-128x128.png"
        $__dest = "${__directory_source}\icon.png"
        $null = hestiaCONSOLE-Log-Assemble $__dest $__source
        $___process = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $__dest)"
        $___process = hestiaFS-Copy-File $__dest $__source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # package npm package when detected
        if ($(hestiaNPM-Is-Target-Valid $_target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaSTRING-Is-Empty ${env:PROJECT_NODE_NPM_ID}) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_OK} # disabled explictly
                }


                # package npm.tgz
                $__dest = "${__package_sku}_${env:PROJECT_VERSION}"
                $__dest = "${__directory_output}\${__dest}_${__target_os}-${__target_arch}.tgz"
                $null = hestiaCONSOLE-Log-Package $__dest
                $___process = hestiaTAR-Pack $__dest $__directory_source
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # can't be packaged as something else - report status
                return ${env:hestiaKERNEL_ERROR_OK}
        }




        # package crate package when detected
        if ($(hestiaRUST-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # package .crate
                # TODO during Rust porting


                # can't be packaged as something else - report status
                return ${env:hestiaKERNEL_ERROR_OK}
        }




        # package coventional archive files
        if ($(hestiaSTRING-Is-Empty ${env:PROJECT_RELEASE_ARCHIVE}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                # package tar.xz
                $__dest = "${__directory_output}\${__package}.tar.xz"
                $null = hestiaCONSOLE-Log-Package $__dest
                $___process = hestiaTAR-Pack $__dest $__directory_source "xz"
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # package zip
                $__dest = "${_directory_output}\${__package}.zip"
                $null = hestiaCONSOLE-Log-Package $__dest
                $___process = hestiaZIP-Pack $__dest $__directory_source
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # package chocolatey nupkg
        if (
                (($_target_os -eq "any") -or ($_target_os -eq "windows")) -and
                ($(hestiaSTRING-Is-Empty ${env:PROJECT_CHOCOLATEY_URL}) -ne ${env:hestiaKERNEL_ERROR_OK})
        ) {
                # create required tools\ directory
                $null = hestiaFS-Create-Directory "${__directory_source}\tools"


                # create required tools\ChocolateyBeforeModify.ps1
                $__source = "tools\ChocolateyBeforeModify.ps1"
                $__dest = "${__directory_source}\${__source}"
                $null = hestiaCONSOLE-Log-Create $__dest
                if ($(hestiaFS-Is-File $__dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $___process = hestiaFS-Write-File $__dest @"
# REQUIRED - BEGIN EXECUTION
Write-Host "Performing pre-configurations..."

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\data\chocolatey\${__source}"
                if ($(hestiaFS-Is-File $__source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        foreach ($__line in (Get-Content -Path $__source)) {
                                if ($(hestiaSTRING-Has $__line "Done by AutomataCI") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                        continue
                                }

                                $___process = hestiaFS-Append-File $__dest "${__line}`n"
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }
                }


                # create required tools\ChocolateyInstall.ps1
                $__source = "tools\ChocolateyInstall.ps1"
                $__dest = "${__directory_source}\${__source}"
                $null = hestiaCONSOLE-Log-Create $__dest
                if ($(hestiaFS-Is-File $__dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $___process = hestiaFS-Write-File $__dest @"
# REQUIRED - PREPARING INSTALLATION
Write-Host "Installing ${__package_sku} (${env:PROJECT_VERSION})..."

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\data\chocolatey\${__source}"
                if ($(hestiaFS-Is-File $__source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        foreach ($__line in (Get-Content -Path $__source)) {
                                if ($(hestiaSTRING-Has $__line "Done by AutomataCI") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                        continue
                                }

                                $___process = hestiaFS-Append-File $__dest "${__line}`n"
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }
                }


                # create required tools\ChocolateyUninstall.ps1
                $__source = "tools\ChocolateyUninstall.ps1"
                $__dest = "${__directory_source}\${__source}"
                $null = hestiaCONSOLE-Log-Create $__dest
                if ($(hestiaFS-Is-File $__dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $___process = hestiaFS-Write-File $__dest @"
# REQUIRED - PREPARING UNINSTALLATION
Write-Host "Uninstalling ${__package_sku} (${env:PROJECT_VERSION})..."

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\data\chocolatey\${__source}"
                if ($(hestiaFS-Is-File $__source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        foreach ($__line in (Get-Content -Path $__source)) {
                                if ($(hestiaSTRING-Has $__line "Done by AutomataCI") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                        continue
                                }

                                $___process = hestiaFS-Append-File $__dest "${__line}`n"
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        $null = hestiaCONSOLE-Log-Create-Failed $___process
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }
                }


                # create chocolatey nuspec files
                # IMPORTANT:    Chocolatey specifically mentions only use
                #               dash (-) as the separator and not others
                #               including the nupkg's dot (.) specification.
                #               Please comply for consistencies and
                #               compatibilities purposes.
                #
                #               The default pattern here considers the
                #               possibility of facilitating cross-compilation
                #               services at the guest side.
                $__id = "${env:PROJECT_SCOPE}-${__package_sku}-${__target_os}-${__target_arch}"
                $__id = "${__id}-${env:PROJECT_CHOCOLATEY_ID}"
                $__title = "${env:PROJECT_NAME} (${__package_sku} ${__target_os}-${__target_arch})"

                $__dest = "${__id}_${env:PROJECT_VERSION}_${__target_os}-${__target_arch}.nupkg"
                $__dest = "${_directory_output}\${__dest}"
                $null = hestiaCONSOLE-Log-Package $__dest
                $___process = hestiaNUPKG-Package `
                        $__dest `
                        $__directory_source `
                        $__id `
                        ${env:PROJECT_VERSION} `
                        ${env:PROJECT_PITCH} `
                        ${env:PROJECT_CONTACT_NAME} `
                        ${env:PROJECT_CONTACT_WEBSITE} `
                        ${env:PROJECT_LICENSE_FILE} `
                        "icon.png" `
                        ${env:PROJECT_README} `
                        ${env:PROJECT_LICENSE_ACCEPTANCE_REQUIRED} `
                        ${env:PROJECT_SOURCE_URL} `
                        $__title
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # clean up chocolatey's artifacts
        $null = hestiaFS-Remove "${__directory_source}\tools\ChocolateyBeforeModify.ps1"
        $null = hestiaFS-Remove "${__directory_source}\tools\ChocolateyInstall.ps1"
        $null = hestiaFS-Remove "${__directory_source}\tools\ChocolateyUninstall.ps1"
        if ($(hestiaFS-Is-Directory-Empty "${__directory_source}\tools") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaFS-Remove "${__directory_source}\tools"
        }

        foreach ($__nuspec in (Get-ChildItem -File -Path $__directory_source -Filter "*.nuspec")) {
                $null = hestiaFS-Remove $__nuspec
        }




        # package DOTNET nupkg
        if ($(hestiaSTRING-Is-Empty ${env:PROJECT_NUPKG_URL}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                # IMPORTANT:    Nupkg specifically mentions the current practice
                #               is to use dot (.) namespacing as ID. Please
                #               comply for consistencies and compatibilities
                #               purposes.
                #
                #               The default pattern here considers the
                #               possibility of facilitating cross-compilation
                #               services at the guest side.
                $__id = "${env:PROJECT_SCOPE}.${__package_sku}.${__target_os}.${__target_arch}"
                $__title = "${env:PROJECT_NAME} (${__package_sku} ${__target_os}-${__target_arch})"

                $__dest = "${__package}.nupkg"
                $__dest = "${_directory_output}\${__dest}"
                $null = hestiaCONSOLE-Log-Package $__dest
                $___process = hestiaNUPKG-Package `
                        $__dest `
                        $__directory_source `
                        $__id `
                        ${env:PROJECT_VERSION} `
                        ${env:PROJECT_PITCH} `
                        ${env:PROJECT_CONTACT_NAME} `
                        ${env:PROJECT_CONTACT_WEBSITE} `
                        ${env:PROJECT_LICENSE_FILE} `
                        "icon.png" `
                        ${env:PROJECT_README} `
                        ${env:PROJECT_LICENSE_ACCEPTANCE_REQUIRED} `
                        ${env:PROJECT_SOURCE_URL} `
                        $__title
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # clean up from DOTNET nupkg
        foreach ($__nuspec in (Get-ChildItem -File -Path $__directory_source -Filter "*.nuspec")) {
                $null = hestiaFS-Remove $__nuspec
        }




        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
