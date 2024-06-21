# Copyright 2023 (Holloway) Chew, Kean Ho <hollowaykeanho@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at:
#               http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.




# initialize
if (-not (Test-Path -Path $env:PROJECT_PATH_ROOT)) {
        Write-Error "[ ERROR ] - Please run me from automataCI\ci.sh.ps1 instead!`n"
        return 1
}

. "${env:LIBS_AUTOMATACI}\services\hestiaCHANGELOG\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaCITATION\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaGIT\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaHOMEBREW\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaMSI\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNPM\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaOS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaPDF\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaRUST\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaSTRING\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaWASM\Is_Target_Valid_JS.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaTIME\Vanilla.sh.ps1"




# snap a release time
$PACKAGE_TIME = hestiaTIME-Now
$DIRECTORY_BUILD = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_BUILD}"
$DIRECTORY_DOTNET = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TOOLS}\${env:PROJECT_PATH_DOTNET_ENGINE}"




# clean up the entire output directory for fresh packaging
$DIRECTORY_OUTPUT = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_PKG}"
$null = hestiaCONSOLE-Log-Recreate $DIRECTORY_OUTPUT
$___process = hestiaFS-Recreate-Directory $DIRECTORY_OUTPUT
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# clean up homebrew consolidation directory
if ($(hestiaSTRING-Is-Empty ${env:PROJECT_HOMEBREW_URL}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $DIRECTORY_HOMEBREW = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-homebrew-${env:PROJECT_SKU}"
        $null = hestiaCONSOLE-Log-Recreate $DIRECTORY_HOMEBREW
        $___process = hestiaFS-Recreate-Directory $DIRECTORY_HOMEBREW
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
}




# clean up msi (windows) consolidation directory
if ($(hestiaSTRING-Is-Empty ${env:PROJECT_MSI_CODEPAGE}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $DIRECTORY_MSI = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-msi-${env:PROJECT_SKU}"
        $null = hestiaCONSOLE-Log-Recreate $DIRECTORY_MSI
        $___process = hestiaFS-Recreate-Directory $DIRECTORY_MSI
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }

        if ($(hestiaSTRING-Is-Empty $env:PROJECT_MSI_REGISTRY_KEY) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                ${env:PROJECT_MSI_REGISTRY_KEY} = @"
Software\${env:PROJECT_SCOPE}\InstalledProducts\${env:PROJECT_SKU_TITLECASE}
"@
        }
}




# clean up flatpak repository directory
if ($(hestiaSTRING-Is-Empty $env:PROJECT_FLATPAK_URL) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $DIRECTORY_FLATPAK = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-flatpak-${env:PROJECT_SKU}"
        $null = hestiaCONSOLE-Log-Recreate $DIRECTORY_FLATPAK
        $null = hestiaFS-Remove $DIRECTORY_FLATPAK

        if (
                ($(hestiaSTRING-Is-Empty ${env:PROJECT_FLATPAK_REPO}) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                ($(hestiaSTRING-Is-Empty ${env:PROJECT_RELEASE_REPO}) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                if ($(hestiaOS-Is-Simulation-Mode) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Recreate-Simulate $DIRECTORY_FLATPAK
                } else {
                        # version controlled repository supplied; AND
                        # single unified repository is not enabled
                        $___process = hestiaGIT-Clone `
                                ${env:PROJECT_FLATPAK_REPO} `
                                $DIRECTORY_FLATPAK
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        $___process = hestiaGIT-Change-Branch `
                                $DIRECTORY_FLATPAK `
                                ${env:PROJECT_FLATPAK_REPO_BRANCH}
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }

                if ($(hestiaSTRING-Is-Empty ${env:PROJECT_FLATPAK_PATH}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $DIRECTORY_FLATPAK = "${DIRECTORY_FLATPAK}\${env:PROJECT_FLATPAK_PATH}"
                }
        }

        $___process = hestiaFS-Create-Directory ${DIRECTORY_FLATPAK}
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Recreate-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
}




# clean up changelog directory
$DIRECTORY_CHANGELOG = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-changelog"
$null = hestiaCONSOLE-Log-Recreate ${DIRECTORY_CHANGELOG}
$___process = hestiaFS-Recreate-Directory ${DIRECTORY_CHANGELOG}
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# generate markdown changelog
$FILE_CHANGELOG_MD = "${env:PROJECT_SKU}-CHANGELOG_${env:PROJECT_VERSION}.md"
$FILE_CHANGELOG_MD = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_PKG}\${FILE_CHANGELOG_MD}"
$null = hestiaCONSOLE-Log-Recreate $FILE_CHANGELOG_MD
$___process = hestiaCHANGELOG-Assemble-MARKDOWN `
        $FILE_CHANGELOG_MD `
        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\changelog\data" `
        ${env:PROJECT_CHANGELOG_TITLE} `
        ${env:PROJECT_VERSION}
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# generate deb changelog
$FILE_CHANGELOG_DEB = "${DIRECTORY_CHANGELOG}\deb"
$null = hestiaCONSOLE-Log-Recreate $FILE_CHANGELOG_DEB
$___process = hestiaCHANGELOG-Assemble-DEB `
        $FILE_CHANGELOG_DEB `
        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\changelog\deb" `
        ${env:PROJECT_VERSION}
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}

$FILE_CHANGELOG_DEB = "${FILE_CHANGELOG_DEB}.gz"
if ($(hestiaFS-Is-File $FILE_CHANGELOG_DEB) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# generate rpm changelog
$FILE_CHANGELOG_RPM = "${DIRECTORY_CHANGELOG}\rpm"
$null = hestiaCONSOLE-Log-Recreate $FILE_CHANGELOG_RPM
$___process = hestiaCHANGELOG-Assemble-RPM `
        $FILE_CHANGELOG_RPM `
        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\changelog\data" `
        "$(hestiaTIME-Format-Date-RPM $PACKAGE_TIME)" `
        ${env:PROJECT_CONTACT_NAME} `
        ${env:PROJECT_CONTACT_EMAIL} `
        ${env:PROJECT_VERSION} `
        ${env:PROJECT_CADENCE}
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# generate CITATION.cff
$FILE_CITATION_CFF = "${env:PROJECT_SKU}-CITATION_${env:PROJECT_VERSION}.cff"
$FILE_CITATION_CFF = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_PKG}\${FILE_CITATION_CFF}"
$null = hestiaCONSOLE-Log-Recreate $FILE_CITATION_CFF
$___process = hestiaCITATION-Assemble `
        $FILE_CITATION_CFF `
        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\docs\ABSTRACTS.txt" `
        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\docs\CITATIONS.yml" `
        ${env:PROJECT_CITATION} `
        ${env:PROJECT_CITATION_TYPE} `
        "$(hestiaTIME-Format-Date-ISO8601 "${PACKAGE_TIME}")" `
        ${env:PROJECT_NAME} `
        ${env:PROJECT_VERSION} `
        ${env:PROJECT_LICENSE} `
        ${env:PROJECT_SOURCE_URL} `
        ${env:PROJECT_SOURCE_URL} `
        ${env:PROJECT_STATIC_URL} `
        ${env:PROJECT_CONTACT_NAME} `
        ${env:PROJECT_CONTACT_WEBSITE} `
        ${env:PROJECT_CONTACT_EMAIL}
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# clean up log directory
$DIRECTORY_LOG = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_LOG}\packagers"
$null = hestiaCONSOLE-Log-Recreate $DIRECTORY_LOG
$___process = hestiaFS-Recreate-Directory $DIRECTORY_LOG
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# clean up parallel control directory
$DIRECTORY_PARALLEL = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-parallel"
$null = hestiaCONSOLE-Log-Recreate $DIRECTORY_PARALLEL
$___process = hestiaFS-Recreate-Directory $DIRECTORY_PARALLEL
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# clean up serial control directory
$DIRECTORY_SERIAL = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TEMP}\packagers-serial"
$null = hestiaCONSOLE-Log-Recreate $DIRECTORY_SERIAL
$___process = hestiaFS-Recreate-Directory $DIRECTORY_SERIAL
if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Recreate-Failed $___process
        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
}




# setup subroutine function for parallel executions
function SUBROUTINE-Package {
        param(
                [string]$__line
        )


        # parse input
        $__arguments = $__line.Split("|")
        $__filename = $__arguments[0]
        $__target = $__arguments[1]
        $__target_os = $__arguments[2]
        $__target_arch = $__arguments[3]
        $__package_time = $__arguments[4]
        $__function = $__arguments[-1]
        $__directory_log = $__arguments[-2]
        $__directory_output = $__arguments[-3]

        if ($__directory_output -eq $__arguments[-4]) {
                $__arguments = ""
        } else {
                $__arguments = $__arguments[5..($__arguments.Length - 4)] -join "|"
        }


        # import required libraries
        $null = . "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Vanilla.sh.ps1"


        # execute
        switch ("${__function}") {
        "PACKAGE-APP" {
                $__log = "${__directory_log}\app-${__filename}_${__target_os}-${__target_arch}.txt"
        } "PACKAGE-ARCHIVE" {
                $__log = "${__directory_log}\archive-${__filename}_${__target_os}-${__target_arch}.txt"
                $null = . "${env:LIBS_AUTOMATACI}\_package-archive_windows-any.ps1"
                $($___process = PACKAGE-ARCHIVE `
                        $__filename `
                        $__target `
                        $__target_os `
                        $__target_arch `
                        $__package_time `
                        $__directory_output `
                        $__arguments) *>> $__log
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } "PACKAGE-SINGLE" {
                $__log = "${__directory_log}\single-${__filename}_${__target_os}-${__target_arch}.txt"
                $null = . "${env:LIBS_AUTOMATACI}\_package-single_windows-any.ps1"
                $($___process = Package-SINGLE `
                        $__filename `
                        $__target `
                        $__target_os `
                        $__target_arch `
                        $__package_time `
                        $__directory_output `
                        $__arguments) *>> $__log
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } "PACKAGE-UNIX" {
                $__log = "${__directory_log}\unix-${__filename}_${__target_os}-${__target_arch}.txt"
        } "PACKAGE-WINDOWS" {
                $__log = "${__directory_log}\windows-${__filename}_${__target_os}-${__target_arch}.txt"
                $null = . "${env:LIBS_AUTOMATACI}\_package-windows_windows-any.ps1"
                $($___process = PACKAGE-WINDOWS `
                        $__filename `
                        $__target `
                        $__target_os `
                        $__target_arch `
                        $__package_time `
                        $__directory_output `
                        $__arguments) *>> $__log
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } "PACKAGE-CONSOLIDATE" {
                $__log = "${__directory_log}\consolidate-${__filename}_${__target_os}-${__target_arch}.txt"
                $null = . "${env:LIBS_AUTOMATACI}\_package-consolidate_windows-any.ps1"
                $($___process = PACKAGE-CONSOLIDATE `
                        $__filename `
                        $__target `
                        $__target_os `
                        $__target_arch `
                        $__package_time `
                        $__directory_output `
                        $__arguments) *>> $__log
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } default {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }}


        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}




# register built artifacts for parallel executions
if ($(hestiaFS-Is-Directory $DIRECTORY_BUILD) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        # no artifacts at all - report status
        $null = hestiaCONSOLE-Log-Success
        return ${env:hestiaKERNEL_ERROR_OK}
}

foreach ($__artifact in (Get-ChildItem -Path $DIRECTORY_BUILD)) {
        if ($(hestiaFS-Is-File $__artifact) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                continue
        }


        # parse build candidate
        $TARGET_FILENAME = hestiaFS-Get-File $__artifact
        $TARGET_FILENAME = $TARGET_FILENAME -replace "\..*$", ''
        $TARGET_OS = $TARGET_FILENAME -replace ".*_", ''
        $TARGET_FILENAME = $TARGET_FILENAME -replace "_.*", ''
        $TARGET_ARCH = $TARGET_OS -replace ".*-", ''
        $TARGET_ARCH = $TARGET_ARCH -replace "\..*$", ''
        $TARGET_OS = $TARGET_OS -replace "-.*", ''
        $TARGET_OS = $TARGET_OS -replace "\..*$", ''
        $TAG_COMMON = "${TARGET_FILENAME}|${__artifact}|${TARGET_OS}|${TARGET_ARCH}|${PACKAGE_TIME}"

        if (
                ($(hestiaSTRING-Is-Empty $TARGET_OS) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $TARGET_ARCH) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $TARGET_FILENAME) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                continue
        }


        # register for single object type package
        if (
                ($(hestiaPDF-Is-Target-Valid $__artifact) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                # register for single object type package
                $___process = hestiaFS-Append-File "${DIRECTORY_PARALLEL}/control.txt" @"
${TAG_COMMON}|${DIRECTORY_OUTPUT}|${DIRECTORY_LOG}|PACKAGE-SINGLE

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }

                continue
        }


        # register for classical .tar.xz, .zip, & .nupkg types
        $___process = hestiaFS-Append-File "${DIRECTORY_PARALLEL}/control.txt" @"
${TAG_COMMON}|${DIRECTORY_OUTPUT}|${DIRECTORY_LOG}|PACKAGE-ARCHIVE

"@
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # bail tech-specific artifacts since the following no longer needs them
        if (
                ($(hestiaWASM-Is-Target-Valid-JS $__artifact) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaNPM-Is-Target-Valid $__artifact) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaRUST-Is-Target-Valid $__artifact) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                continue
        }


        # register for homebrew type
        if (
                ($(hestiaSTRING-Is-Empty ${env:PROJECT_HOMEBREW_URL}) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                ($TARGET_OS -ne "windows")
        ) {
                $___process = hestiaFS-Append-File "${DIRECTORY_PARALLEL}/control.txt" @"
${TAG_COMMON}|${DIRECTORY_HOMEBREW}|${DIRECTORY_LOG}|PACKAGE-CONSOLIDATE

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }


        # register for windows type
        if (
                ($(hestiaSTRING-Is-Empty ${env:PROJECT_MSI_CODEPAGE}) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                (
                        ($TARGET_OS -eq "windows") -or
                        ($TARGET_OS -eq "any")
                )
        ) {
                $___process = hestiaFS-Append-File "${DIRECTORY_PARALLEL}/control.txt" @"
${TAG_COMMON}|${DIRECTORY_MSI}|${DIRECTORY_LOG}|PACKAGE-WINDOWS

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }


        # register app-only sandboxed|containerized packages
}




# execute in parallel
$null = hestiaCONSOLE-Log-Run $DIRECTORY_PARALLEL
if ($(hestiaFS-Is-File "${DIRECTORY_PARALLEL}\control.txt") -eq ${env:hestiaKERNEL_ERROR_OK}) {
        $___process = hestiaKERNEL-Run-Parallel-Sentinel `
                ${function:SUBROUTINE-Package}.ToString() `
                $DIRECTORY_PARALLEL
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Run-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
}




# execute homebrew package
if ($(hestiaSTRING-Is-Empty ${env:PROJECT_HOMEBREW_URL}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $__dest = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_PKG}\${env:PROJECT_SKU}.rb"
        $null = hestiaCONSOLE-Log-Package $__dest
        $___process = hestiaHOMEBREW-Package `
                $__dest `
                "${env:PROJECT_SKU}-${env:PROJECT_HOMEBREW_ID}_${env:PROJECT_VERSION}_any-any.tar.xz" `
                $DIRECTORY_HOMEBREW `
                ${env:PROJECT_SKU} `
                ${env:PROJECT_PITCH} `
                ${env:PROJECT_CONTACT_WEBSITE} `
                ${env:PROJECT_LICENSE} `
                ${env:PROJECT_HOMEBREW_URL}
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Package-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
}




# execute msi package
if ($(hestiaSTRING-Is-Empty ${env:PROJECT_MSI_CODEPAGE}) -ne ${env:hestiaKERNEL_ERROR_OK}) {
        $null = hestiaCONSOLE-Log-Package "MSI"
        if ($(hestiaFS-Is-Directory "${DIRECTORY_MSI}\any") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # 'any' arch exists - merge into existing ones
                foreach ($_arch in (Get-ChildItem -Path $DIRECTORY_MSI)) {
                        if ($(hestiaFS-Is-Directory $_arch) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                continue
                        }

                        if ($(hestiaFS-Get-File $_arch) -eq "any") {
                                continue
                        }

                        $null = hestiaCONSOLE-Log-Merge $_arch "${DIRECTORY_MSI}\any"
                        $___process = hestiaFS-Merge-Directories $_arch "${DIRECTORY_MSI}\any"
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $null = hestiaCONSOLE-Log-Merge-Failed $___process
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # remove 'any' arch to prevent dirty compilations
                $___process = hestiaFS-Remove "${DIRECTORY_MSI}\any"
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Merge-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }


        # begin package creation
        foreach ($_arch in (Get-ChildItem -Path $DIRECTORY_MSI)) {
                if ($(hestiaFS-Is-Directory $_arch) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        continue
                }


                $null = hestiaCONSOLE-Log-Package $_arch
                $___process = hestiaMSI-Package `
                        "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_PKG}" `
                        $_arch `
                        ${env:PROJECT_SKU} `
                        ${env:PROJECT_VERSION} `
                        ${env:PRODUCT_APP_UUID} `
                        ${env:PROJECT_SCOPE} `
                        ${env:PROJECT_NAME} `
                        ${env:PROJECT_CONTACT_NAME} `
                        ${env:PROJECT_CONTACT_WEBSITE} `
                        ${env:PROJECT_MSI_INSTALLER_VERSION_WINDOWS} `
                        ${env:PROJECT_MSI_INSTALLER_SCOPE} `
                        ${env:PROJECT_MSI_REGISTRY_KEY} `
                        ${env:PROJECT_MSI_BIN_COMPONENT_GUID} `
                        ${env:PROJECT_MSI_ETC_COMPONENT_GUID} `
                        ${env:PROJECT_MSI_LIB_COMPONENT_GUID} `
                        ${env:PROJECT_MSI_DOC_COMPONENT_GUID} `
                        ${env:PROJECT_MSI_REGISTRIES_GUID} `
                        ${env:PROJECT_MSI_CODEPAGE} `
                        $DIRECTORY_DOTNET
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Package-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }
}




# execute in serial
$null = hestiaCONSOLE-Log-Run $DIRECTORY_SERIAL
if ($(hestiaFS-Is-File "${DIRECTORY_SERIAL}\control.txt") -eq ${env:hestiaKERNEL_ERROR_OK}) {
        $___process = hestiaKERNEL-Run-Parallel-Sentinel `
                ${function:SUBROUTINE-Package}.ToString() `
                $DIRECTORY_SERIAL `
                "1"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Run-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }
}




# report status
$null = hestiaCONSOLE-Log-Success
return ${env:hestiaKERNEL_ERROR_OK}
