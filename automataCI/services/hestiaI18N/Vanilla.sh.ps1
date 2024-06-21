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
. "${env:LIBS_HESTIA}\hestiaI18N\Get_Languages_List.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_All_Components_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_All_Components_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Already_Latest_Version.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Assemble_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Assemble.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Assemble_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Assemble_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Bin_Component_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Bin_Component_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Check_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Check.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Check_Availability.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Check_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Check_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Create_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Create.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Create_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Create_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Doc_Component_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Doc_Component_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Done.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Error.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Etc_Component_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Etc_Component_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Info.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Lib_Component_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Lib_Component_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Main_Component_Description.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Main_Component_Title.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Merge_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Merge.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Merge_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Merge_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Note.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_OK.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Only_Install_On_Windows.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Package_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Package.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Package_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Package_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Publish_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Publish.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Publish_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Publish_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Recreate_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Recreate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Recreate_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Recreate_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Run_Failed.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Run.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Run_Simulate.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Run_Skipped.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Success.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Translate_Warning.sh.ps1"
################################################################################
# Windows POWERSHELL Codes                                                     #
################################################################################
return
<#
RUN_AS_POWERSHELL




################################################################################
# Unix Main Codes                                                              #
################################################################################
. "${LIBS_HESTIA}/hestiaI18N/Get_Languages_List.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_All_Components_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_All_Components_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Already_Latest_Version.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Assemble_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Assemble.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Assemble_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Assemble_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Bin_Component_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Bin_Component_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Check_Availability.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Check_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Check.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Check_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Check_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Create_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Create.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Create_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Create_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Doc_Component_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Doc_Component_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Done.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Error.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Etc_Component_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Etc_Component_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Info.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Lib_Component_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Lib_Component_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Main_Component_Description.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Main_Component_Title.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Merge_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Merge.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Merge_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Merge_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Note.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_OK.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Only_Install_On_Windows.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Package_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Package.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Package_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Package_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Publish_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Publish.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Publish_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Publish_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Recreate_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Recreate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Recreate_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Recreate_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Run_Failed.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Run.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Run_Simulate.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Run_Skipped.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Success.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Translate_Warning.sh.ps1"
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
