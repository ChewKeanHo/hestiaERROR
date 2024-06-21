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




PACKAGE_Assemble_Default_Doc() {
        #__directory="$1"




        # assemble project's user guide files for all languages
        for __source in "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/docs/USER-GUIDES"*.pdf; do
                if [ $(hestiaFS_Is_Exist "$__source") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                __dest="${1}/$(hestiaFS_Get_File "$__source")"
                hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
                hestiaFS_Copy_File "$__dest" "$__source"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done




        # assemble project's license files for all languages
        for __source in "${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/licenses/LICENSE"*.pdf; do
                if [ $(hestiaFS_Is_Exist "$__source") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                __dest="${1}/$(hestiaFS_Get_File "$__source")"
                hestiaCONSOLE_Log_Assemble "$__dest" "$__source"
                hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$__dest")"
                hestiaFS_Copy_File "$__dest" "$__source"
                ___process=$?
                if [ $___process -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaCONSOLE_Log_Assemble_Failed "$___process"
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done




        # report status
        return $hestiaKERNEL_ERROR_OK
}
