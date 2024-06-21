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
. "${env:LIBS_HESTIA}\hestiaFS\Is_Exist.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\To_Lowercase.sh.ps1"




function hestiaFS-Get-Size {
        param (
                [string]$___target,
                [string]$___quantification,
                [string]$___follow_link
        )


        # validate input
        if ($(hestiaSTRING-Is-Empty $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }

        if ($(hestiaFS-Is-Exist $___target) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ""
        }


        # execute
        switch ($(hestiaSTRING-To-Lowercase $___quantification)) {
        { $_ -in "k", "kb" } {
                # 1024 (kilobytes)
                $___size = 1024
        } { $_ -in "m", "mb" } {
                # 1000*1024 (megabytes)
                $___size = 1048576
        } { $_ -in "g", "gb" } {
                # 1000*1000*1024 (gigabytes)
                $___size = 1073741824
        } { $_ -in "t", "tb" } {
                # 1000*1000*1000*1024 (terabytes)
                $___size = 1099511627776
        } { $_ -in "p", "pb" } {
                # 1000*1000*1000*1000*1024 (petabytes)
                $___size = 1125899906842624
        } { $_ -in "e", "eb" } {
                # 1000*1000*1000*1000*1000*1024 (exabytes)
                $___size = 1152921504606846976
        } { $_ -in "z", "zb" } {
                # 1000*1000*1000*1000*1000*1000*1024 (zettabytes)
                $___size = 1180591620717411303424
        } { $_ -in "y", "yb" } {
                # 1000*1000*1000*1000*1000*1000*1000*1024 (yottabytes)
                $___size = 1208925819614629174706176
        } default {
                # 1 (byte)
                $___size = 1
        }}

        if ($(hestiaSTRING-Is-Empty $___follow_link) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                if ($(hestiaFS-Is-Directory $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $___value = Get-ChildItem -ErrorAction SilentlyContinue `
                                        -Recurse `
                                        -Force `
                                        -Include * `
                                        -FollowSymlink `
                                        -Path $___target
                                | Where-Object { $_.psiscontainer -eq $false } `
                                | Measure-Object -Property length -sum `
                                | Select-Object sum
                } else {
                        $___value = Get-ChildItem -ErrorAction SilentlyContinue `
                                        -FollowSymlink `
                                        -Path $___target
                                | Measure-Object -Property length -sum `
                                | Select-Object sum
                }
        } else {
                if ($(hestiaFS-Is-Directory $___target) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        $___value = Get-ChildItem -ErrorAction SilentlyContinue `
                                        -Recurse `
                                        -Force `
                                        -Include * `
                                        -Path $___target
                                | Where-Object { $_.psiscontainer -eq $false } `
                                | Measure-Object -Property length -sum `
                                | Select-Object sum
                } else {
                        $___value = Get-ChildItem -ErrorAction SilentlyContinue -Path $___target
                                | Measure-Object -Property length -sum `
                                | Select-Object sum
                }
        }

        return [math]::Round($___value.sum / $___size, 0)
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
. "${LIBS_HESTIA}/hestiaFS/Is_Exist.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/Is_Command_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/To_Lowercase.sh.ps1"




hestiaFS_Get_Size() {
        #___target="$1"
        #___quantification="$2"
        #___follow_link="$3"


        # validate input
        if [ $(hestiaOS_Is_Command_Available "du") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        ___link="--no-dereference"
        if [ $(hestiaSTRING_Is_Empty "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                ___link="--dereference"
        fi

        if [ $(hestiaFS_Is_Exist "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                printf -- ""
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi


        # execute
        case "$(hestiaSTRING_To_Lowercase "$2")" in
        k|kib)
                # 1024 (kilobytes)
                ___size=1024
                ;;
        m|mib)
                # 1000*1024 (megabytes)
                ___size=1048576
                ;;
        g|gib)
                # 1000*1000*1024 (gigabytes)
                ___size=1073741824
                ;;
        t|tib)
                # 1000*1000*1000*1024 (terabytes)
                ___size=1099511627776
                ;;
        p|pib)
                # 1000*1000*1000*1000*1024 (petabytes)
                ___size=1125899906842624
                ;;
        e|eib)
                # 1000*1000*1000*1000*1000*1024 (exabytes)
                ___size=1152921504606846976
                ;;
        z|zib)
                # 1000*1000*1000*1000*1000*1000*1024 (zettabytes)
                ___size=1180591620717411303424
                ;;
        y|yib)
                # 1000*1000*1000*1000*1000*1000*1000*1024 (yottabytes)
                ___size=1208925819614629174706176
                ;;
        *)
                # 1 (byte)
                ___size=1
                ;;
        esac

        ___size="$(du ${___link} --summarize --block-size="$___size" "$1")"
        ___output=""
        while [ -n "$___size" ]; do
                ___char="$(printf -- "%.1b" "$___size")"
                case "$___char" in
                0|1|2|3|4|5|6|7|8|9)
                        ___output="${___output}${___char}"
                        ;;
                *)
                        break
                        ;;
                esac

                ___size="${___size#*$___char}"
        done
        printf -- "%d" "$___output"


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
