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
. "${env:LIBS_HESTIA}\hestiaSTRING\To_Lowercase.sh.ps1"




function hestiaMSI-Get-Culture {
        param (
                [string]$___lang
        )


        # execute
        # IMPORTANT NOTICE: this is a temporary function for handling WiX's
        #                 localization bug. More info:
        #                 (1) https://github.com/wixtoolset/issues/issues/7896
        #                 (2) https://wixtoolset.org/docs/tools/wixext/wixui/#translated-strings
        switch (hestiaSTRING-To-Lowercase $___lang) {
        "ar" {
                return "ar-SA"
        } "bg" {
                return "bg-BG"
        } "ca" {
                return "ca-ES"
        } "cs" {
                return "cs-CZ"
        } "da" {
                return "da-DK"
        } "de" {
                return "de-DE"
        } "el" {
                return "el-GR"
        } "en" {
                return "en-US"
        } "es" {
                return "es-ES"
        } "et" {
                return "et-EE"
        } "fi" {
                return "fi-FI"
        } "fr" {
                return "fr-FR"
        } "he" {
                return "he-IL"
        } "hi" {
                return "hi-IN"
        } "hr" {
                return "hr-HR"
        } "hu" {
                return "hu-HU"
        } "it" {
                return "it-IT"
        } "ja" {
                return "ja-JP"
        } "kk" {
                return "kk-KZ"
        } "ko" {
                return "ko-KR"
        } "lt" {
                return "lt-LT"
        } "lv" {
                return "lv-LV"
        } "nb" {
                return "nb-NO"
        } "nl" {
                return "nl-NL"
        } "pl" {
                return "pl-PL"
        } "pt" {
                return "pt-PT"
        } "ro" {
                return "ro-RO"
        } "ru" {
                return "ru-RU"
        } "sk" {
                return "sk-SK"
        } "sl" {
                return "sl-SI"
        } "sq" {
                return "sq-AL"
        } "sr" {
                return "sr-Latn-RS"
        } "sv" {
                return "sv-SE"
        } "th" {
                return "th-TH"
        } "tr" {
                return "tr-TR"
        } "uk" {
                return "uk-UA"
        } "zh-hant" {
                return "zh-TW"
        } { $_ -in "zh", "zh-hans" } {
                return "zh-CN"
        } default {
                return ""
        }}
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
. "${LIBS_HESTIA}/hestiaSTRING/To_Lowercase.sh.ps1"




hestiaMSI_Get_Culture() {
        #___lang="$1"


        # execute
        # IMPORTANT NOTICE: this is a temporary function for handling WiX's
        #                 localization bug. More info:
        #                 (1) https://github.com/wixtoolset/issues/issues/7896
        #                 (2) https://wixtoolset.org/docs/tools/wixext/wixui/#translated-strings
        case "$(hestiaSTRING_To_Lowercase "$1")" in
        ar)
                printf -- "%s" "ar-SA"
                ;;
        bg)
                printf -- "%s" "bg-BG"
                ;;
        ca)
                printf -- "%s" "ca-ES"
                ;;
        cs)
                printf -- "%s" "cs-CZ"
                ;;
        da)
                printf -- "%s" "da-DK"
                ;;
        de)
                printf -- "%s" "de-DE"
                ;;
        el)
                printf -- "%s" "el-GR"
                ;;
        en)
                printf -- "%s" "en-US"
                ;;
        es)
                printf -- "%s" "es-ES"
                ;;
        et)
                printf -- "%s" "et-EE"
                ;;
        fi)
                printf -- "%s" "fi-FI"
                ;;
        fr)
                printf -- "%s" "fr-FR"
                ;;
        he)
                printf -- "%s" "he-IL"
                ;;
        hi)
                printf -- "%s" "hi-IN"
                ;;
        hr)
                printf -- "%s" "hr-HR"
                ;;
        hu)
                printf -- "%s" "hu-HU"
                ;;
        it)
                printf -- "%s" "it-IT"
                ;;
        ja)
                printf -- "%s" "ja-JP"
                ;;
        kk)
                printf -- "%s" "kk-KZ"
                ;;
        ko)
                printf -- "%s" "ko-KR"
                ;;
        lt)
                printf -- "%s" "lt-LT"
                ;;
        lv)
                printf -- "%s" "lv-LV"
                ;;
        nb)
                printf -- "%s" "nb-NO"
                ;;
        nl)
                printf -- "%s" "nl-NL"
                ;;
        pl)
                printf -- "%s" "pl-PL"
                ;;
        pt)
                printf -- "%s" "pt-PT"
                ;;
        ro)
                printf -- "%s" "ro-RO"
                ;;
        ru)
                printf -- "%s" "ru-RU"
                ;;
        sk)
                printf -- "%s" "sk-SK"
                ;;
        sl)
                printf -- "%s" "sl-SI"
                ;;
        sq)
                printf -- "%s" "sq-AL"
                ;;
        sr)
                printf -- "%s" "sr-Latn-RS"
                ;;
        sv)
                printf -- "%s" "sv-SE"
                ;;
        th)
                printf -- "%s" "th-TH"
                ;;
        tr)
                printf -- "%s" "tr-TR"
                ;;
        uk)
                printf -- "%s" "uk-UA"
                ;;
        zh-hant)
                printf -- "%s" "zh-TW"
                ;;
        zh|zh-hans)
                printf -- "%s" "zh-CN"
                ;;
        *)
                printf -- ""
                ;;
        esac
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
