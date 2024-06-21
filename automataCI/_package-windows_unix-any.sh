#!/bin/sh
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
if [ "$PROJECT_PATH_ROOT" = "" ]; then
        >&2 printf "[ ERROR ] - Please run me from automataCI/ci.sh.ps1 instead!\n"
        return 1
fi

. "${LIBS_AUTOMATACI}/services/hestiaCONSOLE/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNUPKG/Get.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaOS/Is_Command_Available.sh.ps1"

. "${LIBS_AUTOMATACI}/__package-assemble-default-doc_unix-any.sh"
. "${LIBS_AUTOMATACI}/__package-assemble-default-metadata_unix-any.sh"




PACKAGE_WINDOWS() {
        #__filename="$1"
        #__target="$2"
        #__target_os="$3"
        #__target_arch="$4"
        #__package_time="$5"
        #__directory_output="$6"
        #__arguments="$7"




        # validate packager capabilities
        case "$3" in
        any|windows)
                # accepted
                ;;
        *)
                return $hestiaKERNEL_ERROR_OK # not supported
                ;;
        esac


        case "$4" in
        any|amd64)
                # accepted
                ;;
        arm64|i386|arm)
                return $hestiaKERNEL_ERROR_OK # msitools only supports amd64
                ;;
        *)
                return $hestiaKERNEL_ERROR_OK # not supported
                ;;
        esac




        # prepare source directory
        __directory_source="${6}/${4}"




        # import external assembly function
        __cmd="PACKAGE_Assemble_WINDOWS_Content"
        hestiaCONSOLE_Log_Check_Availability "$__cmd"

        __file_assembly="${PROJECT_PATH_CI}/package-windows_unix-any.sh"
        __file_assembly="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/${__file_assembly}"
        if [ $(hestiaFS_Is_File "$__file_assembly") -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Run_Failed
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
        . "$__file_assembly"

        if [ $(hestiaOS_Is_Command_Available "$__cmd") -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Check_Failed
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # execute assembly function
        hestiaCONSOLE_Log_Run "$__cmd"
        "$__cmd" "$2" "$__directory_source" "$1" "$3" "$4"
        ___process=$?
        case "$___process" in
        $hestiaKERNEL_ERROR_CANCELLED)
                hestiaCONSOLE_Log_Run_Skipped "$___process"
                return $hestiaKERNEL_ERROR_OK
                ;;
        $hestiaKERNEL_ERROR_OK)
                # proceed further
                ;;
        *)
                hestiaCONSOLE_Log_Run_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
                ;;
        esac




        # assemble all default metadata files
        PACKAGE_Assemble_Default_Metadata "${__directory_source}/share/doc"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble all default documentations
        PACKAGE_Assemble_Default_Doc "${__directory_source}/share/doc"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble project's license .rtf files for all languages
        for __source in "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/licenses/LICENSE"*.rtf; do
                if [ $(hestiaFS_Is_Exist "$__source") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                __dest="${__directory_source}/share/doc/$(hestiaFS_Get_File "$__source")"
                hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
                hestiaFS_Copy_File "$__dest" "$__source"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done




        # assemble icon.ico
        __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/icons/icon.ico"
        __dest="${__directory_source}/icon.ico"
        hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
        hestiaFS_Copy_File "$__dest" "$__source"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Assemble_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble msi-banner.jpg
        __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/icons/msi-banner.jpg"
        __dest="${__directory_source}/msi-banner.jpg"
        hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
        hestiaFS_Copy_File "$__dest" "$__source"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Assemble_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble msi-dialog.jpg
        __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/icons/msi-dialog.jpg"
        __dest="${__directory_source}/msi-dialog.jpg"
        hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
        hestiaFS_Copy_File "$__dest" "$__source"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Assemble_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble UI extension
        # IMPORTANT_NOTICE
        #       (1) While already tested, it appears msitools cannot use WiX's
        #           .NET extension libraries. Hence, let's comment it out since
        #           it cannot generate GUI elements anyway.
        #___ext="WixToolset.UI.wixext"
        #__source="wixext4/${___ext}.dll"
        #__dest="$__directory_source"
        #hestiaCONSOLE_Log_Assemble "${__dest}/${___ext}.dll" "$__source"
        #hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
        #hestiaNUPKG_Get \
        #        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_TOOLS}/${PROJECT_PATH_DOTNET_ENGINE}" \
        #        "https://www.nuget.org/api/v2/package" \
        #        "$___ext" \
        #        "4.0.3" \
        #        "" \
        #        "$__dest" \
        #        "$__source"
        #if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
        #        hestiaCONSOLE_Log_Assemble_Failed
        #        return $hestiaKERNEL_ERROR_BAD_EXEC
        #fi




        # report status
        return $hestiaKERNEL_ERROR_OK
}
