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

# prepare for parallel package
foreach ($i in (Get-ChildItem -Path "${env:PROJECT_PATH_ROOT}\${env:PROJECT_PATH_BUILD}")) {
        # NOTE: deb does not work in windows or mac
        if ($(STRINGS-Is-Empty "${env:PROJECT_DEB_URL}") -ne 0) {
                switch ("${TARGET_OS}") {
                { $_ -in "windows", "darwin" } {
                        $__log = "deb_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        $__log = "${__log_directory}\${__log}"
                        $___process = FS-Append-File "${__parallel_control}" @"
${__common}|${FILE_CHANGELOG_DEB}|${__log}|PACKAGE-Run-DEB

"@
                        if ($___process -ne 0) {
                                return 1
                        }
                } default {
                }}
        }


        # NOTE: container only server windows and linux
        if ($(STRINGS-Is-Empty "${env:PROJECT_CONTAINER_REGISTRY}") -ne 0) {
                switch ("${TARGET_OS}") {
                { $_ -in "any", "linux", "windows" } {
                        $__log = "docker_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        $__log = "${__log_directory}\${__log}"
                        $___process = FS-Append-File "${__serial_control}" @"
${__common}|${__log}|PACKAGE-Run-DOCKER

"@
                        if ($___process -ne 0) {
                                return 1
                        }
                } default {
                }}
        }


        # NOTE: flatpak only serve linux
        $___process = FLATPAK-Is-Available
        if (($___process -eq 0) -and
                ($(STRINGS-Is-Empty "${env:PROJECT_FLATPAK_URL}") -ne 0)) {
                switch ("${TARGET_OS}") {
                { $_ -in "any", "linux" } {
                        $__log = "flatpak_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        $__log = "${__log_directory}\${__log}"
                        $___process = FS-Append-File "${__serial_control}" @"
${__common}|${FLATPAK_REPO}|${__log}|PACKAGE-Run-FLATPAK

"@
                        if ($___process -ne 0) {
                                return 1
                        }
                } default {
                }}
        }

        if ($(STRINGS-Is-Empty "${env:PROJECT_RELEASE_IPK}") -ne 0) {
                $__log = "ipk_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                $__log = "${__log_directory}\${__log}"
                $___process = FS-Append-File "${__parallel_control}" @"
${__common}|${__log}|PACKAGE-Run-IPK

"@
                if ($___process -ne 0) {
                        return 1
                }
        }

        # NOTE: RPM only serve linux
        if ($(STRINGS-Is-Empty "${env:PROJECT_RPM_URL}") -ne 0) {
                switch ("${TARGET_OS}") {
                { $_ -in "any", "linux" } {
                        $__log = "rpm_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        $__log = "${__log_directory}\${__log}"
                        $___process = FS-Append-File "${__parallel_control}" @"
${__common}|${__log}|PACKAGE-Run-RPM

"@
                        if ($___process -ne 0) {
                                return 1
                        }
                } default {
                }}
        }
}
