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

. "${LIBS_AUTOMATACI}/__package-assemble-default-content_unix-any.sh"




PACKAGE_Assemble_CONSOLIDATE_Content() {
        #__target="$1"
        #__directory="$2"
        #__target_name="$3"
        #__target_os="$4"
        #__target_arch="$5"




        # IMPORTANT NOTICE:
        # (1)   It's your choice to assemble the content of the package as per
        #       your use cases. By default, AutomataCI offers FHS content
        #       assembly function ('PACKAGE_Assemble_Default_Content')
        #       that you can use.
        PACKAGE_Assemble_Default_Content "$1" "$2" "$3" "$4" "$5"
        return $?
}
