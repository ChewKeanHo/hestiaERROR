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
        Write-Error "[ ERROR ] - Please run from automataIC\ci.sh.ps1 instead!`n"
        return
}

. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaOS\Is_Command_Available.sh.ps1"




function PACKAGE-CONSOLIDATE {
        param (
                [string]$__filename,
                [string]$__target,
                [string]$__target_os,
                [string]$__target_arch,
                [string]$__package_time,
                [string]$__directory_output,
                [string]$__arguments
        )




        # import external assembly function
        $__cmd = "PACKAGE-Assemble-CONSOLIDATE-Content"
        $null = hestiaCONSOLE-Log-Check-Availability $__cmd

        $__file_assembly = "${env:PROJECT_PATH_CI}\package-consolidate_windows-any.ps1"
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
        $___process = PACKAGE-Assemble-CONSOLIDATE-Content `
                $__target `
                $__directory_output `
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




        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
