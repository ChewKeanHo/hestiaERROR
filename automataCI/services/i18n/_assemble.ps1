# Copyright 2023 (Holloway) Chew, Kean Ho <hollowaykeanho@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at:
#                 http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
. "${env:LIBS_AUTOMATACI}\services\i18n\__printer.ps1"
. "${env:LIBS_AUTOMATACI}\services\i18n\__param.ps1"




function I18N-Assemble {
	param(
		[string]$___subject,
		[string]$___target
	)


	# execute
	switch (${env:AUTOMATACI_LANG}) {
	default {
		# fallback to default english
		$___subject = I18N-Param-Process "${___subject}"
		$___target = I18N-Param-Process "${___target}"
		$null = I18N-Status-Print info `
			"assembling '${___subject}' as/into '${___target}'...`n"
	}}


	# report status
	return 0
}
