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
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaMSI\Get_Culture.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaMSI\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaOS\To_Arch_MSFT.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaMSI-Compile {
        param (
                [string]$___wxs,
                [string]$___arch,
                [string]$___lang,
                [string]$___dotnet_directory
        )


        # validate input
        if ($(hestiaMSI-Is-Available $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___wxs) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-File $___wxs) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        $___arch = hestiaOS-To-Arch-MSFT $___arch
        if ($(hestiaSTRING-Is-Empty $___arch) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISMATCHED}
        }

        $___lang = hestiaMSI-Get-Culture $___lang
        if ($(hestiaSTRING-Is-Empty $___lang) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISMATCHED}
        }


        # execute
        $___arguments = @"
build -arch ${___arch} -culture ${___lang} -out `"$(hestiaFS-Replace-Extension $___wxs ".wxs" ".msi")`"
"@

        foreach ($___ext in (
                Get-ChildItem -File -Path "$(hestiaFS-Get-Directory $___wxs)" -Filter "*.dll"
        )) {
                $___arguments += " -ext ${___ext}"
        }
        $___arguments += " ${___wxs}"

        $___process = hestiaOS-Exec "wix" $___arguments
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        # report status
        return ${env:hestiaKERNEL_ERROR_OK}
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
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaMSI/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaOS/To_Arch_MSFT.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaMSI_Compile() {
        #___wxs="$1"
        #___arch="$2"


        # validate input
        if [ $(hestiaMSI_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_File "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        ___arch="$(hestiaOS_To_Arch_MSFT "$2")"
        if [ $(hestiaSTRING_Is_Empty "$___arch") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISMATCHED
        fi

        for ___file in "$(hestiaFS_Get_Directory "$1")/"*; do
                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                        continue
                fi

                if [ ! "${___file%%.dll*}" = "$___file" ]; then
                        ___ext="${___ext} --ext \"${___file}\""
                fi
        done


        # execute
        wixl --verbose \
                --arch "$___arch" \
                ${___ext} \
                --output "$(hestiaFS_Replace_Extension "$1" ".wxs" ".msi")" \
                "$1"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
