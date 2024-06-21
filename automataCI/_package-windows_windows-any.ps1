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
        Write-Error "[ ERROR ] - Please run from automataIC\ci.sh.ps1 instead!`n"
        return
}

. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNUPKG\Get.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaOS\Is_Command_Available.sh.ps1"

. "${env:LIBS_AUTOMATACI}\__package-assemble-default-doc_windows-any.ps1"
. "${env:LIBS_AUTOMATACI}\__package-assemble-default-metadata_windows-any.ps1"




function PACKAGE-WINDOWS {
        param (
                [string]$__filename,
                [string]$__target,
                [string]$__target_os,
                [string]$__target_arch,
                [string]$__package_time,
                [string]$__directory_output,
                [string]$__arguments
        )




        # validate packager capabilities
        switch ($__target_os) {
        { $_ -in "any", "windows" } {
                # accepted
        } default {
                return ${env:hestiaKERNEL_ERROR_OK} # not supported
        }}


        switch ($__target_arch) {
        { $_ -in "any", "amd64", "arm64", "i386", "arm" } {
                # accepted
        } default {
                return ${env:hestiaKERNEL_ERROR_OK} # not supported
        }}




        # prepare source directory
        $__directory_source = "${__directory_output}\${__target_arch}"




        # import external assembly function
        $__cmd = "PACKAGE-Assemble-WINDOWS-Content"
        $null = hestiaCONSOLE-Log-Check-Availability $__cmd

        $__file_assembly = "${env:PROJECT_PATH_CI}\package-windows_windows-any.ps1"
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
        $___process = PACKAGE-Assemble-WINDOWS-Content `
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




        # assemble all default metadata files
        $___process = PACKAGE-Assemble-Default-Metadata "${__directory_source}/share/doc"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble all default documentatons
        $___process = PACKAGE-Assemble-Default-Doc "${__directory_source}/share/doc"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble project's license .rtf files for all languages
        foreach ($__source in (Get-ChildItem `
                -File `
                -Path "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\licenses" `
                -Filter "LICENSE*.rtf"
        )) {
                $__dest = "${__directory_source}\share\doc\$(hestiaFS-Get-File $__source)"
                $null = hestiaCONSOLE-Log-Assemble $__dest $__source
                $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $__dest)"
                $___process = hestiaFS-Copy-File $__dest $__source
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
        }




        # assemble icon.ico
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\icons\icon.ico"
        $__dest = "${__directory_source}\icon.ico"
        $null = hestiaCONSOLE-Log-Assemble $__dest $__source
        $___process = hestiaFS-Copy-File $__dest $__source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble msi-banner.jpg
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\icons\msi-banner.jpg"
        $__dest = "${__directory_source}\msi-banner.jpg"
        $null = hestiaCONSOLE-Log-Assemble $__dest $__source
        $___process = hestiaFS-Copy-File $__dest $__source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble msi-dialog.jpg
        $__source = "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_SOURCE}\icons\msi-dialog.jpg"
        $__dest = "${__directory_source}\msi-dialog.jpg"
        $null = hestiaCONSOLE-Log-Assemble $__dest $__source
        $___process = hestiaFS-Copy-File $__dest $__source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # assemble WiX UI extension library
        $___ext = "WixToolset.UI.wixext"
        $__source = "wixext4\${___ext}.dll"
        $__dest = $__directory_source
        $null = hestiaCONSOLE-Log-Assemble "${__dest}\${___ext}.dll" $__source
        $___process = hestiaNUPKG-Get `
                "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_TOOLS}\${env:PROJECT_PATH_DOTNET_ENGINE}" `
                "https://www.nuget.org/api/v2/package" `
                $___ext `
                "4.0.3" `
                "" `
                $__dest `
                $__source
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                $null = hestiaCONSOLE-Log-Assemble-Failed $___process
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }




        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
}
