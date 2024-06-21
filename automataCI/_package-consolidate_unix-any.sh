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
. "${LIBS_AUTOMATACI}/services/hestiaFS/Is_File.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaOS/Is_Command_Available.sh.ps1"




PACKAGE_CONSOLIDATE() {
        #__filename="$1"
        #__target="$2"
        #__target_os="$3"
        #__target_arch="$4"
        #__package_time="$5"
        #__directory_output="$6"
        #__arguments="$7"




        # import external assembly function
        __cmd="PACKAGE_Assemble_CONSOLIDATE_Content"
        hestiaCONSOLE_Log_Check_Availability "$__cmd"

        __file_assembly="${PROJECT_PATH_CI}/package-consolidate_unix-any.sh"
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
        "$__cmd" "$2" "$6" "$1" "$3" "$4"
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




        # report status
        return $hestiaKERNEL_ERROR_OK
}
