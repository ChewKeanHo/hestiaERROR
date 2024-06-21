echo \" <<'RUN_AS_BATCH' >/dev/null ">NUL "\" \`" <#"
@ECHO OFF
REM LICENSE CLAUSES HERE
REM ----------------------------------------------------------------------------




REM ############################################################################
REM # Windows BATCH Codes                                                      #
REM ############################################################################
where /q powershell
if errorlevel 1 (
        echo "ERROR: missing powershell facility."
        exit /b 1
)

copy /Y "%~nx0" "%~n0.ps1" >nul
timeout /t 1 /nobreak >nul
powershell -executionpolicy remotesigned -Command "& '.\%~n0.ps1' %*"
start /b "" cmd /c del "%~f0" & exit /b %errorcode%
REM ############################################################################
REM # Windows BATCH Codes                                                      #
REM ############################################################################
RUN_AS_BATCH
#> | Out-Null




echo \" <<'RUN_AS_POWERSHELL' >/dev/null # " | Out-Null
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
. "${env:LIBS_HESTIA}\hestiaFS\Get_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Get_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Replace-Extension {
        param (
                [string]$___path,
                [string]$___extension,
                [string]$___candidate
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___path) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        $___target = hestiaFS-Get-File $___path
        $___directory = hestiaFS-Get-Directory $___path
        if ($___extension -eq "*") {
                ## trim all extensions to the first period
                $___target = $___target -replace '(\.\w+)+$', ''

                ## restore directory pathing when available
                if (
                        ($(hestiaSTRING-Is-Empty $___directory) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                        ($___directory -ne $___path)
                ) {
                        $___target = "${___directory}\${___target}"
                }
        } elseif ($(hestiaSTRING-Is-Empty $___extension) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                ## trim off existing extension
                if ($___extension.Substring(0,1) -eq ".") {
                        $___extension = $___extension.Substring(1)
                }
                $___extension = [regex]::Escape($___extension)
                $___target = $___target -replace "\.${___extension}$", ''

                ## append new extension when available
                if (
                        ($___target -ne (hestiaFS-Get-File $___path)) -and
                        ($(hestiaSTRING-Is-Empty $___candidate) -ne ${env:hestiaKERNEL_ERROR_OK})
                ) {
                        if ($___candidate.Substring(0,1) -eq ".") {
                                $___target += "." + $___candidate.Substring(1)
                        } else {
                                $___target += "." + $___candidate
                        }
                }

                ## restore directory pathing when available
                if (
                        ($(hestiaSTRING-Is-Empty $___directory) -ne ${env:hestiaKERNEL_ERROR_OK}) -and
                        ($___directory -ne $___path)
                ) {
                        $___target = "${___directory}\${___target}"
                }
        } else {
                ## do nothing
                $___target = $___path
        }


        # report status
        return $___target
}
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
return
<#
RUN_AS_POWERSHELL




################################################################################
# Unix Main Codes                                                              #
################################################################################
. "${LIBS_HESTIA}/hestiaFS/Get_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Replace_Extension() {
        #___path="$1"
        #___extension="$2"
        #___candidate="$3"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- "%d" "$hestiaKERNEL_ERROR_DATA_EMPTY"
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        ___target="$(hestiaFS_Get_File "$1")"
        ___directory="$(hestiaFS_Get_Directory "$1")"
        if [ "$2" = "*" ]; then
                ## trim all extensions to the first period
                ___target="${___target%%.*}"

                ## restore directory pathing when available
                if [ $(hestiaSTRING_Is_Empty "$___directory") -ne $hestiaKERNEL_ERROR_OK ] &&
                        [ ! "$___directory" = "$1" ]; then
                        ___target="${___directory}/${___target}"
                fi
        elif [ $(hestiaSTRING_Is_Empty "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                ## trim off existing extension
                ___extension="$2"
                if [ "$(printf -- "%.1s" "$2")" = "." ]; then
                        ___extension="${2#*.}"
                fi
                ___target="${___target%.${___extension}*}"

                ## append new extension when available
                if [ ! "$(hestiaFS_Get_File "$1")" = "$___target" ] &&
                        [ $(hestiaSTRING_Is_Empty "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                        if [ "$(printf -- "%.1s" "$3")" = "." ]; then
                                ___target="${___target}.${3#*.}"
                        else
                                ___target="${___target}.${3}"
                        fi
                fi

                ## restore directory pathing when available
                if [ $(hestiaSTRING_Is_Empty "$___directory") -ne $hestiaKERNEL_ERROR_OK ] &&
                        [ ! "$___directory" = "$1" ]; then
                        ___target="${___directory}/${___target}"
                fi
        else
                ## do nothing
                ___target="$1"
        fi


        # report status
        printf -- "%s" "$___target"
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
