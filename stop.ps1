# Stop Streamlit by looking for a running python process started from the project venv
$Root = Split-Path -Parent $MyInvocation.MyCommand.Definition
$PythonName = Join-Path $Root ".venv\Scripts\python.exe"

$processes = Get-Process -Name python -ErrorAction SilentlyContinue | Where-Object {
    try {
        ($_.Path -eq $PythonName)
    } catch {
        $false
    }
}

if ($processes) {
    foreach ($p in $processes) {
        Write-Host "Stopping process Id $($p.Id) - $($p.ProcessName)"
        Stop-Process -Id $p.Id -Force
    }
} else {
    Write-Host "No running python processes from $PythonName found."
}