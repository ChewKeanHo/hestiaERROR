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
        >&2 printf "[ ERROR ] - Please run from automataCI/ci.sh.ps1 instead!\n"
        return 1
fi

. "${LIBS_AUTOMATACI}/services/hestiaCONSOLE/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNPM/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaPDF/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaRUST/Is_Target_Valid.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaTAR/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaWASM/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaZIP/Vanilla.sh.ps1"




PACKAGE_Assemble_Default_Content() {
        #__target="$1"
        #__directory="$2"
        #__target_name="$3"
        #__target_os="$4"
        #__target_arch="$5"
        #__package_type="$6"




        # validate input
        if [ $(hestiaWASM_Is_Target_Valid_JS "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_CANCELLED # not applicable
        fi




        # assemble single file type
        if [ $(hestiaPDF_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                # determine unpack destination
                __dest="${2}/$(hestiaFS_Get_File "$1")"
                if [ $(hestiaFS_Is_Filename_Has "$1" "$PROJECT_RESEARCH_ID") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __dest="${2}/${PROJECT_SKU}-${PROJECT_RESEARCH_ID}_any-any.pdf"
                fi


                # assemble the file
                hestiaCONSOLE_Log_Assemble "$__dest" "$1"
                hestiaFS_Copy_File "$__dest" "$1"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # return since it's done
                return $hestiaKERNEL_ERROR_OK
        fi




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
        if [ $(hestiaFS_Is_Filename_Has "$1" "-doc") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="share/doc"
        elif [ $(hestiaFS_Is_Filename_Has "$1" "-src") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="src"
        elif [ $(hestiaFS_Is_Filename_Has "$1" "-font") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="share/fonts"
        elif [ $(hestiaFS_Is_Filename_Has "$1" ".gpg") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="share/keyrings"
        elif [ $(hestiaFS_Is_Filename_Has "$1" "lib") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="lib"

                if [ $(hestiaNPM_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                        [ $(hestiaRUST_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __dest="" # tech-specific libraries
                fi
        elif [ $(hestiaWASM_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                __dest="lib"
        else
                __dest="bin"
                if [ $(hestiaFS_Is_Filename_Has "$1" "-sbin") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __dest="sbin"
                fi

                if [ $(hestiaTAR_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaZIP_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __dest="" # manually override
                fi
        fi




        # set FHS level base pathing
        if [ "$6" = "unix" ]; then
                case "$PROJECT_FHS_LEVEL" in
                1)
                        if [ $(hestiaSTRING_Is_Empty "$PROJECT_FHS_NATIVE") -ne $hestiaKERNEL_ERROR_OK ]; then
                                __dest="${2}/data/usr/${__dest}"
                        else
                                __dest="${2}/data/usr/local/${__dest}"
                        fi
                        ;;
                *)
                        __dest="${2}/data/${__dest}"
                        ;;
                esac
        elif [ $(hestiaSTRING_Is_Empty "$__dest") -ne $hestiaKERNEL_ERROR_OK ]; then
                __dest="${2}/${__dest}"
        else
                __dest="${2}"
        fi




        # assemble payload based on target's nature
        if [ $(hestiaTAR_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                # unpack tar*
                hestiaCONSOLE_Log_Assemble "$__dest" "$1"
                hestiaFS_Create_Directory "$__dest"
                hestiaTAR_Unpack "$__dest" "$1"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        elif [ $(hestiaZIP_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                # unpack zip
                hestiaCONSOLE_Log_Assemble "$__dest" "$1"
                hestiaFS_Create_Directory "$__dest"
                hestiaZIP_Unpack "$__dest" "$1"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        else
                # assemble standalone file
                ___filename="$(hestiaFS_Get_File "$1")"
                case "$___filename" in
                *.elf)
                        ___filename="$(hestiaFS_Replace_Extension "$___filename" ".elf" "")"
                        ;;
                *)
                        # do nothing
                        ;;
                esac

                hestiaCONSOLE_Log_Assemble "${__dest}/${___filename}" "$1"
                hestiaFS_Create_Directory "$__dest"
                hestiaFS_Copy_File "${__dest}/${___filename}" "$1"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                # if it is WASM artifact, then check for its gluing js script
                # whenever available.
                if [ $(hestiaWASM_Is_Target_Valid "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                        __source="$(hestiaFS_Replace_Extension "$1" ".wasm" ".js")"
                        if [ $(hestiaFS_Is_File "$__source") -eq $hestiaKERNEL_ERROR_OK ]; then
                                __dest="${__dest}/$(hestiaFS_Get_File "$__source")"
                                hestiaCONSOLE_Log_Assemble "$__dest" "$1"
                                hestiaFS_Copy_File "${__dest}/$(hestiaFS_Get_File "$1")" "$1"
                                ___process=$?
                                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        fi
                fi
        fi




        # sanitize check before proceeding
        hestiaCONSOLE_Log_Check "$2"
        if [ $(hestiaFS_Is_Directory_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                hestiaCONSOLE_Log_Check_Failed
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi




        # report status
        return $hestiaKERNEL_ERROR_OK
}
