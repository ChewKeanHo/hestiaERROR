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
if (-not (Test-Path -Path ${env:PROJECT_PATH_ROOT})) {
        Write-Error "[ ERROR ] - Please run from automataCI\ci.sh.ps1 instead!`n"
        return 1
}

. "${env:LIBS_AUTOMATACI}\__package-assemble-default-content_windows-any.ps1"




function PACKAGE-Assemble-CONSOLIDATE-Content {
        param (
                [string]$__target,
                [string]$__directory,
                [string]$__target_name,
                [string]$__target_os,
                [string]$__target_arch
        )




        # IMPORTANT NOTICE:
        # (1)   It's your choice to assemble the content of the package as per
        #       your use cases. By default, AutomataCI offers FHS content
        #       assembly function ('PACKAGE_Assemble_Default_Content')
        #       that you can use.
        return PACKAGE-Assemble-Default-Content `
                $__target `
                $__directory `
                $__target_name `
                $__target_os `
                $__target_arch
}
