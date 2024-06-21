#!/bin/sh
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
if [ "$PROJECT_PATH_ROOT" = "" ]; then
        >&2 printf "[ ERROR ] - Please run me from automataCI/ci.sh.ps1 instead!\n"
        return 1
fi




# begin registering packagers
for i in "${PROJECT_PATH_ROOT}/${PROJECT_PATH_BUILD}"/*; do
        # NOTE: deb does not work in windows or mac
        if [ $(STRINGS_Is_Empty "$PROJECT_DEB_URL") -ne 0 ]; then
                case "$TARGET_OS" in
                windows|darwin)
                        ;;
                *)
                        __log="deb_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        __log="${__log_directory}/${__log}"
                        FS_Append_File "$__parallel_control" "\
${__common}|${FILE_CHANGELOG_DEB}|${__log}|PACKAGE_Run_DEB
"
                        if [ $? -ne 0 ]; then
                                return 1
                        fi
                        ;;
                esac
        fi


        # NOTE: container only serve windows and linux
        if [ $(STRINGS_Is_Empty "$PROJECT_CONTAINER_REGISTRY") -ne 0 ]; then
                case "$TARGET_OS" in
                any|linux|windows)
                        __log="docker_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        __log="${__log_directory}/${__log}"
                        FS_Append_File "$__serial_control" "\
${__common}|${__log}|PACKAGE_Run_DOCKER
"
                        if [ $? -ne 0 ]; then
                                return 1
                        fi
                        ;;
                *)
                        ;;
                esac
        fi


        # NOTE: flatpak only serve linux
        FLATPAK_Is_Available
        if [ $? -eq 0 ] && [ $(STRINGS_Is_Empty "$PROJECT_FLATPAK_URL") -ne 0 ]; then
                case "$TARGET_OS" in
                any|linux)
                        __log="flatpak_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        __log="${__log_directory}/${__log}"
                        FS_Append_File "$__serial_control" "\
${__common}|${FLATPAK_REPO}|${__log}|PACKAGE_Run_FLATPAK
"
                        if [ $? -ne 0 ]; then
                                return 1
                        fi
                        ;;
                *)
                        ;;
                esac
        fi

        if [ $(STRINGS_Is_Empty "$PROJECT_RELEASE_IPK") -ne 0 ]; then
                __log="ipk_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                __log="${__log_directory}/${__log}"
                FS_Append_File "$__parallel_control" "\
${__common}|${__log}|PACKAGE_Run_IPK
"
                if [ $? -ne 0 ]; then
                        return 1
                fi
        fi

        # NOTE: RPM only serve linux
        if [ $(STRINGS_Is_Empty "$PROJECT_RPM_URL") -ne 0 ]; then
                case "$TARGET_OS" in
                any|linux)
                        __log="rpm_${TARGET_FILENAME}_${TARGET_OS}-${TARGET_ARCH}.log"
                        __log="${__log_directory}/${__log}"
                        FS_Append_File "$__parallel_control" "\
${__common}|${__log}|PACKAGE_Run_RPM
"
                        if [ $? -ne 0 ]; then
                                return 1
                        fi
                        ;;
                *)
                        ;;
                esac
        fi
done
