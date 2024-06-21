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
. "${LIBS_AUTOMATACI}/services/hestiaOS/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaCONSOLE/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaKERNEL/Vanilla.sh.ps1"
. "${LIBS_AUTOMATACI}/services/hestiaNUPKG/Vanilla.sh.ps1"




# initialize
if [ "$PROJECT_PATH_ROOT" = "" ]; then
        >&2 printf "[ ERROR ] - Please run me from automataCI/ci.sh.ps1 instead!\n"
        return 1
fi




RELEASE_Run_NUPKG() {
        #__target="$1"


        # validate input
        if [ $(hestiaNUPKG_Is_Target_Valid "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_OK
        fi


        # execute
        hestiaCONSOLE_Log_Publish "NUPKG"
        if [ $(hestiaOS_Is_Simulation_Mode) -ne 0 ]; then
                hestiaNUPKG_Publish "$PROJECT_NUPKG_URL" "$NUPKG_TOKEN" "$__target"
                if [ $? -ne 0 ]; then
                        hestiaCONSOLE_Log_Publish_Failed
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        else
                # always simulate in case of error or mishaps before any point of no return
                hestiaCONSOLE_Log_Publish_Simulate "NUPKG"
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
