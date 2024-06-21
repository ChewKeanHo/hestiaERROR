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
function hestiaKERNEL-Run-Parallel-Sentinel {
        param(
                [string]$____parallel_command,
                [string]$____parallel_control_directory,
                [string]$____parallel_available
        )


        # validate input
        if ([string]::IsNullOrEmpty($____parallel_command)) {
                return 61 # data is empty
        }

        if ([string]::IsNullOrEmpty($____parallel_control_directory)) {
                return 87 # entity is empty
        }

        if (-not (Test-Path -PathType Container -Path $____parallel_control_directory)) {
                return 104 # entity is not directory
        }

        $____parallel_control = "${____parallel_control_directory}\control.txt"
        if (-not (Test-Path -PathType Leaf -Path $____parallel_control)) {
                return 88 # entity is invalid
        }

        try {
                if (
                        ([string]::IsNullOrEmpty($____parallel_available)) -or
                        ($____parallel_available -le 0)
                ) {
                        $____parallel_available = [System.Environment]::ProcessorCount
                        if ($____parallel_available -le 0) {
                                $____parallel_available = 1
                        }
                }
        } catch {
                $____parallel_available = [System.Environment]::ProcessorCount
                if ($____parallel_available -le 0) {
                        $____parallel_available = 1
                }
        }


        # execute
        $____parallel_flags = "${____parallel_control_directory}\flags"
        $____parallel_total = 0


        # scan total tasks
        foreach ($____line in (Get-Content $____parallel_control)) {
                $____parallel_total += 1
        }


        # bail early if no task is available
        if ($____parallel_total -le 0) {
                return 0 # ok
        }


        # run in singular when only 1 task is required
        if (
                ($____parallel_available -le 1) -or
                ($____parallel_total -eq 1)
        ) {
                ${function:SYNC-Run} = $___parallel_command
                foreach ($____line in (Get-Content $____parallel_control)) {
                        $____process = SYNC-Run $____line
                        if ($____process -ne 0) {
                                return 1 # bad exec
                        }


                        # report status
                        return 0 # ok
                }
        }


        # run in parallel
        $____jobs = @()
        $____line_number = 0
        foreach ($____line in (Get-Content $____parallel_control)) {
                $____line_number += 1

                $____jobs += Start-ThreadJob -ScriptBlock {
                        $____parallel_flag = "${using:____parallel_flags}\l${using:____line_number}"


                        # secure parallel working lock
                        $null = New-Item -ItemType Directory `
                                        -Force `
                                        -Path "${____parallel_flag}_working"


                        # initiate parallel execution
                        ${function:SYNC-Run} = ${using:____parallel_command}
                        $____process = SYNC-Run ${using:____line}

                        try {
                                $null = Remove-Item `
                                                -Recurse `
                                                -Force `
                                                -Path "${____parallel_flag}_working"
                        } catch {
                                $____process = 1
                        }

                        switch ($____process) {
                        0 {
                                $null = New-Item -ItemType Directory `
                                                -Force `
                                                -Path "${____parallel_flag}_done"
                                return 0 # ok
                        } default {
                                $null = New-Item -ItemType Directory `
                                                -Force `
                                                -Path "${____parallel_flag}_error"
                                return 1 # bad exec
                        }}
                }
        }

        $null = Wait-Job -Job $____jobs
        foreach ($____job in $____jobs) {
                $____process = Receive-Job -Job $____job
                if ($____process -ne 0) {
                        return 1 # bad exec
                }
        }


        # report status
        return 0 # ok
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
hestiaKERNEL_Run_Parallel_Sentinel() {
        ____parallel_command="$1"
        ____parallel_control_directory="$2"
        ____parallel_available="$3"


        # validate input
        if [ -z "$____parallel_command" ]; then
                return 61 # data is empty
        fi

        if [ -z "$____parallel_control_directory" ]; then
                return 87 # entity is empty
        fi

        if [ ! -d "$____parallel_control_directory" ]; then
                return 104 # entity is not directory
        fi

        ____parallel_control="${____parallel_control_directory}/control.txt"
        if [ ! -f "$____parallel_control" ]; then
                return 88 # entity is invalid
        fi

        if [ -z "$____parallel_available" ]; then
                ____parallel_available=$(getconf _NPROCESSORS_ONLN)
        fi


        # execute
        ____parallel_flags="${____parallel_control_directory}/flags"
        ____parallel_total=0


        # scan total tasks
        ____old_IFS="$IFS"
        while IFS= read -r ____line || [ -n "$____line" ]; do
                ____parallel_total=$(($____parallel_total + 1))
        done < "$____parallel_control"
        IFS="$____old_IFS" && unset ____old_IFS


        # bail early if no task is available
        if [ $____parallel_total -le 0 ]; then
                return 0 # ok
        fi


        # run in singular when only 1 task is required
        if [ $____parallel_available -le 1 ] || [ $____parallel_total -eq 1 ]; then
                ____old_IFS="$IFS"
                while IFS= read -r ____line || [ -n "$____line" ]; do
                        "$____parallel_command" "$____line"
                        if [ $? -ne 0 ]; then
                                return 1 # bad exec
                        fi
                done < "$____parallel_control"
                IFS="$____old_IFS" && unset ____old_IFS


                # report status
                return 0 # ok
        fi


        # run in parallel
        ____parallel_error=0
        ____parallel_done=0
        rm -rf "$____parallel_flags" &> /dev/null
        mkdir -p "$____parallel_flags" &> /dev/null
        while [ $____parallel_done -ne $____parallel_total ]; do
                ____parallel_done=0
                ____parallel_current=0
                ____parallel_working=0


                # scan state
                ____line_number=0
                ____old_IFS="$IFS"
                while IFS= read -r ____line || [ -n "$____line" ]; do
                        ____line_number=$(($____line_number + 1))
                        ____parallel_flag="${____parallel_flags}/l${____line_number}"


                        # skip if error flag is found
                        if [ -d "${____parallel_flag}_error" ]; then
                                ____parallel_error=$(($____parallel_error + 1))
                                continue
                        fi


                        # skip if working flag is found
                        if [ -d "${____parallel_flag}_working" ]; then
                                ____parallel_working=$(($____parallel_working + 1))
                                ____parallel_current=$(($____parallel_current + 1))
                                continue
                        fi


                        # break entire scan when run is completed
                        if [ $____parallel_done -ge $____parallel_total ]; then
                                break
                        fi


                        # skip if done flag is found
                        if [ -d "${____parallel_flag}_done" ]; then
                                ____parallel_done=$(($____parallel_done + 1))
                                ____parallel_current=$(($____parallel_current + 1))
                                continue
                        fi


                        # it's a working state
                        if [ $____parallel_working -lt $____parallel_available ]; then
                                # secure parallel working lock
                                mkdir -p "${____parallel_flag}_working"
                                ____parallel_working=$(($____parallel_working + 1))


                                # initiate parallel execution
                                {
                                        "$____parallel_command" $____line
                                        case $? in
                                        0)
                                                mkdir -p "${____parallel_flag}_done"
                                                ;;
                                        *)
                                                mkdir -p "${____parallel_flag}_error"
                                                ;;
                                        esac
                                        rm -rf "${____parallel_flag}_working" &> /dev/null
                                } &
                        fi

                        ____parallel_current=$(($____parallel_current + 1))
                done < "$____parallel_control"
                IFS="$____old_IFS" && unset ____old_IFS


                # stop the entire operation if error is detected and no more
                # running tasks
                if [ $____parallel_error -gt 0 ] && [ $____parallel_working -eq 0 ]; then
                        return 1 # bad exec
                fi
        done


        # report status
        return 0 # ok
}
################################################################################
# Unix Main Codes                                                              #
################################################################################
return 0
#>
