# Path to this scheduling script folder
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$ps1Path = Join-Path $scriptFolder "CloseRobloxSingleton.ps1"
$xmlPath = Join-Path $scriptFolder "ScheduleTask.xml"
$taskName = "Run Roblox Singleton Closer"

# Check required files
if (-not (Test-Path $ps1Path)) {
    Write-Error "Error: Could not find CloseRobloxSingleton.ps1 in $scriptFolder"
    exit 1
}

if (-not (Test-Path $xmlPath)) {
    Write-Error "Error: Could not find ScheduleTask.xml in $scriptFolder"
    exit 1
}

# Read XML template
$xmlContent = Get-Content $xmlPath -Raw

# Replace placeholders
$xmlContent = $xmlContent -replace '{{USERNAME}}', $env:USERNAME
$xmlContent = $xmlContent -replace '{{SCRIPT_PATH}}', ('-ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "' + $ps1Path + '"')

# Remove existing task if it exists
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    try {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Host "Existing scheduled task removed."
    } catch {
        Write-Error "Failed to remove existing scheduled task: $_"
        exit 1
    }
}

# Register task
try {
    Register-ScheduledTask -Xml $xmlContent -TaskName $taskName
    Write-Host "Scheduled task registered successfully."
} catch {
    Write-Error "Failed to register scheduled task: $_"
    exit 1
}

# Start task immediately
try {
    Start-ScheduledTask -TaskName $taskName
    Write-Host "Scheduled task started successfully."
} catch {
    Write-Error "Failed to start scheduled task: $_"
}