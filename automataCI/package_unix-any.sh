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


. "${LIBS_AUTOMATACI}/services/hestiaCHANGELOG/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaCITATION/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaCONSOLE/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaGIT/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaHOMEBREW/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaMSI/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNPM/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaOS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaPDF/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaRUST/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaSTRING/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaWASM/Is_Target_Valid_JS.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaTIME/Vanilla.sh.ps1"




# snap a release time
PACKAGE_TIME="$(hestiaTIME_Now)"
DIRECTORY_BUILD="${PROJECT_PATH_ROOT}/${PROJECT_PATH_BUILD}"
DIRECTORY_DOTNET="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TOOLS}/${PROJECT_PATH_DOTNET_ENGINE}"




# clean up the entire output directory for fresh packaging
DIRECTORY_OUTPUT="${PROJECT_PATH_ROOT}/${PROJECT_PATH_PKG}"
hestiaCONSOLE_Log_Recreate "$DIRECTORY_OUTPUT"
hestiaFS_Recreate_Directory "$DIRECTORY_OUTPUT"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# clean up homebrew consolidation directory
if [ "$(hestiaSTRING_Is_Empty "$PROJECT_HOMEBREW_URL")" -ne $hestiaKERNEL_ERROR_OK ]; then
        DIRECTORY_HOMEBREW="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-homebrew-${PROJECT_SKU}"
        hestiaCONSOLE_Log_Recreate "$DIRECTORY_HOMEBREW"
        hestiaFS_Recreate_Directory "$DIRECTORY_HOMEBREW"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
fi




# clean up msi (windows) consolidation directory
if [ "$(hestiaSTRING_Is_Empty "$PROJECT_MSI_CODEPAGE")" -ne $hestiaKERNEL_ERROR_OK ]; then
        DIRECTORY_MSI="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-msi-${PROJECT_SKU}"
        hestiaCONSOLE_Log_Recreate "$DIRECTORY_MSI"
        hestiaFS_Recreate_Directory "$DIRECTORY_MSI"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi

        if [ "$(hestiaSTRING_Is_Empty "$PROJECT_MSI_REGISTRY_KEY")" -eq $hestiaKERNEL_ERROR_OK ]; then
                PROJECT_MSI_REGISTRY_KEY="\
Software\\\\${PROJECT_SCOPE}\\\\InstalledProducts\\\\${PROJECT_SKU_TITLECASE}"
        fi
fi




# clean up flatpak repository directory
if [ "$(hestiaSTRING_Is_Empty "$PROJECT_FLATPAK_URL")" -ne $hestiaKERNEL_ERROR_OK ]; then
        DIRECTORY_FLATPAK="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-flatpak-${PROJECT_SKU}"
        hestiaCONSOLE_Log_Recreate "$DIRECTORY_FLATPAK"
        hestiaFS_Remove "$DIRECTORY_FLATPAK"

        if [ $(hestiaSTRING_Is_Empty "$PROJECT_FLATPAK_REPO") -ne $hestiaKERNEL_ERROR_OK ] &&
        [ $(hestiaSTRING_Is_Empty "$PROJECT_RELEASE_REPO") -eq $hestiaKERNEL_ERROR_OK ]; then
                # version controlled repository supplied; AND
                # single unified repository is not enabled
                if [ $(hestiaOS_Is_Simulation_Mode) -eq $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Recreate_Simulate "$DIRECTORY_FLATPAK"
                else
                        hestiaGIT_Clone "$PROJECT_FLATPAK_REPO" "$DIRECTORY_FLATPAK"
                        ___process=$?
                        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        hestiaGIT_Change_Branch "$DIRECTORY_FLATPAK" "$PROJECT_FLATPAK_REPO_BRANCH"
                        ___process=$?
                        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi

                if [ $(hestiaSTRING_Is_Empty "$PROJECT_FLATPAK_PATH") -ne $hestiaKERNEL_ERROR_OK ]; then
                        DIRECTORY_FLATPAK="${DIRECTORY_FLATPAK}/${PROJECT_FLATPAK_PATH}"
                fi
        fi

        hestiaFS_Create_Directory "$DIRECTORY_FLATPAK"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Recreate_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
fi




# clean up changelog directory
DIRECTORY_CHANGELOG="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-changelog"
hestiaCONSOLE_Log_Recreate "$DIRECTORY_CHANGELOG"
hestiaFS_Recreate_Directory "$DIRECTORY_CHANGELOG"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# generate markdown changelog
FILE_CHANGELOG_MD="${PROJECT_SKU}-CHANGELOG_${PROJECT_VERSION}.md"
FILE_CHANGELOG_MD="${PROJECT_PATH_ROOT}/${PROJECT_PATH_PKG}/${FILE_CHANGELOG_MD}"
hestiaCONSOLE_Log_Recreate "$FILE_CHANGELOG_MD"
hestiaCHANGELOG_Assemble_MARKDOWN \
        "$FILE_CHANGELOG_MD" \
        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/changelog/data" \
        "$PROJECT_CHANGELOG_TITLE" \
        "$PROJECT_VERSION"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# generate deb changelog
FILE_CHANGELOG_DEB="${DIRECTORY_CHANGELOG}/deb"
hestiaCONSOLE_Log_Recreate "$FILE_CHANGELOG_DEB"
hestiaCHANGELOG_Assemble_DEB \
        "$FILE_CHANGELOG_DEB" \
        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/changelog/deb" \
        "$PROJECT_VERSION"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# generate rpm changelog
FILE_CHANGELOG_RPM="${DIRECTORY_CHANGELOG}/rpm"
hestiaCONSOLE_Log_Recreate "$FILE_CHANGELOG_RPM"
hestiaCHANGELOG_Assemble_RPM \
        "$FILE_CHANGELOG_RPM" \
        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/changelog/data" \
        "$(hestiaTIME_Format_Date_RPM "$PACKAGE_TIME")" \
        "$PROJECT_CONTACT_NAME" \
        "$PROJECT_CONTACT_EMAIL" \
        "$PROJECT_VERSION" \
        "$PROJECT_CADENCE"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# generate CITATION.cff
FILE_CITATION_CFF="${PROJECT_SKU}-CITATION_${PROJECT_VERSION}.cff"
FILE_CITATION_CFF="${PROJECT_PATH_ROOT}/${PROJECT_PATH_PKG}/${FILE_CITATION_CFF}"
hestiaCONSOLE_Log_Recreate "$FILE_CITATION_CFF"
hestiaCITATION_Assemble \
        "$FILE_CITATION_CFF" \
        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/docs/ABSTRACTS.txt" \
        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/docs/CITATIONS.yml" \
        "$PROJECT_CITATION" \
        "$PROJECT_CITATION_TYPE" \
        "$(hestiaTIME_Format_Date_ISO8601 "$PACKAGE_TIME")" \
        "$PROJECT_NAME" \
        "$PROJECT_VERSION" \
        "$PROJECT_LICENSE" \
        "$PROJECT_SOURCE_URL" \
        "$PROJECT_SOURCE_URL" \
        "$PROJECT_STATIC_URL" \
        "$PROJECT_CONTACT_NAME" \
        "$PROJECT_CONTACT_WEBSITE" \
        "$PROJECT_CONTACT_EMAIL"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# clean up log directory
DIRECTORY_LOG="${PROJECT_PATH_ROOT}/${PROJECT_PATH_LOG}/packagers"
hestiaCONSOLE_Log_Recreate "$DIRECTORY_LOG"
hestiaFS_Recreate_Directory "$DIRECTORY_LOG"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# clean up parallel control directory
DIRECTORY_PARALLEL="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-parallel"
hestiaCONSOLE_Log_Recreate "$DIRECTORY_PARALLEL"
hestiaFS_Recreate_Directory "$DIRECTORY_PARALLEL"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# clean up serial control directory
DIRECTORY_SERIAL="${PROJECT_PATH_ROOT}/${PROJECT_PATH_TEMP}/packagers-serial"
hestiaCONSOLE_Log_Recreate "$DIRECTORY_SERIAL"
hestiaFS_Recreate_Directory "$DIRECTORY_SERIAL"
___process=$?
if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Recreate_Failed "$___process"
        return $hestiaKERNEL_ERROR_BAD_EXEC
fi




# setup subroutine function for parallel executions
SUBROUTINE_Package() {
        #__line="$1"

        __filename="${1%%|*}"
        __arguments="${1#*|}"

        __target="${__arguments%%|*}"
        __arguments="${__arguments#*|}"

        __target_os="${__arguments%%|*}"
        __arguments="${__arguments#*|}"

        __target_arch="${__arguments%%|*}"
        __arguments="${__arguments#*|}"

        __package_time="${__arguments%%|*}"
        __arguments="${__arguments#*|}"

        __function="${__arguments##*|}"
        __arguments="${__arguments%|*}"

        __directory_log="${__arguments##*|}"
        __arguments="${__arguments%|*}"

        __directory_output="${__arguments##*|}"

        __arguments="${__arguments%|*}"
        if [ "$__directory_output" = "$__arguments" ]; then
                __arguments=""
        fi


        # import required libraries
        . "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Vanilla.sh.ps1"


        # execute
        case "$__function" in
        "PACKAGE_APP")
                __log="${__directory_log}/app-${__filename}_${__target_os}-${__target_arch}.txt"
                ;;
        "PACKAGE_ARCHIVE")
                __log="${__directory_log}/archive-${__filename}_${__target_os}-${__target_arch}.txt"
                . "${LIBS_AUTOMATACI}/_package-archive_unix-any.sh"
                PACKAGE_ARCHIVE "$__filename" \
                        "$__target" \
                        "$__target_os" \
                        "$__target_arch" \
                        "$__package_time" \
                        "$__directory_output" \
                        "$__arguments" \
                        &> "$__log"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
                ;;
        "PACKAGE_SINGLE")
                __log="${__directory_log}/single-${__filename}_${__target_os}-${__target_arch}.txt"
                . "${LIBS_AUTOMATACI}/_package-single_unix-any.sh"
                PACKAGE_SINGLE "$__filename" \
                        "$__target" \
                        "$__target_os" \
                        "$__target_arch" \
                        "$__package_time" \
                        "$__directory_output" \
                        "$__arguments" \
                        &> "$__log"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
                ;;
        "PACKAGE_UNIX")
                __log="${__directory_log}/unix-${__filename}_${__target_os}-${__target_arch}.txt"
                ;;
        "PACKAGE_WINDOWS")
                __log="${__directory_log}/windows-${__filename}_${__target_os}-${__target_arch}.txt"
                . "${LIBS_AUTOMATACI}/_package-windows_unix-any.sh"
                PACKAGE_WINDOWS "$__filename" \
                        "$__target" \
                        "$__target_os" \
                        "$__target_arch" \
                        "$__package_time" \
                        "$__directory_output" \
                        "$__arguments" \
                        &> "$__log"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
                ;;
        "PACKAGE_CONSOLIDATE")
                __log="${__directory_log}/consolidate-${__filename}_${__target_os}-${__target_arch}.txt"
                . "${LIBS_AUTOMATACI}/_package-consolidate_unix-any.sh"
                PACKAGE_CONSOLIDATE "$__filename" \
                        "$__target" \
                        "$__target_os" \
                        "$__target_arch" \
                        "$__package_time" \
                        "$__directory_output" \
                        "$__arguments" \
                        &> "$__log"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
                ;;
        *)
                return $hestiaKERNEL_ERROR_BAD_EXEC
                ;;
        esac


        # report status
        return $hestiaKERNEL_ERROR_OK
}




# register built artifacts for parallel executions
if [ $(hestiaFS_Is_Directory "$DIRECTORY_BUILD") -ne $hestiaKERNEL_ERROR_OK ]; then
        # no artifacts at all - report status
        hestiaCONSOLE_Log_Success
        return $hestiaKERNEL_ERROR_OK
fi

for __artifact in "${DIRECTORY_BUILD}/"*; do
        if [ $(hestiaFS_Is_File "$__artifact") -ne $hestiaKERNEL_ERROR_OK ]; then
                continue
        fi


        # parse build candidate
        TARGET_FILENAME="$(hestiaFS_Get_File "$__artifact")"
        TARGET_FILENAME="${TARGET_FILENAME%.*}"
        TARGET_OS="${TARGET_FILENAME##*_}"
        TARGET_FILENAME="${TARGET_FILENAME%%_*}"
        TARGET_ARCH="${TARGET_OS##*-}"
        TARGET_ARCH="${TARGET_ARCH%%.*}"
        TARGET_OS="${TARGET_OS%%-*}"
        TARGET_OS="${TARGET_OS%%.*}"
        TAG_COMMON="${TARGET_FILENAME}|${__artifact}|${TARGET_OS}|${TARGET_ARCH}|${PACKAGE_TIME}"

        if [ "$(hestiaSTRING_Is_Empty "$TARGET_OS")" -eq $hestiaKERNEL_ERROR_OK ] ||
                [ "$(hestiaSTRING_Is_Empty "$TARGET_ARCH")" -eq $hestiaKERNEL_ERROR_OK ] ||
                [ "$(hestiaSTRING_Is_Empty "$TARGET_FILENAME")" -eq $hestiaKERNEL_ERROR_OK ]; then
                continue
        fi


        # register for single object type package
        if [ $(hestiaPDF_Is_Target_Valid "$__artifact") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaFS_Append_File "${DIRECTORY_PARALLEL}/control.txt" "\
${TAG_COMMON}|${DIRECTORY_OUTPUT}|${DIRECTORY_LOG}|PACKAGE_SINGLE
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                continue
        fi


        # register for classical .tar.xz, .zip, & .nupkg types
        hestiaFS_Append_File "${DIRECTORY_PARALLEL}/control.txt" "\
${TAG_COMMON}|${DIRECTORY_OUTPUT}|${DIRECTORY_LOG}|PACKAGE_ARCHIVE
"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        # bail tech-specific artifacts since the following no longer needs them
        if [ $(hestiaWASM_Is_Target_Valid_JS "$__artifact") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaNPM_Is_Target_Valid "$__artifact") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaRUST_Is_Target_Valid "$__artifact") -eq $hestiaKERNEL_ERROR_OK ]; then
                continue
        fi


        # register homebrew type
        if [ "$(hestiaSTRING_Is_Empty "$PROJECT_HOMEBREW_URL")" -ne $hestiaKERNEL_ERROR_OK ] && (
                [ ! "$TARGET_OS" = "windows" ]
        ); then
                hestiaFS_Append_File "${DIRECTORY_PARALLEL}/control.txt" "\
${TAG_COMMON}|${DIRECTORY_HOMEBREW}|${DIRECTORY_LOG}|PACKAGE_CONSOLIDATE
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi


        # register windows type
        if [ "$(hestiaSTRING_Is_Empty "$PROJECT_MSI_CODEPAGE")" -ne $hestiaKERNEL_ERROR_OK ] && (
                [ "$TARGET_OS" = "windows" ] || [ "$TARGET_OS" = "any" ]
        ); then
                hestiaFS_Append_File "${DIRECTORY_PARALLEL}/control.txt" "\
${TAG_COMMON}|${DIRECTORY_MSI}|${DIRECTORY_LOG}|PACKAGE_WINDOWS
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi


        # register app-only sandboxed|containerized packages
done




# execute in parallel
hestiaCONSOLE_Log_Run "$DIRECTORY_PARALLEL"
if [ $(hestiaFS_Is_File "${DIRECTORY_PARALLEL}/control.txt") -eq $hestiaKERNEL_ERROR_OK ]; then
        hestiaKERNEL_Run_Parallel_Sentinel "SUBROUTINE_Package" "$DIRECTORY_PARALLEL"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Run_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
fi




# execute homebrew package
if [ "$(hestiaSTRING_Is_Empty "$PROJECT_HOMEBREW_URL")" -ne $hestiaKERNEL_ERROR_OK ]; then
        __dest="${PROJECT_PATH_ROOT}/${PROJECT_PATH_PKG}/${PROJECT_SKU}.rb"
        hestiaCONSOLE_Log_Package "$__dest"
        hestiaHOMEBREW_Package \
                "$__dest" \
                "${PROJECT_SKU}-${PROJECT_HOMEBREW_ID}_${PROJECT_VERSION}_any-any.tar.xz" \
                "$DIRECTORY_HOMEBREW" \
                "$PROJECT_SKU" \
                "$PROJECT_PITCH" \
                "$PROJECT_CONTACT_WEBSITE" \
                "$PROJECT_LICENSE" \
                "$PROJECT_HOMEBREW_URL"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Package_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
fi




# execute msi package
if [ "$(hestiaSTRING_Is_Empty "$PROJECT_MSI_CODEPAGE")" -ne $hestiaKERNEL_ERROR_OK ]; then
        hestiaCONSOLE_Log_Package "MSI"
        if [ $(hestiaFS_Is_Directory "${DIRECTORY_MSI}/any") -eq $hestiaKERNEL_ERROR_OK ]; then
                # 'any' arch exists - merge into existing ones
                for _arch in "${DIRECTORY_MSI}/"*; do
                        if [ $(hestiaFS_Is_Directory "$_arch") -ne $hestiaKERNEL_ERROR_OK ]; then
                                continue
                        fi

                        if [ "$(hestiaFS_Get_File "$_arch")" = "any" ]; then
                                continue
                        fi

                        hestiaCONSOLE_Log_Merge "$_arch" "${DIRECTORY_MSI}/any"
                        hestiaFS_Merge_Directories "$_arch" "${DIRECTORY_MSI}/any"
                        ___process=$?
                        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                hestiaCONSOLE_Log_Merge_Failed "$___process"
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                done


                # remove 'any' arch to prevent dirty compilations
                hestiaFS_Remove "${DIRECTORY_MSI}/any"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Merge_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        fi


        # begin package creation
        for _arch in "${DIRECTORY_MSI}/"*; do
                if [ $(hestiaFS_Is_Directory "$_arch") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                hestiaCONSOLE_Log_Package "$_arch"
                hestiaMSI_Package \
                        "${PROJECT_PATH_ROOT}/${PROJECT_PATH_PKG}" \
                        "$_arch" \
                        "$PROJECT_SKU" \
                        "$PROJECT_VERSION" \
                        "$PRODUCT_APP_UUID" \
                        "$PROJECT_SCOPE" \
                        "$PROJECT_NAME" \
                        "$PROJECT_CONTACT_NAME" \
                        "$PROJECT_CONTACT_WEBSITE" \
                        "$PROJECT_MSI_INSTALLER_VERSION_UNIX" \
                        "$PROJECT_MSI_INSTALLER_SCOPE" \
                        "$PROJECT_MSI_REGISTRY_KEY" \
                        "$PROJECT_MSI_BIN_COMPONENT_GUID" \
                        "$PROJECT_MSI_ETC_COMPONENT_GUID" \
                        "$PROJECT_MSI_LIB_COMPONENT_GUID" \
                        "$PROJECT_MSI_DOC_COMPONENT_GUID" \
                        "$PROJECT_MSI_REGISTRIES_GUID" \
                        "$PROJECT_MSI_CODEPAGE" \
                        "$DIRECTORY_DOTNET"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Package_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done
fi




# execute in serial
hestiaCONSOLE_Log_Run "$DIRECTORY_SERIAL"
if [ $(hestiaFS_Is_File "${DIRECTORY_SERIAL}/control.txt") -eq $hestiaKERNEL_ERROR_OK ]; then
        hestiaKERNEL_Run_Parallel_Sentinel "SUBROUTINE_Package" "$DIRECTORY_SERIAL" "1"
        ___process=$?
        if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Run_Failed "$___process"
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi
fi




# report status
hestiaCONSOLE_Log_Success
return $hestiaKERNEL_ERROR_OK
