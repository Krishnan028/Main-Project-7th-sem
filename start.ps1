# Start Streamlit in the project venv (detached)
param(
    [int]$Port = 8502
)

$Root = Split-Path -Parent $MyInvocation.MyCommand.Definition
$AppDir = Join-Path $Root "SpamGANShield"
$Python = Join-Path $Root ".venv\Scripts\python.exe"
$Out = Join-Path $Root "streamlit_run.log"
$Err = Join-Path $Root "streamlit_err.log"

Write-Host "Starting Streamlit from $AppDir on port $Port using $Python"
Start-Process -FilePath $Python -ArgumentList '-m','streamlit','run','app.py','--server.address','127.0.0.1','--server.port',$Port,'--server.headless','true' -RedirectStandardOutput $Out -RedirectStandardError $Err -WorkingDirectory $AppDir -PassThru
Write-Host "Streamlit started (detached). Logs: $Out and $Err"