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
. "${env:LIBS_HESTIA}\hestiaSHASUM\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaSTRING\Vanilla.sh.ps1"
. "${env:LIBS_HESTIA}\hestiaTAR\Pack.sh.ps1"




function hestiaHOMEBREW-Package {
        param (
                [string]$___formula,
                [string]$___archive_name,
                [string]$___workspace,
                [string]$___sku,
                [string]$___description,
                [string]$___website,
                [string]$___license,
                [string]$___base_url
        )


        # validate input
        if (
                ($(hestiaSTRING-Is-Empty $___formula) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___archive_name) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___workspace) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___sku) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___description) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___website) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___license) -eq ${env:hestiaKERNEL_ERROR_OK}) -or
                ($(hestiaSTRING-Is-Empty $___base_url) -eq ${env:hestiaKERNEL_ERROR_OK})
        ) {
                return ${env:hestiaKERNEL_ERROR_DATA_EMPTY}
        }

        if ($(hestiaSHASUM-Is-Available) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_NOT_POSSIBLE}
        }

        if ($(hestiaFS-Is-Directory $___workspace) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY}
        }

        $___export_directory = hestiaFS-Get-Directory $___formula
        if ($___export_directory -eq $___formula) {
                return ${env:hestiaKERNEL_ERROR_DATA_BAD}
        }
        $null = hestiaFS-Create-Directory $___export_directory


        # execute
        ## generate the init script
        $___process = hestiaFS-Write-File "${___workspace}/init.sh" @"
#!/bin/sh
OS_Get_Arch() {
        ___output="`$(uname -m)"
        ___output="`$(printf -- "%b" "`$___output" | tr '[:upper:]' '[:lower:]')"
        case "`$___output" in
        i686-64|ia64)
                export ___output='ia64' # Intel Itanium.
                ;;
        386|i386|486|i486|586|i586|686|i686)
                export ___output='i386'
                ;;
        x86_64|x64)
                export ___output='amd64'
                ;;
        sun4u)
                export ___output='sparc'
                ;;
        'power macintosh')
                export ___output='powerpc'
                ;;
        ip*)
                export ___output='mips'
                ;;
        *)
                ;;
        esac


        # report status
        printf -- "%b" "`$___output"
        return 0
}


OS_Get() {
        # execute
        ___output="`$(uname)"
        ___output="`$(printf -- "%b" "`${___output}" | tr '[:upper:]' '[:lower:]')"
        case "`$___output" in
        windows*|ms-dos*)
                ___output='windows'
                ;;
        cygwin*|mingw*|mingw32*|msys*)
                ___output='windows'
                ;;
        *freebsd)
                ___output='freebsd'
                ;;
        dragonfly*)
                ___output='dragonfly'
                ;;
        *)
                ;;
        esac


        # report status
        printf -- "%b" "`$___output"
        return 0
}


main() {
        host_os="`$(OS_Get)"
        host_arch="`$(OS_Get_Arch)"
        for ___file in './bin/'*; do
                if [ ! -e "`$___file" ]; then
                        continue
                fi

                ___system="`${___file##*/}"
                ___system="`${___system%%.*}"
                ___system="`${___system##*_}"
                ___os="`${___system%%-*}"
                ___arch="`${___system##*-}"

                case "`$___os" in
                any|"`$host_os")
                        ;;
                *)
                        rm -f "`$___file" &> /dev/null
                        continue
                        ;;
                esac

                case "`$___arch" in
                any|"`$host_arch")
                        mv "`$___file" "`${___file%%_*}"
                        ;;
                *)
                        rm -f "`$___file" &> /dev/null
                        ;;
                esac
        done

        return 0
}
main `$*
return `$?

"@
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        ## seal the workspace
        $___process = hestiaTAR-Pack "${___export_directory}\${___archive_name}" $___workspace "xz"
        if ($___process -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        ## create the formula
        $___shasum = hestiaSHASUM-Create-From-File "${___export_directory}\${___archive_name}" "256"
        if ($(hestiaSTRING-Is-Empty $___shasum) -eq ${env:hestiaKERNEL_ERROR_OK}) {
                return ${env:hestiaKERNEL_ERROR_BAD_EXEC}
        }


        $null = hestiaFS-Create-Directory "$(hestiaFS-Get-Directory $___formula)"
        $___process = hestiaFS-Write-File $___formula @"
class $(hestiaSTRING-To-Titlecase "${___sku}") < Formula
  desc "${___description}"
  homepage "${___website}"
  license "${___license}"
  url "${___base_url}/${___archive_name}"
  sha256 "${___shasum}"

  def install
    if File.file?('init.sh.ps1')
      chmod 755, './init.sh.ps1'
      system './init.sh.ps1'
    else
      chmod 755, './init.sh'
      system './init.sh'
    end

    if File.directory?('bin')
      Dir.foreach('bin') do |filename|
        next if filename == '.' or filename == '..'
        chmod 0755, filename
        libexec.install 'bin/' + filename
        bin.install_symlink 'libexec/bin/' + filename => filename
      end
    end

    if File.directory?('lib')
      Dir.foreach('lib') do |filename|
        next if filename == '.' or filename == '..'
        chmod 0544, filename
        libexec.install 'lib/' + filename
        lib.install_symlink 'libexec/lib/' + filename => filename
      end
    end
  end

  test do
    if File.file?('init.sh.ps1')
      assert_predicate 'init.sh.ps1', :exist?
    else
      assert_predicate 'init.sh', :exist?
    end
  end
end

"@
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
. "${LIBS_HESTIA}/hestiaKERNEL/Error_Codes.sh.ps1"
. "${LIBS_HESTIA}/hestiaFS/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSHASUM/Vanilla.sh.ps1"
. "${LIBS_HESTIA}/hestiaSTRING/Is_Empty.sh.ps1"
. "${LIBS_HESTIA}/hestiaTAR/Pack.sh.ps1"




hestiaHOMEBREW_Package() {
        #___formula="$1"
        #___archive_name="$2"
        #___workspace="$3"
        #___sku="$4"
        #___description="$5"
        #___website="$6"
        #___license="$7"
        #___base_url="$8"


        # validate input
        if [ $(hestiaSTRING_Is_Empty "$1") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$2") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$3") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$4") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$5") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$6") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$7") -eq $hestiaKERNEL_ERROR_OK ] ||
                [ $(hestiaSTRING_Is_Empty "$8") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_EMPTY
        fi

        if [ $(hestiaSHASUM_Is_Available) -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_NOT_POSSIBLE
        fi

        if [ $(hestiaFS_Is_Directory "$3") -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_DATA_IS_NOT_DIRECTORY
        fi

        ___export_directory="$(hestiaFS_Get_Directory "$1")"
        if [ "$___export_directory" = "$1" ]; then
                return $hestiaKERNEL_ERROR_DATA_BAD
        fi
        hestiaFS_Create_Directory "$___export_directory"


        # execute
        ## generate the init script
        hestiaFS_Write_File "${3}/init.sh" "\
#!/bin/sh
OS_Get_Arch() {
        ___output=\"\$(uname -m)\"
        ___output=\"\$(printf -- \"%b\" \"\$___output\" | tr '[:upper:]' '[:lower:]')\"
        case \"\$___output\" in
        i686-64|ia64)
                export ___output='ia64' # Intel Itanium.
                ;;
        386|i386|486|i486|586|i586|686|i686)
                export ___output='i386'
                ;;
        x86_64|x64)
                export ___output='amd64'
                ;;
        sun4u)
                export ___output='sparc'
                ;;
        'power macintosh')
                export ___output='powerpc'
                ;;
        ip*)
                export ___output='mips'
                ;;
        *)
                ;;
        esac


        # report status
        printf -- \"%b\" \"\$___output\"
        return 0
}


OS_Get() {
        # execute
        ___output=\"\$(uname)\"
        ___output=\"\$(printf -- \"%b\" \"\${___output}\" | tr '[:upper:]' '[:lower:]')\"
        case \"\$___output\" in
        windows*|ms-dos*)
                ___output='windows'
                ;;
        cygwin*|mingw*|mingw32*|msys*)
                ___output='windows'
                ;;
        *freebsd)
                ___output='freebsd'
                ;;
        dragonfly*)
                ___output='dragonfly'
                ;;
        *)
                ;;
        esac


        # report status
        printf -- \"%b\" \"\$___output\"
        return 0
}


main() {
        host_os=\"\$(OS_Get)\"
        host_arch=\"\$(OS_Get_Arch)\"
        for ___file in './bin/'*; do
                if [ ! -e \"\$___file\" ]; then
                        continue
                fi

                ___system=\"\${___file##*/}\"
                ___system=\"\${___system%%.*}\"
                ___system=\"\${___system##*_}\"
                ___os=\"\${___system%%-*}\"
                ___arch=\"\${___system##*-}\"

                case \"\$___os\" in
                any|\"\$host_os\")
                        ;;
                *)
                        rm -f \"\$___file\" &> /dev/null
                        continue
                        ;;
                esac

                case \"\$___arch\" in
                any|\"\$host_arch\")
                        mv \"\$___file\" \"\${___file%%_*}\"
                        ;;
                *)
                        rm -f \"\$___file\" &> /dev/null
                        ;;
                esac
        done

        return 0
}
main \$*
return \$?
"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        ## seal the workspace
        hestiaTAR_Pack "${___export_directory}/${2}" "$3" "xz"
        if [ $? -ne $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        ## create the formula
        ___shasum="$(hestiaSHASUM_Create_From_File "${___export_directory}/${2}" "256")"
        if [ $(hestiaSTRING_Is_Empty "$___shasum") -eq $hestiaKERNEL_ERROR_OK ]; then
                return $hestiaKERNEL_ERROR_BAD_EXEC
        fi


        hestiaFS_Create_Directory "$(hestiaFS_Get_Directory "$1")"
        hestiaFS_Write_File "$1" "\
class $(hestiaSTRING_To_Titlecase "$4") < Formula
  desc \"${5}\"
  homepage \"${6}\"
  license \"${7}\"
  url \"${8}/${2}\"
  sha256 \"${___shasum}\"

  def install
    if File.file?('init.sh.ps1')
      chmod 755, './init.sh.ps1'
      system './init.sh.ps1'
    else
      chmod 755, './init.sh'
      system './init.sh'
    end

    if File.directory?('bin')
      Dir.foreach('bin') do |filename|
        next if filename == '.' or filename == '..'
        chmod 0755, filename
        libexec.install 'bin/' + filename
        bin.install_symlink 'libexec/bin/' + filename => filename
      end
    end

    if File.directory?('lib')
      Dir.foreach('lib') do |filename|
        next if filename == '.' or filename == '..'
        chmod 0544, filename
        libexec.install 'lib/' + filename
        lib.install_symlink 'libexec/lib/' + filename => filename
      end
    end
  end

  test do
    if File.file?('init.sh.ps1')
      assert_predicate 'init.sh.ps1', :exist?
    else
      assert_predicate 'init.sh', :exist?
    end
  end
end
"
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
