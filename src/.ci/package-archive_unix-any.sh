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
        >&2 printf "[ ERROR ] - Please run from automataCI/ci.sh.ps1 instead!\n"
        return 1
fi

. "${LIBS_AUTOMATACI}/__package-assemble-default-content_unix-any.sh"




PACKAGE_Assemble_ARCHIVE_Content() {
        #__target="$1"
        #__directory="$2"
        #__target_name="$3"
        #__target_os="$4"
        #__target_arch="$5"




        # IMPORTANT NOTICE:
        # (1)   AutomataCI supplies default function called
        #       'PACKAGE_Assemble_Default_Content' to keep things maintainable.
        #       You may remove it and customize the assembly behavior on your
        #       own.
        #
        # (2)   Duly noted that this is a multi-pipelines task where it produces
        #       the following artifacts in sequences:
        #               (2.1) NPM.tgz (when enabled & detected)
        #               (2.2) RUST.crate (when enabled & detected)
        #               (2.3) .tar.xz (when enabled)
        #               (2.4) .zip (when enabled)
        #               (2.5) chocolatey.nupkg (when enabled)
        #               (2.6) dotnet.nupkg (when enabled)
        #
        # (3)   If you wish to customize chocolatey tool scripts, please apply
        #       the changes into the provided template scripts inside:
        #       ${PROJECT_PATH_ROOT}/${PROJECT_PATH_SOURCE}/data/chocolatey/tools
        #       directory. They will be placed within during packaging process.
        #
        # (4)   Dated to this note, there is no need to customize .nuspec file
        #       since they are heavily governed by specifications. AutomataCI
        #       will generate them autonomously with files detections and
        #       processing. Hence, you only need to focus on placing the content
        #       at the right place.
        PACKAGE_Assemble_Default_Content "$1" "$2" "$3" "$4" "$5"
        return $?
}
