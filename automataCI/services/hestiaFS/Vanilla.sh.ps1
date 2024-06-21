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
. "${env:LIBS_HESTIA}\hestiaFS\Append_Byte_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Append_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Append_Text_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Copy_Symbolic_Link.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Create_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Get_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Get_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Get_Relative_Path.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory_Empty.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Exist.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Filename_Has.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Socket.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Is_Symbolic_Link.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\List.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Merge_Directories.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Move.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Recreate_Directory.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Remove.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Replace_Extension.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Write_Byte_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Write_File.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Write_Text_File.sh.ps1"
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
return
<#
RUN_AS_POWERSHELL




################################################################################
# Unix Main Codes                                                              #
################################################################################
. "${LIBS_HESTIA}/hestiaFS/Append_Text_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Append_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Append_Byte_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Copy_Symbolic_Link.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Create_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Get_Relative_Path.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Directory_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Exist.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Filename_Has.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Socket.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Is_Symbolic_Link.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/List.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Merge_Directories.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Move.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Recreate_Directory.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Remove.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Replace_Extension.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Write_Byte_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Write_File.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Write_Text_File.sh.ps1"
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
