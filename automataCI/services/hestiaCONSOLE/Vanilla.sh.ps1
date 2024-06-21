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
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Assemble_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Assemble.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Assemble_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Assemble_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Check_Availability.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Check_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Check.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Check_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Check_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Create_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Create.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Create_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Create_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Merge_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Merge.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Merge_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Merge_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Package_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Package.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Package_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Package_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Publish_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Publish.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Publish_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Publish_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Recreate_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Recreate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Recreate_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Recreate_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Run_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Run.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Run_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Run_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaCONSOLE\Log_Success.sh.ps1"
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
return
<#
RUN_AS_POWERSHELL




################################################################################
# Unix Main Codes                                                              #
################################################################################
. "${LIBS_HESTIA}/hestiaCONSOLE/Log.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Assemble_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Assemble.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Assemble_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Assemble_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Check_Availability.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Check_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Check.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Check_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Check_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Create_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Create.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Create_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Create_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Merge_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Merge.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Merge_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Merge_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Package_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Package.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Package_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Package_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Publish_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Publish.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Publish_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Publish_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Recreate_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Recreate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Recreate_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Recreate_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Run_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Run.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Run_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Run_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaCONSOLE/Log_Success.sh.ps1"
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
