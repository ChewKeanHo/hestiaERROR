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
. "${env:LIBS_HESTIA}\hestiaFS\Append_Byte_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Append_Text_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaFS-Append-File {
        param (
                [string]$___target,
                [string]$___string_content,
                [byte[]]$___byte_content
        )


        # execute
        if ($(hestiaSTRING-Is-Empty $___string_content) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                # write as byte data type
                return hestiaFS-Append-Byte-File $___target $___byte_content
        } else {
                # default to text data type
                return hestiaFS-Append-Text-File $___target $___string_content
        }
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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Append_Byte_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Append_Text_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaFS_Append_File() {
        #___target="$1"
        #___string_content="$2"
        #___bytes_content="$3"


        # execute
        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                # write as byte data type
                hestiaFS_Append_Byte_File "$1" "$2"
        else
                # default to text data type
                hestiaFS_Append_Text_File "$1" "$2"
        fi


        # report status
        return $?
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
