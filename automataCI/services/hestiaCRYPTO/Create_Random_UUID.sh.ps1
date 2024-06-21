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
. "${env:LIBS_HESTIA}\hestiaCRYPTO\Create_Random_Binary.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCRYPTO\Create_Random_Hex.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaTIME\Now.sh.ps1"




function hestiaCRYPTO-Create-Random-UUID {
        # execute
        $___length_data = 24
        $___length_epoch = 8

        $___data = "$(hestiaCRYPTO-Create-Random-Hex $___length_data)"
        $___epoch = '{0:X}' -f ([int] $(hestiaTIME-Now))

        $___output = ""
        $___length_data -= 1
        $___length_epoch -= 1
        for ($___count = 0; $___count -lt 32; $___count++) {
                switch ($___count) {
                { $_ -in 8, 12, 16, 20 } {
                        # add uuid dashes by the correct index
                        $___output += "-"
                } default {
                        # do nothing
                }}

                if (($(hestiaCRYPTO-Create-Random-Binary 1) -eq "1") -and ($___length_epoch -ge 0)) {
                        # gamble and add 1 character from epoch if won
                        $___output += $___epoch.Substring(0,1)
                        $___epoch = $___epoch.Substring(1)
                        $___length_epoch -= 1
                } elseif ($___length_data -ge 0) {
                        # add random character otherwise
                        $___output += $___data.Substring(0,1)
                        $___data = $___data.Substring(1)
                        $___length_data -= 1
                } elseif ($___length_epoch -ge 0) {
                        # only epoch left
                        $___output += $___epoch.Substring(0,1)
                        $___epoch = $___epoch.Substring(1)
                        $___length_epoch -= 1
                } else {
                        # impossible error edge cases - return nothing and fail
                        #                               is better than faulty.
                        return ""
                }
        }


        # report status
        return $___output
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
. "${LIBS_HESTIA}/hestiaCRYPTO/Create_Random_Binary.sh.ps1"
. "${LIBS_HESTIA}/hestiaCRYPTO/Create_Random_Hex.sh.ps1"
. "${LIBS_HESTIA}/hestiaTIME/Now.sh.ps1"




hestiaCRYPTO_Create_Random_UUID() {
        # execute
        ___length_data=24
        ___length_epoch=8

        ___data="$(hestiaCRYPTO_Create_Random_Hex "$___length_data")"
        ___epoch="$(printf -- "%X" "$(hestiaTIME_Now)")"

        ___output=""
        ___length_epoch=$(($___length_epoch - 1))
        ___length_data=$(($___length_data - 1))
        ___count=0
        while [ $___count -lt 32 ]; do
                case "$___count" in
                8|12|16|20)
                        # add uuid dashes by the correct index
                        ___output="${___output}-"
                        ;;
                *)
                        ;;
                esac

                if [ "$(hestiaCRYPTO_Create_Random_Binary 1)" = "1" ] && [ $___length_epoch -ge 0 ]; then
                        # gamble and add 1 character from epoch if won
                        ___remainder="${___epoch#?}"
                        ___output="${___output}${___epoch%"$___remainder"}"
                        ___epoch="$___remainder"
                        ___length_epoch=$(($___length_epoch - 1))
                elif [ $___length_data -ge 0 ]; then
                        # add random character otherwise
                        ___remainder="${___data#?}"
                        ___output="${___output}${___data%"$___remainder"}"
                        ___data="$___remainder"
                        ___length_data=$(($___length_data - 1))
                elif [ $___length_epoch -ge 0 ]; then
                        # only epoch left
                        ___remainder="${___epoch#?}"
                        ___output="${___output}${___epoch%"$___remainder"}"
                        ___epoch="$___remainder"
                        ___length_epoch=$(($___length_epoch - 1))
                else
                        # impossible error edge cases - return nothing and fail
                        #                               is better than faulty.
                        printf -- ""
                        return 1
                fi


                # increase counter since POSIX does not have C like for loop.
                ___count=$(($___count + 1))
        done


        # report status
        printf -- "%s" "$___output"
        return 0
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
