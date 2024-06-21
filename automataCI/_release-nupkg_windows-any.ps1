# Copyright 2024 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at:
#               http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
. "${env:LIBS_AUTOMATACI}\services\hestiaOS\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaCONSOLE\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaKERNEL\Vanilla.sh.ps1"
. "${env:LIBS_AUTOMATACI}\services\hestiaNUPKG\Vanilla.sh.ps1"




# initialize
if (-not (Test-Path -Path $env:PROJECT_PATH_ROOT)) {
	Write-Error "[ ERROR ] - Please run from automataCI\ci.sh.ps1 instead!`n"
	return
}




function RELEASE-Run-NUPKG {
	param(
		[string]$__target
	)


	# validate input
	if ($(hestiaNUPKG-Is-Target-Valid "${__target}") -ne ${env:hestiaKERNEL_ERROR_OK}) {
		return ${env:hestiaKERNEL_ERROR_OK}
	}


	# execute
	$null = hestiaCONSOLE-Log-Publish "NUPKG"
	if ($(hestiaOS-Is-Simulation-Mode) -ne 0) {
		$___process = hestiaNUPKG-Publish `
			"${env:PROJECT_NUPKG_URL}" `
			"${env:NUPKG_TOKEN}" `
			"${__target}"
		if ($___process -ne 0) {
			$null = hestiaCONSOLE-Log-Publish-Failed
			return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
		}
	} else {
		# always simulate in case of error or mishaps before any point of no return
		$null = hestiaCONSOLE-Log-Publish-Simulate "NPM"
	}


	# report status
	return ${env:hestiaKERNEL_ERROR_OK}
}
