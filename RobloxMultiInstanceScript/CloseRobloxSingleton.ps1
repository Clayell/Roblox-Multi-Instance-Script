# Configuration
$HandleExe   = "" # Put the path to handle.exe (https://learn.microsoft.com/en-us/sysinternals/downloads/handle) in between these quotes

# Variables
$ProcessName = "RobloxPlayerBeta.exe"
$EventName   = "ROBLOX_singletonEvent"
$PollingInterval = 1  # seconds between handle checks
$LogFile = Join-Path -Path $PSScriptRoot -ChildPath "CloseRobloxSingleton.txt"

# Clear log at start
"" | Out-File -FilePath $LogFile -Encoding UTF8

function Write-Log($message) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "$timestamp - $message"

    Add-Content -Path $LogFile -Value $line

    if ($Host.UI.RawUI) {
        Write-Host $line
    }
}

Write-Log "Persistent watcher started for $ProcessName."

# Single watcher for process creation
$query = "SELECT * FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA 'Win32_Process' AND TargetInstance.Name = '$ProcessName'"
$watcher = New-Object System.Management.ManagementEventWatcher $query

try {
    while ($true) {
        # Wait for a new process instance
        $event = $watcher.WaitForNextEvent()
        $processId = $event.TargetInstance.ProcessId
        Write-Log "$ProcessName launched. PID: $processId"

        # Poll handles until the event appears
        $handleClosed = $false
        while (-not $handleClosed) {
            $output = & $HandleExe -p $processId -a 2>$null
            $handles = foreach ($line in $output) {
                if ($line -match "^\s*([0-9A-F]+):\s+Event\s+.*$EventName") {
                    $matches[1]
                }
            }

            if ($handles) {
                foreach ($h in $handles) {
                    Write-Log "Closing handle $h for PID $processId."
                    & $HandleExe -c $h -p $processId -y
                }
                $handleClosed = $true
                Write-Log "Event handle closed for PID $processId."
            }

            Start-Sleep -Seconds $PollingInterval
        }
    }
} finally {
    $watcher.Stop()
    $watcher.Dispose()
    Write-Log "Watcher stopped."
}
