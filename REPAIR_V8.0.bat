@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 > nul

::===========================
::  YÖNETİCİ KONTROLÜ (GELİŞTİRİLMİŞ)
::===========================
net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo ╔═══════════════════════════════════════════════════════════╗
    echo ║                                                           ║
    echo ║         YÖNETİCİ YETKİSİ GEREKLİ                          ║
    echo ║                                                           ║
    echo ║   Bu program yönetici izniyle çalıştırılmalıdır.          ║
    echo ║   Lütfen UAC penceresinde "EVET" seçeneğine tıklayın.     ║
    echo ║                                                           ║
    echo ╚═══════════════════════════════════════════════════════════╝
    echo.
    timeout /t 2 /nobreak >nul
    
    :: PowerShell ile yönetici olarak yeniden başlat
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
color 0b
title BY OZAN - GELISMIS SISTEM BAKIM ARACI v8.0 (GUI + Admin)

::===========================
::  LOG KLASÖRÜ
::===========================
set "LOG=%USERPROFILE%\Logs\Repair"
if not exist "%LOG%" md "%LOG%"

::===========================
::  ANA MENÜ (GUI STİLİ)
::===========================
:MENU
cls
echo.
echo ╔═══════════════════════════════════════════════════════════════════════════╗
echo ║                                                                           ║
echo ║        ██████╗ ██╗   ██╗     ██████╗ ███████╗ █████╗ ███╗  ██╗            ║
echo ║        ██╔══██╗╚██╗ ██╔╝    ██╔═══██╗╚══███╔╝██╔══██╗████╗  ██║           ║
echo ║        ██████╔╝ ╚████╔╝     ██║   ██║  ███╔╝ ███████║██╔██╗ ██║           ║
echo ║        ██╔══██╗  ╚██╔╝      ██║   ██║ ███╔╝  ██╔══██║██║╚██╗██║           ║
echo ║        ██████╔╝   ██║       ╚██████╔╝███████╗██║  ██║██║ ╚████║           ║
echo ║        ╚═════╝    ╚═╝        ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝           ║
echo ║                                                                           ║
echo ║            GELİŞMİŞ WINDOWS BAKIM VE ONARIM ARACI v8.0                    ║
echo ║                                                                           ║
echo ╚═══════════════════════════════════════════════════════════════════════════╝
echo.
echo ┌───────────────────────────────────────────────────────────────────────────┐
echo │                         SİSTEM ONARIM ARAÇLARI                            │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │  [1]  Sistem Dosyası Onarımı (SFC /scannow)                               │
echo │  [2]  Windows İmaj Onarımı (DISM /RestoreHealth)                          │
echo │  [3]  DISM CheckHealth (Hızlı Kontrol)                                    │
echo │  [4]  DISM ScanHealth (Detaylı Tarama)                                    │
echo │  [5]  Disk Hataları Taraması (chkdsk C: /f /r)                            │
echo │  [6]  Bileşen Temizleme (StartComponentCleanup)                           │
echo │  [7]  Bileşen Deposu Analizi                                              │
echo │  [8]  SFC Yalnızca Doğrulama (Onarım Yapmadan)                            │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │                      SISTEM BİLGİ VE ARAÇLAR                              │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │  [9]  Ağ Sıfırlama (Winsock ^& DNS Flush)                                 │
echo │  [10] Boot Bilgisi Göster (bcdedit)                                       │
echo │  [11] Sistem Bilgisi Göster (systeminfo)                                  │
echo │  [12] Sürücü Doğrulayıcı Başlat (Driver Verifier)                         │
echo │  [13] Windows Defender Tehdit Geçmişi                                     │
echo │  [14] Sistem Geri Yükleme Başlat                                          │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │             TEMİZLİK VE OPTİMİZASYON                                      │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │  [15] Windows Update Cache Temizle                                        │
echo │  [16] Microsoft Store Cache Sıfırla                                       │
echo │  [17] Bloatware Kaldır (OneDrive, Xbox, Candy, vb.)                       │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │                         GELİŞMİŞ İŞLEMLER                                 │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │  [18] Hosts Dosyası İşlemleri (Yedekle/Geri Yükle/Reklam Engelle)         │
echo │  [19] Uzak Masaüstü Port ^& Firewall Ayarla                               │
echo │  [20] Hızlı Kapatma / Yeniden Başlatma                                    │
echo │  [21] BSOD Minidump Topla ve ZIP'le                                       │
echo ├───────────────────────────────────────────────────────────────────────────┤
echo │  [0]  ÇIKIŞ                                                               │
echo └───────────────────────────────────────────────────────────────────────────┘
echo.
set /p secim=" Seçiminiz (0-21): "

::----------- BAKIM ONARIM BLOKLARI -----------::
:: DÜZELTME NOTU: Tüm komutlar çift tırnak içine alındı.
if "%secim%"=="1"  call :WRAP 1  "SFC /scannow"                  "sfc /scannow"
if "%secim%"=="2"  call :WRAP 2  "DISM RestoreHealth"            "DISM /Online /Cleanup-Image /RestoreHealth"
if "%secim%"=="3"  call :WRAP 3  "DISM CheckHealth"              "DISM /Online /Cleanup-Image /CheckHealth"
if "%secim%"=="4"  call :WRAP 4  "DISM ScanHealth"               "DISM /Online /Cleanup-Image /ScanHealth"
if "%secim%"=="5"  call :WRAP 5  "chkdsk C: /f /r"               "chkdsk C: /f /r"
if "%secim%"=="6"  call :WRAP 6  "StartComponentCleanup"         "DISM /Online /Cleanup-Image /StartComponentCleanup"
if "%secim%"=="7"  call :WRAP 7  "AnalyzeComponentStore"         "DISM /Online /Cleanup-Image /AnalyzeComponentStore"
if "%secim%"=="8"  call :WRAP 8  "sfc /verifyonly"               "sfc /verifyonly"
if "%secim%"=="9"  call :WRAP 9  "Ag Sifirlama"                  "netsh winsock reset & ipconfig /flushdns"
if "%secim%"=="10" call :WRAP 10 "bcdedit /enum"                 "bcdedit /enum"
if "%secim%"=="11" call :WRAP 11 "systeminfo"                    "systeminfo"
if "%secim%"=="12" call :WRAP 12 "verifier"                      "verifier"
if "%secim%"=="13" call :WRAP 13 "Defender Gecmisi"              "powershell -NoLogo Get-MpThreatDetection"
if "%secim%"=="14" goto INFO_RESTORE
if "%secim%"=="15" call :WRAP 15 "WinUpdate Cache Temizle"       "call :UPDATE_CACHE_CLEAN"
if "%secim%"=="16" call :WRAP 16 "Store Cache Sifirla"           "wsreset.exe"
if "%secim%"=="17" call :WRAP 17 "Bloatware Kaldir"              "call :BLOAT_REMOVE"
if "%secim%"=="18" call :WRAP 18 "Hosts Islemleri"               "call :HOSTS_OPS"
if "%secim%"=="19" call :WRAP 19 "RDP Port & Firewall"           "call :RDP_PORT_FW"
if "%secim%"=="20" call :WRAP 20 "Hizli Shutdown / Reboot"       "call :FAST_POWER"
if "%secim%"=="21" call :WRAP 21 "BSOD Dump Topla"               "call :COLLECT_BSOD"
if "%secim%"=="22" call :WRAP 22 "Temp/Prefetch Temizle"         "call :TEMP_PREFETCH_CLEAN"
if "%secim%"=="0"  goto EXIT_PROGRAM
goto MENU

::----------------------------------------------------------
::  BAKIM MODÜLLERI
::----------------------------------------------------------
:UPDATE_CACHE_CLEAN
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  Windows Update Cache Temizleniyor...               │
echo └─────────────────────────────────────────────────────┘
>>"%LOG%\%DATE:~-4,4%-%DATE:~3,2%-%DATE:~0,2%.log" 2>&1 (
  sc stop wuauserv
  sc stop bits
  rd /s /q "%WINDIR%\SoftwareDistribution\Download"
  sc start bits
  sc start wuauserv
)
echo ✓ Update cache temizlendi.
goto :eof

:BLOAT_REMOVE
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  Bloatware Kaldırılıyor...                          │
echo └─────────────────────────────────────────────────────┘
>>"%LOG%\%DATE:~-4,4%-%DATE:~3,2%-%DATE:~0,2%.log" 2>&1 (
  powershell -NoLogo -ExecutionPolicy Bypass -Command "Get-AppxPackage *oneconnect* | Remove-AppxPackage; Get-AppxPackage *xbox* | Remove-AppxPackage; Get-AppxPackage *candy* | Remove-AppxPackage; Get-AppxPackage *spotify* | Remove-AppxPackage; Get-AppxPackage *tiktok* | Remove-AppxPackage"
)
echo ✓ Seçili bloatware kaldırıldı.
goto :eof

:HOSTS_OPS
cls
echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║            HOSTS DOSYASI İŞLEMLERİ                    ║
echo ╚═══════════════════════════════════════════════════════╝
echo.
echo  [1] Hosts dosyasını yedekle
echo  [2] Özgün hosts dosyasına geri yükle
echo  [3] Reklam-engel hosts indir (someonewhocares.org)
echo  [0] Ana menüye dön
echo.
set /p hst= Seçim: 
if "%hst%"=="1" (
    copy /Y "%WINDIR%\System32\drivers\etc\hosts" "%WINDIR%\System32\drivers\etc\hosts.bak" > nul
    echo ✓ Yedek oluşturuldu: hosts.bak
)
if "%hst%"=="2" (
    copy /Y "%WINDIR%\System32\drivers\etc\hosts.bak" "%WINDIR%\System32\drivers\etc\hosts" > nul
    echo ✓ Geri yüklendi.
)
if "%hst%"=="3" (
  powershell -NoLogo -Command "Invoke-WebRequest 'https://someonewhocares.org/hosts/zero/hosts' -OutFile '%WINDIR%\System32\drivers\etc\hosts'"
  echo ✓ Reklam-engel hosts indirildi.
)
pause
goto MENU

:RDP_PORT_FW
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  RDP Port ve Firewall Ayarları                      │
echo └─────────────────────────────────────────────────────┘
set /p yport= Yeni RDP portu (1024-65535): 
if "%yport%"=="" goto :eof
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD /d %yport% /f > nul
netsh advfirewall firewall add rule name="RDP Custom %yport%" dir=in action=allow protocol=TCP localport=%yport% > nul
echo ✓ RDP port %yport% olarak ayarlandı ve firewall kuralı eklendi.
goto :eof

:FAST_POWER
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  Hızlı Güç İşlemleri                                │
echo └─────────────────────────────────────────────────────┘
echo  [S] Hızlı Kapatma (Shutdown)
echo  [R] Hızlı Yeniden Başlatma (Reboot)
echo  [0] İptal
echo.
choice /C SR0 /N /M " Seçim: "
if errorlevel 3 goto :eof
if errorlevel 2 shutdown /r /f /t 0
if errorlevel 1 shutdown /s /f /t 0
goto :eof

:COLLECT_BSOD
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  BSOD Minidump Toplama                              │
echo └─────────────────────────────────────────────────────┘
set "zip=%USERPROFILE%\Desktop\BSOD_%DATE:~-4,4%%DATE:~3,2%%DATE:~0,2%.zip"
if not exist "%WINDIR%\Minidump" (
  echo ✗ Minidump klasörü bulunamadı.
  goto :eof
)
powershell -NoLogo -Command "Compress-Archive -Path '$env:WINDIR\Minidump\*' -DestinationPath '%zip%' -Force"
echo ✓ Minidump klasörü zip'lendi: %zip%
goto :eof

:TEMP_PREFETCH_CLEAN
echo.
echo ┌─────────────────────────────────────────────────────┐
echo │  TEMP ^& PREFETCH Klasörleri Temizleniyor...        │
echo └─────────────────────────────────────────────────────┘
echo.
set "tempCleanLog=%LOG%\TempClean_%DATE:~-4,4%%DATE:~3,2%%DATE:~0,2%.log"

>>"%tempCleanLog%" 2>&1 (
    echo [%DATE% %TIME%] Temp temizleme basladi
    
    REM Windows Temp klasörü
    echo ► Windows Temp temizleniyor: %TEMP%
    rd /s /q "%TEMP%" 2>nul
    md "%TEMP%" 2>nul
    
    echo ► Windows System Temp temizleniyor: %WINDIR%\Temp
    rd /s /q "%WINDIR%\Temp" 2>nul
    md "%WINDIR%\Temp" 2>nul
    
    REM Prefetch klasörü
    echo ► Prefetch temizleniyor: %WINDIR%\Prefetch
    del /f /s /q "%WINDIR%\Prefetch\*.*" 2>nul
    
    REM Ek temp konumları
    echo ► Kullanici Temp temizleniyor...
    del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
    
    REM Recent dosyalar
    echo ► Recent dosyalar temizleniyor...
    del /f /s /q "%USERPROFILE%\Recent\*.*" 2>nul
    
    echo [%DATE% %TIME%] Temp temizleme tamamlandi
)

echo.
echo ✓ Windows Temp: %TEMP% - Temizlendi
echo ✓ System Temp: %WINDIR%\Temp - Temizlendi
echo ✓ Prefetch: %WINDIR%\Prefetch - Temizlendi
echo ✓ User Temp: %USERPROFILE%\AppData\Local\Temp - Temizlendi
echo ✓ Recent Files - Temizlendi
echo.
echo ► Log dosyasi: %tempCleanLog%
goto :eof

::----------------------------------------------------------
::  YARDIMCI: WRAP + ONAY
::----------------------------------------------------------
:WRAP
setLocal
set "DESC=%~2"
set "CMD_RUN=%~3"

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║  İşlem: %DESC%
echo ╚═══════════════════════════════════════════════════════╝
call :onayla "%DESC%"
if errorlevel 1 (
  >> "%LOG%\%DATE:~-4,4%-%DATE:~3,2%-%DATE:~0,2%.log" echo [%DATE% %TIME%] %DESC% basliyor
  
  REM DÜZELTME NOTU: %* yerine direkt olarak 3. argümanı çalıştırıyoruz.
  %CMD_RUN%
  
  >> "%LOG%\%DATE:~-4,4%-%DATE:~3,2%-%DATE:~0,2%.log" echo [%DATE% %TIME%] %DESC% bitti
)
pause
endlocal & goto :eof

:onayla
set "evet="
set /p evet= ► %~1 çalıştırılsın mı? (E/H): 
if /i "%evet%"=="E" exit /b 1
echo ✗ İşlem iptal edildi.
exit /b 0

::----------------------------------------------------------
::  SİSTEM GERİ YÜKLEME
::----------------------------------------------------------
:INFO_RESTORE
start rstrui
goto MENU

::----------------------------------------------------------
::  ÇIKIŞ
::----------------------------------------------------------
:EXIT_PROGRAM
cls
echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║                                                       ║
echo ║     Sistem Bakım Aracı kapatılıyor...                 ║
echo ║     Ozan tarafından geliştirildi - 2025               ║
echo ║                                                       ║
echo ╚═══════════════════════════════════════════════════════╝
timeout /t 2 /nobreak >nul
exit /b

