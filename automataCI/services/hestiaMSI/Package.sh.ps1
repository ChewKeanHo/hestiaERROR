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
. "${env:LIBS_HESTIA}\hestiaCRYPTO\Create_Random_String.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaFS\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaI18N\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaKERNEL\Error_Codes.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaLOCALE\Get_LCID.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaMSI\Compile.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaMSI\Is_Available.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Is_Empty.sh.ps1"




function hestiaMSI-Package {
        param (
                [string]$___directory_dest,
                [string]$___directory_workspace,
                [string]$___sku,
                [string]$___version,
                [string]$___uuid,
                [string]$___project_scope,
                [string]$___project_name,
                [string]$___contact_name,
                [string]$___contact_website,
                [string]$___installer_version,
                [string]$___installer_scope,
                [string]$___registry_key,
                [string]$___uuid_component_bin,
                [string]$___uuid_component_etc,
                [string]$___uuid_component_lib,
                [string]$___uuid_component_docs,
                [string]$___uuid_component_registries,
                [string]$___codepage,
                [string]$___dotnet_directory
        )


        # validate input
        if ($(hestiaMSI-Is-Available $___dotnet_directory) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaSTRING-Is-Empty $___directory_dest) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___directory_workspace) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___sku) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___version) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___project_scope) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___project_name) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___contact_name) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___contact_website) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___installer_version) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___installer_scope) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___registry_key) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid_component_bin) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid_component_etc) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid_component_lib) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid_component_docs) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___uuid_component_registries) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSTRING-Is-Empty $___codepage) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaFS-Is-Directory $___directory_dest) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_ENTITY_INVALID}
        }

        if ($(hestiaFS-Is-Directory $___directory_workspace) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_INVALID}
        }

        if ($(hestiaFS-Is-File "${___directory_workspace}\icon.ico") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaFS-Is-File "${___directory_workspace}\msi-banner.jpg") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }

        if ($(hestiaFS-Is-File "${___directory_workspace}\msi-dialog.jpg") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_MISSING}
        }


        # execute
        foreach ($___language in (-split $(hestiaI18N-Get-Languages-List))) {
                # validate arch
                $___arch = hestiaFS-Get-File $___directory_workspace
                switch ($___arch) {
                { $_ -in "amd64", "arm64", "i386", "arm" } {
                        # accepted
                } default {
                        # WiX4 does not support other arch aside the above
                        continue
                }}


                # validate LICENSE_[LANG}.rtf availability
                $___license = "${___directory_workspace}\share\doc\LICENSE_${___language}.rtf"
                if ($(hestiaFS-Is-File $___license) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___license = "${___directory_workspace}\share\doc\LICENSE.rtf"
                        if ($(hestiaFS-Is-File $___license) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                continue ## no available license file - skipping
                        }
                }


                # create wxs formula
                $___package = "${___sku}_${___language}_windows-${___arch}"
                $___wxs = "${___directory_workspace}\${___package}.wxs"
                $___msi = "${___directory_workspace}\${___package}.msi"
                if ($(hestiaFS-Is-File $___wxs) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                        ## user supplied - begin packaging and export
                        $___process = hestiaMSI-Compile $___wxs $___arch $___language
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## export packaged file
                        $___process = hestiaFS-Copy-File `
                                "${___directory_dest}\${___package}.msi" `
                                $___msi
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## move on to next language
                        continue
                }


                # create wxs header
                $___process = hestiaFS-Write-File $___wxs @"
<Wix xmlns="http://wixtoolset.org/schemas/v4/wxs"
        xmlns:ui="http://wixtoolset.org/schemas/v4/wxs/ui"
><Package
        Name="${___project_name}"
        Language='$(hestiaLOCALE-Get-LCID $___language)'
        Version='${___version}'
        Manufacturer='${___contact_name}'
        UpgradeCode='${___uuid}'
        InstallerVersion='${___installer_version}'
        Compressed='yes'
        Codepage='${___codepage}'
>
        <SummaryInformation Keywords='Installer' Description="${___project_name} (${___version})" />

        <!-- Declare icon file -->
        <Icon Id='Icon.exe' SourceFile='${___directory_workspace}\icon.ico' />

        <!-- Configure upgrade settings -->
        <MajorUpgrade AllowSameVersionUpgrades='yes'
                DowngradeErrorMessage="$(hestiaI18N-Translate-Already-Latest-Version $___language)"
        />

        <!-- Configure 'Add/Remove Programs' interfaces -->
        <Property Id='ARPPRODUCTICON' Value='Icon.exe' />
        <Property Id='ARPHELPLINK' Value='${___contact_website}' />

        <!-- Remove repair -->
        <Property Id='ARPNOREPAIR' Value='yes' Secure='yes' />

        <!-- Remove modify -->
        <Property Id='ARPNOMODIFY' Value='yes' Secure='yes' />

        <!-- Configure installer main sequences -->
        <CustomAction Id='Wix4SetARPINSTALLLOCATION_X86'
                Property='ARPINSTALLLOCATION'
                Value='[INSTALLDIR]' />
        <CustomAction Id='Wix4SetARPINSTALLLOCATION_X64'
                Property='ARPINSTALLLOCATION'
                Value='[INSTALLDIR]' />
        <CustomAction Id='Wix4SetARPINSTALLLOCATION_A64'
                Property='ARPINSTALLLOCATION'
                Value='[INSTALLDIR]' />
        <InstallExecuteSequence>
                <!-- Determine the install location after validated by the installer -->
                <Custom Action='Wix4SetARPINSTALLLOCATION_X86' After='InstallValidate'></Custom>
                <Custom Action='Wix4SetARPINSTALLLOCATION_X64' After='InstallValidate'></Custom>
                <Custom Action='Wix4SetARPINSTALLLOCATION_A64' After='InstallValidate'></Custom>
        </InstallExecuteSequence>

        <!-- Configure backward compatible multi-mediums (e.g. Floppy disks, CDs) -->
        <Media Id='1' Cabinet='media1.cab' EmbedCab='yes' />

        <!-- Configure installer launch condition -->
        <Launch Condition='$(hestiaMSI-Get-Program-Files-Directory $___arch)'
                Message="$(hestiaI18N-Translate-Only-Install-On-Windows $___language $___arch)"
        />

        <!-- Configure INSTALLDIR from CMD -->
        <CustomAction Id='Wix4SaveCMDINSTALLDIR_X86'
                Property='CMDLINE_INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='Wix4SetFromCMDINSTALLDIR_X86'
                Property='INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='Wix4SaveCMDINSTALLDIR_X64'
                Property='CMDLINE_INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='Wix4SetFromCMDINSTALLDIR_X64'
                Property='INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='Wix4SaveCMDINSTALLDIR_A64'
                Property='CMDLINE_INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='Wix4SetFromCMDINSTALLDIR_A64'
                Property='INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <InstallUISequence>
                <Custom Action='Wix4SaveCMDINSTALLDIR_X86'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_X86'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
                <Custom Action='Wix4SaveCMDINSTALLDIR_X64'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_X64'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
                <Custom Action='Wix4SaveCMDINSTALLDIR_A64'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_A64'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
        </InstallUISequence>
        <InstallExecuteSequence>
                <Custom Action='Wix4SaveCMDINSTALLDIR_X86'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_X86'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
                <Custom Action='Wix4SaveCMDINSTALLDIR_X64'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_X64'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
                <Custom Action='Wix4SaveCMDINSTALLDIR_A64'
                        Before='AppSearch'
                />
                <Custom Action='Wix4SetFromCMDINSTALLDIR_A64'
                        After='AppSearch'
                        Condition='CMDLINE_INSTALLDIR'
                />
        </InstallExecuteSequence>
        <Property Id='INSTALLDIR'>
                <RegistrySearch Id='DetermineInstallLocation'
                        Type='raw'
                        Root='HKLM'
                        Key='${___registry_key}'
                        Name='InstallLocation'
                />
        </Property>

        <!-- Define directory structures -->
        <StandardDirectory Id='$(hestiaMSI-Get-Program-Files-Directory $___arch)'
        ><Directory Id='${___project_scope}DIR' Name='${___project_scope}'
        ><Directory Id='INSTALLDIR' Name='${___sku}'>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # create bin/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\bin") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Directory Id='FolderBin' Name='bin'></Directory>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # create etc/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\etc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        ## append the opener
                        $___process = hestiaFS-Append-File $___wxs @"
                <Directory Id='FolderEtc' Name='etc'></Directory>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # create lib/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\lib") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Directory Id='FolderLib' Name='lib'></Directory>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # create share/ directory when available
                if (
                        ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\share\doc") -ne ${env:hestiaKERNEL_ERROR_OK})
                ) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Directory Id='FolderShare' Name='share'>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # create share/doc/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\share\doc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                        <Directory Id='FolderDoc' Name='doc'></Directory>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # close share/ directory when available
                if (
                        ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\share\doc") -ne ${env:hestiaKERNEL_ERROR_OK})
                ) {
                        $___process = hestiaFS-Append-File $___wxs @"
                </Directory>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }



                # close directory tree definitions
                $___process = hestiaFS-Append-File $___wxs @"
        </Directory></Directory></StandardDirectory>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }



                # assemble bin/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\bin") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        ## append the opener
                        $___process = hestiaFS-Append-File $___wxs @"
        <ComponentGroup Id='ProductBin' Directory='FolderBin'>
        <Component Id='ComponentBin' Guid='${___uuid_component_bin}'>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## loop through each file and register
                        foreach ($___file in (
                                Get-ChildItem -File -Recurse -Path "${___directory_workspace}\bin"
                        )) {
                                $___process = hestiaFS-Append-File $___wxs @"
                <File Id='Bin_$(hestiaCRYPTO-Create-Random-String "33")' Source='${___file}' />

"@
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }

                        ## append the closer
                        $___process = hestiaFS-Append-File $___wxs @"
        </Component>
        </ComponentGroup>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # assemble etc/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\etc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        ## append the opener
                        $___process = hestiaFS-Append-File $___wxs @"
        <ComponentGroup Id='ProductEtc' Directory='FolderEtc'>
        <Component Id='ComponentEtc' Guid='${___uuid_component_etc}'>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## loop through each file and register
                        foreach ($___file in (
                                Get-ChildItem -File -Recurse -Path "${___directory_workspace}\etc"
                        )) {
                                $___process = hestiaFS-Append-File $___wxs @"
                <File Id='Etc_$(hestiaCRYPTO-Create-Random-String "33")' Source='${___file}' />

"@
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }

                        ## append the closer
                        $___process = hestiaFS-Append-File $___wxs @"
        </Component>
        </ComponentGroup>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # assemble lib/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\lib") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        ## append the opener
                        $___process = hestiaFS-Append-File $___wxs @"
        <ComponentGroup Id='ProductLib' Directory='FolderLib'>
        <Component Id='ComponentLib' Guid='${___uuid_component_lib}'>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## loop through each file and register
                        foreach ($___file in (
                                Get-ChildItem -File -Recurse -Path "${___directory_workspace}\lib"
                        )) {
                                $___process = hestiaFS-Append-File $___wxs @"
                <File Id='Lib_$(hestiaCRYPTO-Create-Random-String "33")' Source='${___file}' />

"@
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }

                        ## append the closer
                        $___process = hestiaFS-Append-File $___wxs @"
        </Component>
        </ComponentGroup>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # assemble share/doc/ directory when available
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\share\doc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        ## append the opener
                        $___process = hestiaFS-Append-File $___wxs @"
        <ComponentGroup Id='ProductDoc' Directory='FolderDoc'>
        <Component Id='ComponentDoc' Guid='${___uuid_component_docs}'>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }

                        ## loop through each file and register
                        foreach ($___file in (
                                Get-ChildItem -File `
                                        -Recurse `
                                        -Path "${___directory_workspace}\share\doc"
                        )) {
                                $___process = hestiaFS-Append-File $___wxs @"
                <File Id='Doc_$(hestiaCRYPTO-Create-Random-String "33")' Source='${___file}' />

"@
                                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                                }
                        }

                        ## append the closer
                        $___process = hestiaFS-Append-File $___wxs @"
        </Component>
        </ComponentGroup>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # create registry component
                $___process = hestiaFS-Append-File $___wxs @"
        <Component Id='ComponentRegistries' Guid='${___uuid_component_registries}'>
        <RegistryKey Root='HKLM' Key='${___registry_key}'>
                <!-- IMPORTANT NOTE: DO NOT REMOVE this default entry -->
                <RegistryValue
                        Name='InstallLocation'
                        Value='[INSTALLDIR]'
                        Type='string'
                        KeyPath='yes'
                />

                <!-- IMPORTANT NOTE:                                 -->
                <!--     DO NOT use default registries here.         -->
                <!--     They are removable by uninstall/upgrade.    -->
                <!--     Use %APPDATA% and etc instead.              -->
        </RegistryKey>
        </Component>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # define features tree
                $___process = hestiaFS-Append-File $___wxs @"
        <Feature Id='FeaturesAll'
                Title='$(hestiaI18N-Translate-All-Components-Title $___language)'
                Description='$(hestiaI18N-Translate-All-Components-Description $___language)'
                Level='1'
                Display='expand'
                ConfigurableDirectory='INSTALLDIR'
        >
                <Feature Id='FeaturesMain'
                        Title="$(hestiaI18N-Translate-Main-Component-Title $___language)"
                        Description="$(hestiaI18N-Translate-Main-Component-Description $___language)"
                        Level='1'
                >
                        <ComponentRef Id='ComponentRegistries' />
                </Feature>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # define bin/ feature
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\bin") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Feature Id='FeaturesBin'
                        Title="$(hestiaI18N-Translate-Bin-Component-Title $___language)"
                        Description="$(hestiaI18N-Translate-Bin-Component-Description $___language)"
                        Level='1'
                        AllowAbsent='yes'
                >
                        <ComponentRef Id='ComponentBin' />
                </Feature>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # define etc/ feature
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\etc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Feature Id='FeaturesEtc'
                        Title="$(hestiaI18N-Translate-Etc-Component-Title $___language)"
                        Description="$(hestiaI18N-Translate-Etc-Component-Description $___language)"
                        Level='1'
                        AllowAbsent='yes'
                >
                        <ComponentRef Id='ComponentEtc' />
                </Feature>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # define lib/ feature
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\lib") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Feature Id='FeaturesLib'
                        Title="$(hestiaI18N-Translate-Lib-Component-Title $___language)"
                        Description="$(hestiaI18N-Translate-Lib-Component-Description $___language)"
                        Level='1'
                        AllowAbsent='yes'
                >
                        <ComponentRef Id='ComponentLib' />
                </Feature>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # define share/doc/ feature
                if ($(hestiaFS-Is-Directory-Empty "${___directory_workspace}\share\doc") -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        $___process = hestiaFS-Append-File $___wxs @"
                <Feature Id='FeaturesDoc'
                        Title="$(hestiaI18N-Translate-Doc-Component-Title $___language)"
                        Description="$(hestiaI18N-Translate-Doc-Component-Description $___language)"
                        Level='1'
                        AllowAbsent='yes'
                >
                        <ComponentRef Id='ComponentDoc' />
                </Feature>

"@
                        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                        }
                }


                # conclude feature tree
                $___process = hestiaFS-Append-File "${___directory_workspace}\${___package}.wxs" @"
        </Feature>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # define standard UI
                $___process = hestiaFS-Append-File $___wxs @"
        <!-- UI Customization -->
        <ui:WixUI Id='WixUI_FeatureTree' InstallDirectory='INSTALLDIR' />
        <WixVariable Id='WixUIBannerBmp' Value="${___directory_workspace}\msi-banner.jpg" />
        <WixVariable Id='WixUIDialogBmp' Value="${___directory_workspace}\msi-dialog.jpg" />
        <WixVariable Id="WixUILicenseRtf" Value="${___license}" />

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # conclude wxs creation
                $___process = hestiaFS-Append-File $___wxs @"
</Package></Wix>

"@
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # package into msi
                $___process = hestiaMSI-Compile $___wxs $___arch $___language $___dotnet_directory
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }


                # export packaged file
                $___process = hestiaFS-Copy-File `
                        "${___directory_dest}\${___package}.msi" `
                        $___msi
                if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                        return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
                }
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
. "${LIBS_HESTIA}/hestiaCRYPTO/Create_Random_String.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaI18N/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaLOCALE/Get_LCID.sh.ps1"
. "${LIBS_HESTIA}/hestiaMSI/Compile.sh.ps1"
. "${LIBS_HESTIA}/hestiaMSI/Is_Available.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"




hestiaMSI_Package() {
        #___directory_dest="$1"
        #___directory_workspace="$2"
        #___sku="$3"
        #___version="$4"
        #___uuid="$5"
        #___project_scope="$6"
        #___project_name="$7"
        #___contact_name="$8"
        #___contact_website="$9"
        #___installer_version="${10}"
        #___installer_scope="${11}"
        #___registry_key="${12}"
        #___uuid_component_bin="${13}"
        #___uuid_component_etc="${14}"
        #___uuid_component_lib="${15}"
        #___uuid_component_docs="${16}"
        #___uuid_component_registries="${17}"
        #___codepage="${18}"
        #___dotnet_directory="${19}"


        # validate input
        if [ $(hestiaMSI_Is_Available "${19}") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$4") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$5") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$7") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$8") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "$9") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${10}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${11}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${12}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${13}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${14}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${15}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${16}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${17}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSTRING_Is_Empty "${18}") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaFS_Is_Directory "$1") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_ENTITY_INVALID
        fi

        if [ $(hestiaFS_Is_Directory "$2") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_INVALID
        fi

        if [ $(hestiaFS_Is_File "${2}/icon.ico") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaFS_Is_File "${2}/msi-banner.jpg") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi

        if [ $(hestiaFS_Is_File "${2}/msi-dialog.jpg") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_MISSING
        fi


        # execute
        ___old_IFS="$IFS"
        while IFS="" read -r ___language || [ -n "$___language" ]; do
                # validate arch
                ___arch="$(hestiaFS_Get_File "$2")"
                case "$___arch" in
                amd64)
                        ;;
                *)
                        # msitools does not support other arch aside amd64
                        continue
                        ;;
                esac


                # create wxs formula
                ___package="${3}_${___language}_windows-${___arch}"
                if [ $(hestiaFS_Is_File "${2}/${___package}.wxs") -eq $hestiaKERNEL_ERROR_OK ]; then
                        ## user supplied - begin packaging and export
                        hestiaMSI_Compile "${2}/${___package}.wxs" "$___arch" "$___language"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## export packaged file
                        hestiaFS_Copy_File "${1}/${___package}.msi" "${2}/${___package}.msi"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## move on to next language
                        continue
                fi


                # create wxs header
                hestiaFS_Write_File "${2}/${___package}.wxs" "\
<?xml version='1.0' encoding='UTF-8'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
<Product Id='*'
        Name=\"${7}\"
        Language='$(hestiaLOCALE_Get_LCID "$___language")'
        Version='${4}'
        UpgradeCode='${5}'
        Manufacturer='${8}'
>
        <Package Id='*'
                Keywords='Installer'
                Description=\"${7} (${4})\"
                InstallerVersion='${10}'
                Compressed='yes'
                InstallScope='${11}'
                Comments=\"(C) ${8}\"
        />

        <!-- Declare icon file -->
        <Icon Id='Icon.exe' SourceFile='${2}/icon.ico' />

        <!-- Configure upgrade settings -->
        <MajorUpgrade AllowSameVersionUpgrades='yes'
                DowngradeErrorMessage=\"$(hestiaI18N_Translate_Already_Latest_Version \
                                                "$___language")\"
        />

        <!-- Configure 'Add/Remove Programs' interfaces -->
        <Property Id='ARPPRODUCTICON' Value='Icon.exe' />
        <Property Id='ARPHELPLINK' Value='${9}' />

        <!-- Remove repair -->
        <Property Id='ARPNOREPAIR' Value='yes' Secure='yes' />

        <!-- Remove modify -->
        <Property Id='ARPNOMODIFY' Value='yes' Secure='yes' />

        <!-- Configure installer main sequences -->
        <CustomAction Id='SetARPINSTALLLOCATION'
                Property='ARPINSTALLLOCATION'
                Value='[ARPINSTALLLOCATION]' />
        <InstallExecuteSequence>
                <!-- Determine the install location after validated by the installer -->
                <Custom Action='SetARPINSTALLLOCATION' After='InstallValidate'></Custom>
        </InstallExecuteSequence>

        <!-- Configure backward compatible multi-mediums (e.g. Floppy disks, CDs) -->
        <Media Id='1' Cabinet='media1.cab' EmbedCab='yes' />

        <!-- Configure INSTALLDIR from CMD -->
        <CustomAction Id='SaveCMDINSTALLDIR'
                Property='CMDLINE_INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <CustomAction Id='SetFromCMDINSTALLDIR'
                Property='INSTALLDIR'
                Value='[INSTALLDIR]'
                Execute='firstSequence'
        />
        <InstallUISequence>
                <Custom Action='SaveCMDINSTALLDIR' Before='AppSearch' />
                <Custom Action='SetFromCMDINSTALLDIR' After='AppSearch'>CMDLINE_INSTALLDIR</Custom>
        </InstallUISequence>
        <InstallExecuteSequence>
                <Custom Action='SaveCMDINSTALLDIR' Before='AppSearch' />
                <Custom Action='SetFromCMDINSTALLDIR' After='AppSearch'>CMDLINE_INSTALLDIR</Custom>
        </InstallExecuteSequence>
        <Property Id='INSTALLDIR'>
                <RegistrySearch Id='DetermineInstallLocation'
                        Type='raw'
                        Root='HKLM'
                        Key='${12}'
                        Name='InstallLocation'
                />
        </Property>

        <!-- Define directories structure -->
        <Directory Id='TARGETDIR' Name='SourceDir'>
        <Directory Id='$(hestiaMSI_Get_Program_Files_Directory "$___arch")'>
        <Directory Id='${6}DIR' Name='${6}'>
        <Directory Id='INSTALLDIR' Name='${3}'>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # create bin/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/bin") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Directory Id='FolderBin' Name='bin'>
                        <Component Id='ComponentBin' Guid='${13}'>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## loop through each file and register
                        while IFS= read -r ___file || [ -n "$___file" ]; do
                                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "${2}/${___package}.wxs" "\
                                <File Id='Bin_$(hestiaCRYPTO_Create_Random_String "33")'
                                        Source='${___file}' />
"
                                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done <<EOF
$(find "${2}/bin" -type f 2> /dev/null)
EOF

                        ## append the closer
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                        </Component>
                </Directory>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # create etc/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/etc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Directory Id='FolderEtc' Name='etc'>
                        <Component Id='ComponentEtc' Guid='${14}'>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## loop through each file and register
                        while IFS= read -r ___file || [ -n "$___file" ]; do
                                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "${2}/${___package}.wxs" "\
                                <File Id='Etc_$(hestiaCRYPTO_Create_Random_String "33")'
                                        Source='${___file}' />
"
                                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done <<EOF
$(find "${2}/etc" -type f 2> /dev/null)
EOF

                        ## append the closer
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                        </Component>
                </Directory>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # create lib/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/lib") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Directory Id='FolderLib' Name='lib'>
                        <Component Id='ComponentLib' Guid='${15}'>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## loop through each file and register
                        while IFS= read -r ___file || [ -n "$___file" ]; do
                                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "${2}/${___package}.wxs" "\
                                <File Id='Lib_$(hestiaCRYPTO_Create_Random_String "33")'
                                        Source='${___file}' />
"
                                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done <<EOF
$(find "${2}/lib" -type f 2> /dev/null)
EOF

                        ## append the closer
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                        </Component>
                </Directory>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # create share/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/share/doc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Directory Id='FolderShare' Name='share'>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # create share/doc/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/share/doc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                        <Directory Id='FolderDoc' Name='doc'>
                                <Component Id='ComponentDoc' Guid='${16}'>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi

                        ## loop through each file and register
                        while IFS= read -r ___file || [ -n "$___file" ]; do
                                if [ $(hestiaFS_Is_File "$___file") -ne $hestiaKERNEL_ERROR_OK ]; then
                                        continue
                                fi

                                hestiaFS_Append_File "${2}/${___package}.wxs" "\
                                        <File Id='Doc_$(hestiaCRYPTO_Create_Random_String "33")'
                                                Source='${___file}' />
"
                                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                        return $hestiaKERNEL_ERROR_BAD_EXEC
                                fi
                        done <<EOF
$(find "${2}/share/doc" -type f 2> /dev/null)
EOF

                        ## append the closer
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                                </Component>
                        </Directory>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # close share/ directory when available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/share/doc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        ## append the opener
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                </Directory>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # close directory section
                hestiaFS_Append_File "${2}/${___package}.wxs" "\
        </Directory></Directory></Directory>
                <Component Id='ComponentRegistries' Guid='${17}'>
                        <RegistryKey Root='HKLM' Key='${12}'>
                                <!-- IMPORTANT NOTE: DO NOT REMOVE this default entry -->
                                <RegistryValue
                                        Name='InstallLocation'
                                        Value='[INSTALLDIR]'
                                        Type='string'
                                        KeyPath='yes'
                                />

                                <!-- IMPORTANT NOTE:                                 -->
                                <!--     DO NOT use default registries here.         -->
                                <!--     They are removable by uninstall/upgrade.    -->
                                <!--     Use %APPDATA% and etc instead.              -->
                        </RegistryKey>
                </Component>
        </Directory>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # define features tree
                hestiaFS_Append_File "${2}/${___package}.wxs" "\
        <Feature Id='FeaturesAll'
                Title=\"$(hestiaI18N_Translate_All_Components_Title "$___language")\"
                Description=\"$(hestiaI18N_Translate_All_Components_Description "$___language")\"
                Level='1'
                Display='expand'
                ConfigurableDirectory='INSTALLDIR'
        >
                <Feature Id='FeaturesMain'
                        Title=\"$(hestiaI18N_Translate_Main_Component_Title "$___language")\"
                        Description=\"$(hestiaI18N_Translate_Main_Component_Description \
                                        "$___language")\"
                        Level='1'
                >
                        <ComponentRef Id='ComponentRegistries' />
                </Feature>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # append bin/ feature if available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/bin") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Feature Id='FeaturesBin'
                        Title=\"$(hestiaI18N_Translate_Bin_Component_Title "$___language")\"
                        Description=\"$(hestiaI18N_Translate_Bin_Component_Description \
                                        "$___language")\"
                        Level='1'
                >
                        <ComponentRef Id='ComponentBin' />
                </Feature>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # append etc/ feature if available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/etc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Feature Id='FeaturesEtc'
                        Title=\"$(hestiaI18N_Translate_Etc_Component_Title "$___language")\"
                        Description=\"$(hestiaI18N_Translate_Etc_Component_Description \
                                        "$___language")\"
                        Level='1'
                >
                        <ComponentRef Id='ComponentEtc' />
                </Feature>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # append lib/ feature if available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/lib") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Feature Id='FeaturesLib'
                        Title=\"$(hestiaI18N_Translate_Lib_Component_Title "$___language")\"
                        Description=\"$(hestiaI18N_Translate_Lib_Component_Description \
                                                "$___language")\"
                        Level='1'
                >
                        <ComponentRef Id='ComponentLib' />
                </Feature>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # append share/doc/ feature if available
                if [ $(hestiaFS_Is_Directory_Empty "${2}/share/doc") -ne $hestiaKERNEL_ERROR_OK ]; then
                        hestiaFS_Append_File "${2}/${___package}.wxs" "\
                <Feature Id='FeaturesDoc'
                        Title=\"$(hestiaI18N_Translate_Doc_Component_Title "$___language")\"
                        Description=\"$(hestiaI18N_Translate_Doc_Component_Description \
                                                "$___language")\"
                        Level='1'
                >
                        <ComponentRef Id='ComponentDoc' />
                </Feature>
"
                        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                                return $hestiaKERNEL_ERROR_BAD_EXEC
                        fi
                fi


                # close features tree
                hestiaFS_Append_File "${2}/${___package}.wxs" "\
        </Feature>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # conclude wxs creation
                hestiaFS_Append_File "${2}/${___package}.wxs" "\
</Product></Wix>
"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # package into msi
                hestiaMSI_Compile "${2}/${___package}.wxs" "$___arch" "$___language"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi


                # export packaged file
                if [ $(hestiaFS_Is_File "${2}/${___package}.msi") -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi

                hestiaFS_Copy_File "${1}/${___package}.msi" "${2}/${___package}.msi"
                if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                        return $hestiaKERNEL_ERROR_BAD_EXEC
                fi
        done <<EOF
$(hestiaI18N_Get_Languages_List)
EOF


        # report status
        return $hestiaKERNEL_ERROR_OK
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
