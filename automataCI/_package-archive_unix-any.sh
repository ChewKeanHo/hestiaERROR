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

. "${LIBS_AUTOMATACI}/services/hestiaCONSOLE/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNUPKG/Package.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNPM/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaRUST/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaTAR/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaZIP/Vanilla.sh.ps1"

. "${LIBS_AUTOMATACI}/__package-assemble-default-doc_unix-any.sh"
. "${LIBS_AUTOMATACI}/__package-assemble-default-metadata_unix-any.sh"




PACKAGE_ARCHIVE() {
        #__filename="$1"
        #__target="$2"
        #__target_os="$3"
        #__target_arch="$4"
        #__package_time="$5"
        #__directory_output="$6"
        #__arguments="$7"




        # validate input
        hestiaCONSOLE_Log_Check_Availability "TAR"
        if [ $(hestiaTAR_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Check_Failed
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        hestiaCONSOLE_Log_Check_Availability "ZIP"
        if [ $(hestiaZIP_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Check_Failed
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # prepare workspace and required values
        __package_sku="$PROJECT_SKU"
        if [ $(hestiaFS_Is_Filename_Has "$2" "$PROJECT_DOCS_ID") -eq $hestiaKERNEL_ERROR_OK ]; then
                __package_sku="${PROJECT_SKU}-${PROJECT_DOCS_ID}"
        elif [ $(hestiaFS_Is_Filename_Has "$2" "lib") -eq $hestiaKERNEL_ERROR_OK ]; then
                __package_sku="lib${PROJECT_SKU}"
                if [ $(hestiaNPM_Is_Target_Valid "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                        # npm package
                        __package_sku="${PROJECT_SKU}-${PROJECT_NODE_NPM_ID}"
                elif [ $(hestiaRUST_Is_Target_Valid "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                        # rust crate package
                        __package_sku="${PROJECT_SKU}-${PROJECT_RUST_ID}"
                elif [ $(hestiaFS_Is_Filename_Has "$2" "$PROJECT_C_ID") -eq $hestiaKERNEL_ERROR_OK ]; then
                        # complied c package
                        __package_sku="lib${PROJECT_SKU}-${PROJECT_C_ID}"
                fi
        fi




        # remake workspace
        __directory_source="packagers-archive-${__package_sku}_${3}-${4}"
        __directory_source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/${__directory_source}"
        hestiaCONSOLE_Log_Recreate "$__directory_source"
        hestiaFS_Recreate_Directory "$__directory_source"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # import external assembly function
        __cmd="PACKAGE_Assemble_ARCHIVE_Content"
        hestiaCONSOLE_Log_Check_Availability "$__cmd"

        __file_assembly="${PROJECT_PATH_CI}/package-archive_unix-any.sh"
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
                ;;
        *)
                hestiaCONSOLE_Log_Run_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
                ;;
        esac




        # archive the assembled payload
        __package="${__package_sku}_${PROJECT_VERSION}_${3}-${4}"




        # assemble all default metadata files
        PACKAGE_Assemble_Default_Metadata "$__directory_source"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble all default documentations
        PACKAGE_Assemble_Default_Doc "$__directory_source"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # assemble icon.png
        __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/icons/icon-128x128.png"
        __dest="${__directory_source}/icon.png"
        hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
        hestiaFS_Copy_File "$__dest" "$__source"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Assemble_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # package npm package when detected
        if [ $(hestiaNPM_Is_Target_Valid "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaSTRING_Is_Empty "$PROJECT_NODE_NPM_ID") -eq $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_OK # disabled explicitly
                fi

                # package npm.tgz
                __dest="${6}/${__package_sku}_${PROJECT_VERSION}_${3}-${4}.tgz"
                hestiaCONSOLE_Log_Package "$__dest"
                hestiaTAR_Pack "$__dest" "$__directory_source"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                # can't be packaged as something else - report status
                return $hestiaKERNEL_ERROR_OK
        fi




        # package crate package when detected
        if [ $(hestiaRUST_Is_Target_Valid "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                # package .crate
                # TODO during Rust porting


                # can't be packaged as something else - report status
                return $hestiaKERNEL_ERROR_OK
        fi




        # package coventional archive files
        if [ $(hestiaSTRING_Is_Empty "$PROJECT_RELEASE_ARCHIVE") -ne $hestiaKERNEL_ERROR_OK ]; then
                # package tar.xz
                __dest="${6}/${__package}.tar.xz"
                hestiaCONSOLE_Log_Package "$__dest"
                hestiaTAR_Pack "$__dest" "$__directory_source" "xz"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                # package zip
                __dest="${6}/${__package}.zip"
                hestiaCONSOLE_Log_Package "$__dest"
                hestiaZIP_Pack "$__dest" "$__directory_source"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi




        # package chocolatey nupkg
        if ([ "$3" = "any" ] || [ "$3" = "windows" ]) &&
        [ $(hestiaSTRING_Is_Empty "$PROJECT_CHOCOLATEY_URL") -ne $hestiaKERNEL_ERROR_OK ]; then
                # create required tools/ directory
                hestiaFS_Create_Directory "${__directory_source}/tools"


                # create required tools/ChocolateyBeforeModify.ps1
                __source="tools/ChocolateyBeforeModify.ps1"
                __dest="${__directory_source}/${__source}"
                hestiaCONSOLE_Log_Create "$__dest"
                if [ $(hestiaFS_Is_File "$__dest") -eq $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                hestiaFS_Write_File "$__dest" "\
# REQUIRED - BEGIN EXECUTION
Write-Host \"Performing pre-configurations...\"
"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/data/chocolatey/${__source}"
                if [ $(hestiaFS_Is_File "$__source") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __old_IFS="$IFS"
                        while IFS= read -r __line || [ -n "$__line" ]; do
                                if [ $(hestiaSTRING_Has "$__line" "Done by AutomataCI") -eq $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "$__dest" "${__line}\n"
                                ___process=$?
                                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                        hestiaCONSOLE_Log_Create_Failed "$___process"
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done < "$__source"
                        IFS="$__old_IFS" && unset __old_IFS
                fi


                # create required tools/ChocolateyInstall.ps1
                __source="tools/ChocolateyInstall.ps1"
                __dest="${__directory_source}/${__source}"
                hestiaCONSOLE_Log_Create "$__dest"
                if [ $(hestiaFS_Is_File "$__dest") -eq $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                hestiaFS_Write_File "$__dest" "\
# REQUIRED - PREPARING INSTALLATION
Write-Host \"Installing ${__package_sku} (${PROJECT_VERSION})...\"
"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/data/chocolatey/${__source}"
                if [ $(hestiaFS_Is_File "$__source") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __old_IFS="$IFS"
                        while IFS= read -r __line || [ -n "$__line" ]; do
                                if [ $(hestiaSTRING_Has "$__line" "Done by AutomataCI") -eq $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "$__dest" "${__line}\n"
                                ___process=$?
                                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                        hestiaCONSOLE_Log_Create_Failed "$___process"
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done < "$__source"
                        IFS="$__old_IFS" && unset __old_IFS
                fi


                # create required tools/ChocolateyUninstall.ps1
                __source="tools/ChocolateyUninstall.ps1"
                __dest="${__directory_source}/${__source}"
                hestiaCONSOLE_Log_Create "$__dest"
                if [ $(hestiaFS_Is_File "$__dest") -eq $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                hestiaFS_Write_File "$__dest" "\
# REQUIRED - PREPARING UNINSTALLATION
Write-Host \"Uninstalling ${__package_sku} (${PROJECT_VERSION})...\"
"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Create_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                __source="${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/data/chocolatey/${__source}"
                if [ $(hestiaFS_Is_File "$__source") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __old_IFS="$IFS"
                        while IFS= read -r __line || [ -n "$__line" ]; do
                                if [ $(hestiaSTRING_Has "$__line" "Done by AutomataCI") -eq $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "$__dest" "${__line}\n"
                                ___process=$?
                                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                        hestiaCONSOLE_Log_Create_Failed "$___process"
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done < "$__source"
                        IFS="$__old_IFS" && unset __old_IFS
                fi


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
                __id="${PROJECT_SCOPE}-${__package_sku}-${3}-${4}"
                __id="${__id}-${PROJECT_CHOCOLATEY_ID}"
                __title="${PROJECT_NAME} (${__package_sku} ${3}-${4})"

                __dest="${__id}_${PROJECT_VERSION}_${3}-${4}.nupkg"
                __dest="${6}/${__dest}"
                hestiaCONSOLE_Log_Package "$__dest"
                hestiaNUPKG_Package \
                        "$__dest" \
                        "$__directory_source" \
                        "$__id" \
                        "$PROJECT_VERSION" \
                        "$PROJECT_PITCH" \
                        "$PROJECT_CONTACT_NAME" \
                        "$PROJECT_CONTACT_WEBSITE" \
                        "$PROJECT_LICENSE_FILE" \
                        "icon.png" \
                        "$PROJECT_README" \
                        "$PROJECT_LICENSE_ACCEPTANCE_REQUIRED" \
                        "$PROJECT_SOURCE_URL" \
                        "$__title"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi




        # clean up chocolatey's artifacts
        hestiaFS_Remove "${__directory_source}/tools/ChocolateyBeforeModify.ps1"
        hestiaFS_Remove "${__directory_source}/tools/ChocolateyInstall.ps1"
        hestiaFS_Remove "${__directory_source}/tools/ChocolateyUninstall.ps1"
        if [ "$(hestiaFS_Is_Directory_Empty "${__directory_source}/tools")" -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Remove "${__directory_source}/tools"
        fi

        for __nuspec in "${__directory_source}/"*.nuspec; do
                hestiaFS_Remove "$__nuspec"
        done




        # package DOTNET nupkg
        if [ $(hestiaSTRING_Is_Empty "$PROJECT_NUPKG_URL") -ne $hestiaKERNEL_ERROR_OK ]; then
                # IMPORTANT:    Nupkg specifically mentions the current practice
                #               is to use dot (.) namespacing as ID. Please
                #               comply for consistencies and compatibilities
                #               purposes.
                #
                #               The default pattern here considers the
                #               possibility of facilitating cross-compilation
                #               services at the guest side.
                __id="${PROJECT_SCOPE}.${__package_sku}.${3}.${4}"
                __title="${PROJECT_NAME} (${__package_sku} ${3}-${4})"

                __dest="${__package}.nupkg"
                __dest="${6}/${__dest}"
                hestiaCONSOLE_Log_Package "$__dest"
                hestiaNUPKG_Package \
                        "$__dest" \
                        "$__directory_source" \
                        "$__id" \
                        "$PROJECT_VERSION" \
                        "$PROJECT_PITCH" \
                        "$PROJECT_CONTACT_NAME" \
                        "$PROJECT_CONTACT_WEBSITE" \
                        "$PROJECT_LICENSE_FILE" \
                        "icon.png" \
                        "$PROJECT_README" \
                        "$PROJECT_LICENSE_ACCEPTANCE_REQUIRED" \
                        "$PROJECT_SOURCE_URL" \
                        "$__title"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi




        # clean up from DOTNET nupkg
        for __nuspec in "${__directory_source}/"*.nuspec; do
                hestiaFS_Remove "$__nuspec"
        done




        # report status
        return $hestiaKERNEL_ERROR_OK
}
