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




function PACKAGE-Assemble-Default-Metadata {
        param (
                [string]$__directory
        )




        # assemble project README file
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_README}"
        $__dest = "${__directory}\${env:PROJECT_README}"
        if ($(hestiaFS-Is-File $__dest) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble $__dest $__source
                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $__dest)"
                $___process = hestiaFS-Copy-File $__dest $__source
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # assemble project LICENSE file
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_LICENSE_FILE}"
        $__dest = "${__directory}\${env:PROJECT_LICENSE_FILE}"
        if ($(hestiaFS-Is-File $__dest) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble $__dest $__source
                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $__dest)"
                $___process = hestiaFS-Copy-File $__dest $__source
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
