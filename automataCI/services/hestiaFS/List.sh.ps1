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
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-List {
        param (
                [string]$___source,
                [string]$___recursive_scan,
                [string]$___resolve_symlink
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___source) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }

        if ($(hestiaFS-Is-Directory $___source) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        $___scanned = $null
        if ($(hestiaFS-Is-Directory $___resolve_symlink) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaFS-Is-Directory $___recursive_scan) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___scanned = Get-ChildItem -File -Recurse -FollowSymlink -Path $___source
                } else {
                        $___scanned = Get-ChildItem -File -FollowSymlink -Path $___source
                }
        } else {
                if ($(hestiaFS-Is-Directory $___recursive_scan) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___scanned = Get-ChildItem -File -Recurse -Path $___source
                } else {
                        $___scanned = Get-ChildItem -File -Path $___source
                }
        }

        $___list = ""
        foreach ($___file in $___scanned) {
                $___list = "${___list}${___file}`n"
        }


        # report status
        return $___list
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
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_List() {
        #___source="$1"
        #___recursive_scan="$2"
        #___resolve_symlink="$3"


        # validate input
        if [ $(hestiaOS_Is_Command_Available "find") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_ENTITY_IS_NOT_DIRECTORY
        fi


        # execute
        ___scanned=""
        if [ $(hestiaSTRING_Is_Empty "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                if [ $(hestiaSTRING_Is_Empty "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ___scanned="$(find -L "$2" -type f 2>/dev/null)"
                else
                        ___scanned="$(find -L "$2" -maxdepth 1 -type f 2>/dev/null)"
                fi
        else
                if [ $(hestiaSTRING_Is_Empty "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ___scanned="$(find "$2" -type f 2>/dev/null)"
                else
                        ___scanned="$(find "$2" -maxdepth 1 -type f 2>/dev/null)"
                fi
        fi

        ___output=""
        ___old_IFS="$IFS"
        while IFS= read -r ___file || [ -n "$___file" ]; do
                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                ___output="${___output}${___file}\n"
        done <<EOF
$___scanned
EOF
        IFS="$___old_IFS" && unset ___old_IFS

        printf -- "%b" "$___output"


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
