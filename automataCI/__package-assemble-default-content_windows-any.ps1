# Copyright 2024 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
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
        Write-Error "[ ERROR ] - Please run from automataCI\ci.sh.ps1 instead!`n"
        return
}

. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNPM\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaPDF\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaRUST\Is_Target_Valid.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaTAR\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaWASM\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaZIP\Vanilla.sh.ps1"




function PACKAGE-Assemble-Default-Content {
        param (
                [string]$__target,
                [string]$__directory,
                [string]$__target_name,
                [string]$__target_os,
                [string]$__target_arch,
                [string]$__package_type
        )




        # validate input
        if ($(hestiaWASM-Is-Target-Valid-JS $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_CANCELLED} # not applicable
        }




        # assemble single file type
        if ($(hestiaPDF-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # determine unpack destination
                $__dest = "${__directory}\${env:PROJECT_SKU}_any-any.pdf"
                if ($(hestiaFS-Is-Filename-Has $__target ${env:PROJECT_RESEARCH_ID}) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $__dest = "${_directory}\${env:PROJECT_SKU}-${env:PROJECT_RESEARCH_ID}_any-any.pdf"
                }


                # assemble the file
                $null = hestiaCONSOLE-Log-Assemble $__dest $__target
                $___process = hestiaFS-Copy-File $__dest $__target
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # return since it's done
                return ${env:hestiaKERNEL_ERROR_OK}
        }




        # determine unpack destination based on Base Filesystem Hierarchy Standard
        # only the following are used:
        #       (1) bin/  - holds executables
        #       (2) sbin/ - holds sysadmin executables
        #       (3) etc/  - holds configurations
        #       (4) lib/  - holds libraries
        #       (5) share/doc/ - holds documentations
        #       (6) share/fonts/ - holds font files
        #       (7) share/keyrings/ - holds GPG keyrings
        #       (8) src/ - holds source codes
        if ($(hestiaFS-Is-Filename-Has $__target "-doc") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "share\doc"
        } elseif ($(hestiaFS-Is-Filename-Has $__target "-src") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "src"
        } elseif ($(hestiaFS-Is-Filename-Has $__target "-font") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "share\fonts"
        } elseif ($(hestiaFS-Is-Filename-Has $__target ".gpg") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "share\keyrings"
        } elseif (($(hestiaFS-Is-Filename-Has $__target "lib") -eq ${env:hestiaKERNEL_ERROR_OK})) {
                $__dest = "lib"

                if (
                        ($(hestiaNPM-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                        ($(hestiaRUST-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK})
                ) {
                        $__dest = "" # tech-specific libraries
                }
        } elseif ($(hestiaWASM-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "lib"
        } else {
                $__dest = "bin"
                if ($(hestiaFS-Is-Filename-Has $__target "-sbin") -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $__dest = "sbin"
                }

                if (
                        ($(hestiaTAR-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                        ($(hestiaZIP-Is-Target-Valid $__target) -eq $hestiaKERNEL_ERROR_OK)
                ) {
                        $__dest = "" # manually override
                }
        }




        # set FHS level base pathing
        if ($_package_type -eq "unix") {
                switch (${env:PROJECT_FHS_LEVEL}) {
                1 {
                        if ($(hestiaSTRING-Is-Empty ${env:PROJECT_FHS_NATIVE} -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                $__dest = "${__directory}\data\usr\${__dest}"
                        } else {
                                $__dest = "${__directory}\data\usr\local\${__dest}"
                        }
                } default {
                        $__dest = "${__directory}\data\${__dest}"
                }
        } elseif ($(hestiaSTRING-Is-Empty $__dest) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $__dest = "${__directory}\${__dest}"
        } else {
                $__dest = $__directory
        }




        # assemble based on target's nature
        if ($(hestiaTAR-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # unpack tar*
                $null = hestiaCONSOLE-Log-Assemble $__dest $__target
                $null = hestiaFS-Create-Directory $__dest
                $___process = hestiaTAR-Unpack $__dest $__target
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } elseif ($(hestiaZIP-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # unpack zip
                $null = hestiaCONSOLE-Log-Assemble $__dest $__target
                $null = hestiaFS-Create-Directory $__dest
                $___process = hestiaZIP-Unpack $__dest $__target
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        } else {
                # assemble standalone file
                $___filename = hestiaFS-Get-File $__target
                switch -Wildcard ($___filename) {
                "*.elf" {
                        $___filename = hestiaFS-Replace-Extension $___filename ".elf" ""
                } default {
                        # do nothing
                }}

                $null = hestiaCONSOLE-Log-Assemble "${__dest}\${___filename}" $__target
                $null = hestiaFS-Create-Directory $__dest
                $___process = hestiaFS-Copy-File "${__dest}\${___filename}" $__target
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                }

                # if it is WASM artifact, then check for its gluing js script
                # whenever available.
                if ($(hestiaWASM-Is-Target-Valid $__target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $__source = "$(hestiaFS-Replace-Extension $__target ".wasm" ".js")"
                        if ($(hestiaFS-Is-File $__source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                                $__dest = "${__dest}\$(hestiaFS-Get-File $__source)"
                                $null = hestiaCONSOLE-Log-Assemble $__dest $__target
                                $___process = hestiaFS-Copy-File `
                                        "${__dest}\$(hestiaFS-Get-File $__target)" `
                                        $__target
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }
                }
        }




        # sanitize check before proceeding
        $null = hestiaCONSOLE-Log-Check $__directory
        if ($(hestiaFS-Is-Directory-Empty $__directory) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Check-Failed
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
